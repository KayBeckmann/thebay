import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Endpoint für User-Slots (gekaufte Anzeigen-Slots).
class UserSlotEndpoint extends Endpoint {
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

  /// Ruft alle Slots des aktuellen Benutzers ab.
  Future<List<UserSlot>> getMySlots(Session session) async {
    final userId = await _getAuthenticatedUserId(session);
    if (userId == null) {
      throw Exception('Nicht authentifiziert');
    }

    return await UserSlot.db.find(
      session,
      where: (t) => t.userId.equals(userId),
      orderBy: (t) => t.expiresAt,
    );
  }

  /// Ruft nur verfügbare (ungenutzte, aktive) Slots ab.
  Future<List<UserSlot>> getAvailableSlots(Session session) async {
    final userId = await _getAuthenticatedUserId(session);
    if (userId == null) {
      throw Exception('Nicht authentifiziert');
    }

    final now = DateTime.now();
    final slots = await UserSlot.db.find(
      session,
      where: (t) =>
          t.userId.equals(userId) & t.isActive.equals(true) & t.isUsed.equals(false),
      orderBy: (t) => t.expiresAt,
    );

    // Filtere abgelaufene
    return slots.where((slot) => slot.expiresAt.isAfter(now)).toList();
  }

  /// Ruft Slots ab, die in den nächsten X Tagen ablaufen (für Warnungen).
  Future<List<UserSlot>> getExpiringSoon(Session session, {int days = 3}) async {
    final userId = await _getAuthenticatedUserId(session);
    if (userId == null) {
      throw Exception('Nicht authentifiziert');
    }

    final now = DateTime.now();
    final threshold = now.add(Duration(days: days));

    final slots = await UserSlot.db.find(
      session,
      where: (t) => t.userId.equals(userId) & t.isActive.equals(true) & t.isUsed.equals(true),
    );

    // Filtere nach Ablaufdatum
    return slots.where((slot) {
      return slot.expiresAt.isAfter(now) && slot.expiresAt.isBefore(threshold);
    }).toList();
  }

  /// Erstellt einen Slot für einen Benutzer (Admin-Funktion oder nach Zahlung).
  /// Diese Methode wird intern nach erfolgreicher Zahlung aufgerufen.
  Future<UserSlot?> createSlot(
    Session session, {
    required int userId,
    required int slotVariantId,
  }) async {
    // Prüfe ob Admin oder interner Aufruf
    final isAdmin = await _isAdmin(session);
    if (!isAdmin) {
      throw Exception('Keine Berechtigung');
    }

    // Hole die Slot-Variante für die Laufzeit
    final variant = await SlotVariant.db.findById(session, slotVariantId);
    if (variant == null) {
      throw Exception('Slot-Variante nicht gefunden');
    }

    final now = DateTime.now();
    final expiresAt = now.add(Duration(days: variant.durationDays));

    final slot = UserSlot(
      userId: userId,
      slotVariantId: slotVariantId,
      listingId: null,
      purchasedAt: now,
      expiresAt: expiresAt,
      isActive: true,
      isUsed: false,
    );

    return await UserSlot.db.insertRow(session, slot);
  }

  /// Verlängert einen bestehenden Slot.
  Future<UserSlot?> extendSlot(
    Session session, {
    required int slotId,
    required int additionalDays,
  }) async {
    final userId = await _getAuthenticatedUserId(session);
    if (userId == null) {
      throw Exception('Nicht authentifiziert');
    }

    final slot = await UserSlot.db.findById(session, slotId);
    if (slot == null) {
      throw Exception('Slot nicht gefunden');
    }

    // Nur der Eigentümer oder Admin darf verlängern
    final isAdmin = await _isAdmin(session);
    if (slot.userId != userId && !isAdmin) {
      throw Exception('Keine Berechtigung');
    }

    // Verlängere ab aktuellem Ablaufdatum oder ab jetzt (falls abgelaufen)
    final now = DateTime.now();
    final baseDate = slot.expiresAt.isAfter(now) ? slot.expiresAt : now;
    slot.expiresAt = baseDate.add(Duration(days: additionalDays));
    slot.isActive = true;

    // Wenn ein Angebot verknüpft ist, aktualisiere auch dessen Ablaufdatum
    if (slot.listingId != null) {
      final listing = await Listing.db.findById(session, slot.listingId!);
      if (listing != null) {
        listing.expiresAt = slot.expiresAt;
        listing.isActive = true;
        listing.updatedAt = now;
        await Listing.db.updateRow(session, listing);
      }
    }

    return await UserSlot.db.updateRow(session, slot);
  }

  /// Deaktiviert abgelaufene Slots und deren Angebote.
  /// Sollte regelmäßig als Cron-Job ausgeführt werden.
  Future<int> deactivateExpired(Session session) async {
    // Nur Admin darf diese Funktion ausführen
    final isAdmin = await _isAdmin(session);
    if (!isAdmin) {
      throw Exception('Keine Berechtigung');
    }

    final now = DateTime.now();
    int count = 0;

    // Finde alle aktiven Slots
    final activeSlots = await UserSlot.db.find(
      session,
      where: (t) => t.isActive.equals(true),
    );

    for (final slot in activeSlots) {
      if (slot.expiresAt.isBefore(now)) {
        slot.isActive = false;
        await UserSlot.db.updateRow(session, slot);

        // Deaktiviere auch das verknüpfte Angebot
        if (slot.listingId != null) {
          final listing = await Listing.db.findById(session, slot.listingId!);
          if (listing != null && listing.isActive) {
            listing.isActive = false;
            listing.updatedAt = now;
            await Listing.db.updateRow(session, listing);
          }
        }
        count++;
      }
    }

    return count;
  }

  /// Gibt Statistiken über Slots zurück.
  Future<Map<String, int>> getSlotStats(Session session) async {
    final userId = await _getAuthenticatedUserId(session);
    if (userId == null) {
      throw Exception('Nicht authentifiziert');
    }

    final now = DateTime.now();
    final slots = await UserSlot.db.find(
      session,
      where: (t) => t.userId.equals(userId),
    );

    int total = slots.length;
    int active = 0;
    int used = 0;
    int available = 0;
    int expired = 0;

    for (final slot in slots) {
      if (slot.expiresAt.isBefore(now)) {
        expired++;
      } else if (slot.isActive) {
        active++;
        if (slot.isUsed) {
          used++;
        } else {
          available++;
        }
      }
    }

    return {
      'total': total,
      'active': active,
      'used': used,
      'available': available,
      'expired': expired,
    };
  }

  /// Admin: Grant a free promotional slot to a user.
  /// This method allows admins to directly grant free slots without payment.
  Future<UserSlot?> grantFreeSlot(
    Session session, {
    required int userId,
    required int slotVariantId,
  }) async {
    // Only admins can grant free slots
    if (!await _isAdmin(session)) {
      throw Exception('Nur Administratoren können kostenlose Slots vergeben');
    }

    // Get the slot variant
    final variant = await SlotVariant.db.findById(session, slotVariantId);
    if (variant == null) {
      throw Exception('Slot-Variante nicht gefunden');
    }

    // Verify it's a free slot
    if (!variant.isFree) {
      throw Exception('Diese Slot-Variante ist nicht als kostenlos markiert');
    }

    // Check if user exists
    final user = await User.db.findById(session, userId);
    if (user == null) {
      throw Exception('Benutzer nicht gefunden');
    }

    // Create the slot
    final now = DateTime.now();
    final expiresAt = now.add(Duration(days: variant.durationDays));

    final slot = UserSlot(
      userId: userId,
      slotVariantId: slotVariantId,
      listingId: null,
      purchasedAt: now,
      expiresAt: expiresAt,
      isActive: true,
      isUsed: false,
    );

    return await UserSlot.db.insertRow(session, slot);
  }
}
