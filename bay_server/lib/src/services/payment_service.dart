import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Service für Zahlungsverarbeitung (PayPal, Bitcoin).
class PaymentService {
  /// PayPal Sandbox oder Production URL
  static const String paypalSandboxUrl =
      'https://ipnpb.sandbox.paypal.com/cgi-bin/webscr';
  static const String paypalProductionUrl =
      'https://ipnpb.paypal.com/cgi-bin/webscr';

  /// BlockCypher API URL für Bitcoin
  static const String blockCypherBaseUrl = 'https://api.blockcypher.com/v1/btc/main';

  /// Verifiziert eine PayPal IPN-Nachricht.
  /// Gibt true zurück, wenn die Nachricht gültig ist.
  static Future<bool> verifyPayPalIpn(
    Map<String, String> ipnData, {
    bool sandbox = false,
  }) async {
    try {
      // Füge cmd=_notify-validate hinzu
      final verifyData = Map<String, String>.from(ipnData);
      verifyData['cmd'] = '_notify-validate';

      // Sende die Daten zurück an PayPal zur Verifizierung
      final url = sandbox ? paypalSandboxUrl : paypalProductionUrl;
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: verifyData,
      );

      // PayPal antwortet mit "VERIFIED" oder "INVALID"
      return response.body == 'VERIFIED';
    } catch (e) {
      return false;
    }
  }

  /// Verarbeitet eine verifizierte PayPal-Zahlung.
  static Future<bool> processPayPalPayment(
    Session session,
    Map<String, String> ipnData,
  ) async {
    // Extrahiere relevante Daten
    final paymentStatus = ipnData['payment_status'];
    final txnId = ipnData['txn_id'];
    final customData = ipnData['custom']; // Enthält unsere Order-ID
    final mcGross = ipnData['mc_gross'];
    final mcCurrency = ipnData['mc_currency'];
    final receiverEmail = ipnData['receiver_email'];

    // Prüfe ob Zahlung abgeschlossen ist
    if (paymentStatus != 'Completed') {
      session.log('PayPal IPN: Zahlung nicht abgeschlossen: $paymentStatus');
      return false;
    }

    // Parse die Order-ID aus custom
    if (customData == null) {
      session.log('PayPal IPN: Keine Order-ID in custom gefunden');
      return false;
    }

    final orderId = int.tryParse(customData);
    if (orderId == null) {
      session.log('PayPal IPN: Ungültige Order-ID: $customData');
      return false;
    }

    // Hole die Bestellung
    final order = await SlotOrder.db.findById(session, orderId);
    if (order == null) {
      session.log('PayPal IPN: Bestellung nicht gefunden: $orderId');
      return false;
    }

    // Prüfe ob Bestellung noch ausstehend ist
    if (order.status != OrderStatus.pending) {
      session.log('PayPal IPN: Bestellung nicht ausstehend: ${order.status}');
      return false;
    }

    // Prüfe den Betrag
    final expectedAmount = (order.amountCents / 100).toStringAsFixed(2);
    if (mcGross != expectedAmount) {
      session.log(
        'PayPal IPN: Betrag stimmt nicht überein. '
        'Erwartet: $expectedAmount, Erhalten: $mcGross',
      );
      return false;
    }

    // Prüfe Währung
    if (mcCurrency != 'USD') {
      session.log('PayPal IPN: Ungültige Währung: $mcCurrency');
      return false;
    }

    // Prüfe Empfänger-Email
    final paypalEmail = await _getPayPalEmail(session);
    if (paypalEmail != null &&
        receiverEmail?.toLowerCase() != paypalEmail.toLowerCase()) {
      session.log(
        'PayPal IPN: Empfänger stimmt nicht überein. '
        'Erwartet: $paypalEmail, Erhalten: $receiverEmail',
      );
      return false;
    }

    // Alles ok - aktiviere den Slot
    return await _completeOrder(session, order, txnId ?? 'paypal_$orderId');
  }

  /// Prüft den Status einer Bitcoin-Transaktion via BlockCypher API.
  static Future<Map<String, dynamic>?> checkBitcoinTransaction(
    String txHash, {
    String? apiToken,
  }) async {
    try {
      var url = '$blockCypherBaseUrl/txs/$txHash';
      if (apiToken != null) {
        url += '?token=$apiToken';
      }

      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  /// Prüft Bitcoin-Zahlungen für ausstehende Bestellungen.
  static Future<int> checkPendingBitcoinPayments(
    Session session, {
    String? blockCypherToken,
  }) async {
    // Hole alle ausstehenden Bitcoin-Bestellungen
    final pendingOrders = await SlotOrder.db.find(
      session,
      where: (t) =>
          t.status.equals(OrderStatus.pending) &
          t.paymentMethod.equals(PaymentMethod.bitcoin),
    );

    int processedCount = 0;

    for (final order in pendingOrders) {
      // Prüfe ob eine Transaktions-ID hinterlegt ist
      if (order.transactionId == null || order.transactionId!.isEmpty) {
        continue;
      }

      // Prüfe den Transaktionsstatus
      final txInfo = await checkBitcoinTransaction(
        order.transactionId!,
        apiToken: blockCypherToken,
      );

      if (txInfo == null) {
        continue;
      }

      // Prüfe Bestätigungen (mindestens 1)
      final confirmations = txInfo['confirmations'] as int? ?? 0;
      if (confirmations < 1) {
        continue;
      }

      // Prüfe ob die Transaktion erfolgreich war
      final confirmed = txInfo['confirmed'] != null;
      if (!confirmed) {
        continue;
      }

      // Aktiviere den Slot
      final success = await _completeOrder(
        session,
        order,
        order.transactionId!,
      );

      if (success) {
        processedCount++;
      }
    }

    return processedCount;
  }

  /// Generiert Zahlungsinformationen für eine Bestellung.
  static Future<Map<String, dynamic>> getPaymentInfo(
    Session session,
    SlotOrder order,
  ) async {
    final variant = await SlotVariant.db.findById(session, order.slotVariantId);

    if (order.paymentMethod == PaymentMethod.paypal) {
      final paypalEmail = await _getPayPalEmail(session);
      return {
        'method': 'paypal',
        'email': paypalEmail ?? '',
        'amount': (order.amountCents / 100).toStringAsFixed(2),
        'currency': 'USD',
        'orderId': order.id,
        'description': variant?.name ?? 'Slot',
      };
    } else {
      final bitcoinWallet = await _getBitcoinWallet(session);
      // Berechne BTC-Betrag (vereinfacht - in Produktion sollte ein aktueller Kurs verwendet werden)
      final btcAmount = await convertUsdToBtc(order.amountCents / 100);
      return {
        'method': 'bitcoin',
        'address': bitcoinWallet ?? '',
        'amountUsd': (order.amountCents / 100).toStringAsFixed(2),
        'amountBtc': btcAmount.toStringAsFixed(8),
        'orderId': order.id,
        'memo': 'Order-${order.id}',
        'description': variant?.name ?? 'Slot',
      };
    }
  }

  /// Holt die PayPal-Email aus den Settings.
  static Future<String?> _getPayPalEmail(Session session) async {
    final setting = await Settings.db.findFirstRow(
      session,
      where: (t) => t.key.equals('payment.paypal.email'),
    );
    return setting?.value;
  }

  /// Holt die Bitcoin-Wallet-Adresse aus den Settings.
  static Future<String?> _getBitcoinWallet(Session session) async {
    final setting = await Settings.db.findFirstRow(
      session,
      where: (t) => t.key.equals('payment.bitcoin.wallet'),
    );
    return setting?.value;
  }

  /// Konvertiert USD zu BTC.
  /// Holt den aktuellen Kurs von CoinGecko.
  static Future<double> convertUsdToBtc(double usd) async {
    try {
      // Hole aktuellen BTC-Preis von CoinGecko
      final response = await http.get(
        Uri.parse(
          'https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=usd',
        ),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final btcPrice = data['bitcoin']['usd'] as num;
        return usd / btcPrice;
      }
    } catch (e) {
      // Fallback: Verwende einen geschätzten Preis
    }

    // Fallback-Preis (sollte in Produktion nicht verwendet werden)
    return usd / 40000;
  }

  /// Schließt eine Bestellung ab und erstellt den Slot.
  static Future<bool> _completeOrder(
    Session session,
    SlotOrder order,
    String transactionId,
  ) async {
    final now = DateTime.now();

    // Aktualisiere die Bestellung
    order.status = OrderStatus.paid;
    order.paidAt = now;
    order.transactionId = transactionId;
    await SlotOrder.db.updateRow(session, order);

    // Hole die Slot-Variante
    final variant = await SlotVariant.db.findById(session, order.slotVariantId);
    if (variant == null) {
      session.log('PaymentService: Slot-Variante nicht gefunden');
      return false;
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

    session.log(
      'PaymentService: Bestellung ${order.id} abgeschlossen, '
      'Slot erstellt (läuft ab: $expiresAt)',
    );

    return true;
  }
}
