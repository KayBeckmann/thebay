import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Endpoint für Slot-Bestellungen (Kaufvorgänge).
class SlotOrderEndpoint extends Endpoint {
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

  /// Erstellt eine neue Bestellung für einen Slot.
  Future<SlotOrder?> create(
    Session session, {
    required int slotVariantId,
    required PaymentMethod paymentMethod,
  }) async {
    final userId = await _getAuthenticatedUserId(session);
    if (userId == null) {
      throw Exception('Nicht authentifiziert');
    }

    // Hole die Slot-Variante
    final variant = await SlotVariant.db.findById(session, slotVariantId);
    if (variant == null) {
      throw Exception('Slot-Variante nicht gefunden');
    }

    if (!variant.isActive) {
      throw Exception('Slot-Variante nicht verfügbar');
    }

    // Prüfe ob Zahlungsmethode erlaubt ist
    if (paymentMethod == PaymentMethod.paypal && !variant.allowPaypal) {
      throw Exception('PayPal nicht erlaubt für diese Variante');
    }
    if (paymentMethod == PaymentMethod.bitcoin && !variant.allowBitcoin) {
      throw Exception('Bitcoin nicht erlaubt für diese Variante');
    }

    final now = DateTime.now();

    final order = SlotOrder(
      userId: userId,
      slotVariantId: slotVariantId,
      paymentMethod: paymentMethod,
      amountCents: variant.priceUsdCents,
      status: OrderStatus.pending,
      createdAt: now,
    );

    return await SlotOrder.db.insertRow(session, order);
  }

  /// Ruft alle Bestellungen des aktuellen Benutzers ab.
  Future<List<SlotOrder>> getMyOrders(Session session) async {
    final userId = await _getAuthenticatedUserId(session);
    if (userId == null) {
      throw Exception('Nicht authentifiziert');
    }

    return await SlotOrder.db.find(
      session,
      where: (t) => t.userId.equals(userId),
      orderBy: (t) => t.createdAt,
      orderDescending: true,
    );
  }

  /// Ruft ausstehende Bestellungen des Benutzers ab.
  Future<List<SlotOrder>> getPendingOrders(Session session) async {
    final userId = await _getAuthenticatedUserId(session);
    if (userId == null) {
      throw Exception('Nicht authentifiziert');
    }

    return await SlotOrder.db.find(
      session,
      where: (t) =>
          t.userId.equals(userId) & t.status.equals(OrderStatus.pending),
      orderBy: (t) => t.createdAt,
      orderDescending: true,
    );
  }

  /// Ruft eine einzelne Bestellung ab.
  Future<SlotOrder?> getById(Session session, int id) async {
    final userId = await _getAuthenticatedUserId(session);
    if (userId == null) {
      throw Exception('Nicht authentifiziert');
    }

    final order = await SlotOrder.db.findById(session, id);
    if (order == null) {
      return null;
    }

    // Nur eigene Bestellungen oder Admin
    final isAdmin = await _isAdmin(session);
    if (order.userId != userId && !isAdmin) {
      throw Exception('Keine Berechtigung');
    }

    return order;
  }

  /// Storniert eine Bestellung (nur wenn noch pending).
  Future<bool> cancel(Session session, int id) async {
    final userId = await _getAuthenticatedUserId(session);
    if (userId == null) {
      throw Exception('Nicht authentifiziert');
    }

    final order = await SlotOrder.db.findById(session, id);
    if (order == null) {
      throw Exception('Bestellung nicht gefunden');
    }

    // Nur eigene Bestellungen
    if (order.userId != userId) {
      throw Exception('Keine Berechtigung');
    }

    if (order.status != OrderStatus.pending) {
      throw Exception('Nur ausstehende Bestellungen können storniert werden');
    }

    order.status = OrderStatus.cancelled;
    await SlotOrder.db.updateRow(session, order);

    return true;
  }

  /// Markiert eine Bestellung als bezahlt und aktiviert den Slot.
  /// In der Produktion wird dies durch die Zahlungs-Webhooks aufgerufen.
  Future<SlotOrder?> markAsPaid(
    Session session, {
    required int orderId,
    String? transactionId,
  }) async {
    // Für Test-Zwecke: Benutzer kann selbst bezahlen markieren
    // In Produktion: Nur durch Webhook oder Admin
    final userId = await _getAuthenticatedUserId(session);
    if (userId == null) {
      throw Exception('Nicht authentifiziert');
    }

    final order = await SlotOrder.db.findById(session, orderId);
    if (order == null) {
      throw Exception('Bestellung nicht gefunden');
    }

    // Prüfe Berechtigung (eigene Bestellung oder Admin)
    final isAdmin = await _isAdmin(session);
    if (order.userId != userId && !isAdmin) {
      throw Exception('Keine Berechtigung');
    }

    if (order.status != OrderStatus.pending) {
      throw Exception('Bestellung ist nicht ausstehend');
    }

    final now = DateTime.now();

    // Aktualisiere Bestellung
    order.status = OrderStatus.paid;
    order.paidAt = now;
    order.transactionId = transactionId;
    await SlotOrder.db.updateRow(session, order);

    // Erstelle den Slot
    final variant = await SlotVariant.db.findById(session, order.slotVariantId);
    if (variant == null) {
      throw Exception('Slot-Variante nicht gefunden');
    }

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

    return order;
  }

  /// Admin: Ruft alle Bestellungen ab.
  Future<List<SlotOrder>> getAllOrders(Session session) async {
    final isAdmin = await _isAdmin(session);
    if (!isAdmin) {
      throw Exception('Keine Berechtigung');
    }

    return await SlotOrder.db.find(
      session,
      orderBy: (t) => t.createdAt,
      orderDescending: true,
      limit: 100,
    );
  }

  /// Läuft abgelaufene ausstehende Bestellungen ab (älter als 24 Stunden).
  Future<int> expireOldOrders(Session session) async {
    final isAdmin = await _isAdmin(session);
    if (!isAdmin) {
      throw Exception('Keine Berechtigung');
    }

    final cutoff = DateTime.now().subtract(const Duration(hours: 24));

    final pendingOrders = await SlotOrder.db.find(
      session,
      where: (t) => t.status.equals(OrderStatus.pending),
    );

    int count = 0;
    for (final order in pendingOrders) {
      if (order.createdAt.isBefore(cutoff)) {
        order.status = OrderStatus.expired;
        await SlotOrder.db.updateRow(session, order);
        count++;
      }
    }

    return count;
  }
}
