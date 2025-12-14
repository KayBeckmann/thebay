import 'dart:async';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Service der abgelaufene Slots und deren Angebote deaktiviert.
/// Läuft alle Stunde im Hintergrund.
class SlotExpirationService {
  /// Intervall in Stunden für die Ausführung
  static const int intervalHours = 1;

  static Timer? _timer;

  /// Startet den Service (beim Server-Start aufrufen).
  static Future<void> start(Serverpod pod) async {
    // Führe sofort aus
    await _runExpiration(pod);

    // Starte Timer für periodische Ausführung
    _timer = Timer.periodic(
      const Duration(hours: intervalHours),
      (_) => _runExpiration(pod),
    );

    // ignore: avoid_print
    print('SlotExpirationService: Gestartet (Intervall: $intervalHours Stunde(n))');
  }

  /// Stoppt den Service.
  static void stop() {
    _timer?.cancel();
    _timer = null;
  }

  static Future<void> _runExpiration(Serverpod pod) async {
    final session = await pod.createSession();
    try {
      session.log('SlotExpirationService: Starte Deaktivierung abgelaufener Slots...');

      final now = DateTime.now();
      int deactivatedSlots = 0;
      int deactivatedListings = 0;

      // Finde alle aktiven Slots
      final activeSlots = await UserSlot.db.find(
        session,
        where: (t) => t.isActive.equals(true),
      );

      for (final slot in activeSlots) {
        if (slot.expiresAt.isBefore(now)) {
          // Deaktiviere den Slot
          slot.isActive = false;
          await UserSlot.db.updateRow(session, slot);
          deactivatedSlots++;

          // Deaktiviere auch das verknüpfte Angebot
          if (slot.listingId != null) {
            final listing = await Listing.db.findById(session, slot.listingId!);
            if (listing != null && listing.isActive) {
              listing.isActive = false;
              listing.updatedAt = now;
              await Listing.db.updateRow(session, listing);
              deactivatedListings++;
            }
          }
        }
      }

      // Expire alte ausstehende Bestellungen (älter als 24h)
      final cutoff = now.subtract(const Duration(hours: 24));
      final pendingOrders = await SlotOrder.db.find(
        session,
        where: (t) => t.status.equals(OrderStatus.pending),
      );

      int expiredOrders = 0;
      for (final order in pendingOrders) {
        if (order.createdAt.isBefore(cutoff)) {
          order.status = OrderStatus.expired;
          await SlotOrder.db.updateRow(session, order);
          expiredOrders++;
        }
      }

      session.log(
        'SlotExpirationService: Fertig. '
        'Deaktiviert: $deactivatedSlots Slots, $deactivatedListings Angebote, '
        '$expiredOrders Bestellungen abgelaufen.',
      );
    } catch (e) {
      session.log('SlotExpirationService: Fehler: $e');
    } finally {
      await session.close();
    }
  }
}
