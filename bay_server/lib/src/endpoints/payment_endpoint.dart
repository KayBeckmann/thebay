import 'dart:io';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/payment_service.dart';

/// Endpoint für Zahlungsverarbeitung.
class PaymentEndpoint extends Endpoint {
  /// Prüft ob der Benutzer eingeloggt ist und gibt die User-ID zurück.
  Future<int?> _getAuthenticatedUserId(Session session) async {
    final authInfo = await session.authenticated;
    return authInfo?.userId;
  }

  /// Prüft ob der Benutzer Admin ist.
  Future<bool> _isAdmin(Session session) async {
    final authInfo = await session.authenticated;
    if (authInfo == null) return false;
    final user = await User.db.findById(session, authInfo.userId);
    return user?.role == UserRole.admin;
  }

  /// Verarbeitet eine PayPal IPN-Nachricht.
  /// Diese Methode wird von PayPal aufgerufen (kein Auth erforderlich).
  Future<String> handlePayPalIpn(
    Session session,
    Map<String, String> ipnData,
  ) async {
    session.log('PayPal IPN empfangen: ${ipnData.keys.join(", ")}');

    // Verifiziere die IPN-Nachricht
    // In Produktion: sandbox = false
    final isValid = await PaymentService.verifyPayPalIpn(
      ipnData,
      sandbox: true, // TODO: Aus Konfiguration lesen
    );

    if (!isValid) {
      session.log('PayPal IPN: Verifizierung fehlgeschlagen');
      return 'INVALID';
    }

    // Verarbeite die Zahlung
    final success = await PaymentService.processPayPalPayment(session, ipnData);

    if (success) {
      session.log('PayPal IPN: Zahlung erfolgreich verarbeitet');
      return 'OK';
    } else {
      session.log('PayPal IPN: Zahlung konnte nicht verarbeitet werden');
      return 'ERROR';
    }
  }

  /// Aktualisiert die Bitcoin-Transaktions-ID für eine Bestellung.
  /// Der Benutzer gibt die TX-Hash nach der Zahlung ein.
  Future<bool> setBitcoinTransactionId(
    Session session, {
    required int orderId,
    required String transactionId,
  }) async {
    final userId = await _getAuthenticatedUserId(session);
    if (userId == null) {
      throw Exception('Nicht authentifiziert');
    }

    final order = await SlotOrder.db.findById(session, orderId);
    if (order == null) {
      throw Exception('Bestellung nicht gefunden');
    }

    // Nur eigene Bestellungen
    if (order.userId != userId) {
      throw Exception('Keine Berechtigung');
    }

    // Nur ausstehende Bitcoin-Bestellungen
    if (order.status != OrderStatus.pending) {
      throw Exception('Bestellung ist nicht ausstehend');
    }

    if (order.paymentMethod != PaymentMethod.bitcoin) {
      throw Exception('Keine Bitcoin-Bestellung');
    }

    // Speichere die Transaktions-ID
    order.transactionId = transactionId.trim();
    await SlotOrder.db.updateRow(session, order);

    session.log(
      'Bitcoin TX-ID gesetzt für Bestellung $orderId: $transactionId',
    );

    return true;
  }

  /// Prüft ausstehende Bitcoin-Zahlungen (Admin-Funktion).
  Future<int> checkPendingBitcoinPayments(Session session) async {
    if (!await _isAdmin(session)) {
      throw Exception('Keine Berechtigung');
    }

    // BlockCypher Token aus Settings holen (optional)
    final tokenSetting = await Settings.db.findFirstRow(
      session,
      where: (t) => t.key.equals('payment.blockcypher.token'),
    );

    final processed = await PaymentService.checkPendingBitcoinPayments(
      session,
      blockCypherToken: tokenSetting?.value,
      electrumHost: Platform.environment['ELECTRUM_HOST'],
      electrumPort: int.tryParse(Platform.environment['ELECTRUM_PORT'] ?? ''),
      electrumUseSsl:
          (Platform.environment['ELECTRUM_SSL'] ?? 'false').toLowerCase() ==
              'true',
      electrumTimeout: Duration(
        milliseconds: int.tryParse(
              Platform.environment['ELECTRUM_TIMEOUT_MS'] ?? '',
            ) ??
            10000,
      ),
    );

    session.log('Bitcoin-Zahlungen geprüft: $processed verarbeitet');
    return processed;
  }

  /// Holt Zahlungsinformationen für eine Bestellung.
  Future<Map<String, dynamic>> getPaymentInfo(
    Session session,
    int orderId,
  ) async {
    final userId = await _getAuthenticatedUserId(session);
    if (userId == null) {
      throw Exception('Nicht authentifiziert');
    }

    final order = await SlotOrder.db.findById(session, orderId);
    if (order == null) {
      throw Exception('Bestellung nicht gefunden');
    }

    // Nur eigene Bestellungen oder Admin
    final isAdmin = await _isAdmin(session);
    if (order.userId != userId && !isAdmin) {
      throw Exception('Keine Berechtigung');
    }

    return await PaymentService.getPaymentInfo(session, order);
  }

  /// Manuelle Zahlungsbestätigung (Admin-Funktion).
  /// Für Fälle, in denen die automatische Verarbeitung fehlschlägt.
  Future<bool> confirmPaymentManually(
    Session session, {
    required int orderId,
    String? transactionId,
  }) async {
    if (!await _isAdmin(session)) {
      throw Exception('Keine Berechtigung');
    }

    final order = await SlotOrder.db.findById(session, orderId);
    if (order == null) {
      throw Exception('Bestellung nicht gefunden');
    }

    if (order.status != OrderStatus.pending) {
      throw Exception('Bestellung ist nicht ausstehend');
    }

    final now = DateTime.now();

    // Aktualisiere die Bestellung
    order.status = OrderStatus.paid;
    order.paidAt = now;
    order.transactionId = transactionId ?? 'manual_${now.millisecondsSinceEpoch}';
    await SlotOrder.db.updateRow(session, order);

    // Hole die Slot-Variante
    final variant = await SlotVariant.db.findById(session, order.slotVariantId);
    if (variant == null) {
      throw Exception('Slot-Variante nicht gefunden');
    }

    // Erstelle den Slot
    final expiresAt = now.add(Duration(days: variant.durationDays));
    final slot = UserSlot(
      userId: order.userId,
      slotVariantId: order.slotVariantId,
      listingId: null,
      purchasedAt: now,
      expiresAt: expiresAt,
      isActive: true,
      isUsed: false,
    );

    await UserSlot.db.insertRow(session, slot);

    // Markiere Bestellung als abgeschlossen
    order.status = OrderStatus.completed;
    order.completedAt = now;
    await SlotOrder.db.updateRow(session, order);

    session.log('Zahlung manuell bestätigt für Bestellung $orderId');

    return true;
  }

  /// Holt den aktuellen BTC/USD-Kurs.
  Future<double?> getBtcUsdRate(Session session) async {
    final btcPerUsd = await PaymentService.convertUsdToBtc(1.0);
    return 1 / btcPerUsd;
  }
}
