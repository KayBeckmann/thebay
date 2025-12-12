import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Endpoint für Angebote (Listings).
class ListingEndpoint extends Endpoint {
  /// Prüft ob der Benutzer eingeloggt ist und gibt die User-ID zurück.
  Future<int?> _getAuthenticatedUserId(Session session) async {
    final authInfo = await session.authenticated;
    return authInfo?.userId;
  }

  /// Erstellt ein neues Angebot.
  /// Verbraucht automatisch einen verfügbaren Slot.
  Future<Listing?> create(
    Session session, {
    required int categoryId,
    required String title,
    required String description,
    required double quantity,
    required QuantityUnit quantityUnit,
    required int pricePerUnit,
    required bool acceptsPaypal,
    required bool acceptsBitcoin,
    required bool hasShipping,
    String? shippingMethod,
    int? shippingCostCents,
  }) async {
    final userId = await _getAuthenticatedUserId(session);
    if (userId == null) {
      throw Exception('Nicht authentifiziert');
    }

    // Prüfe ob mindestens eine Zahlungsmethode akzeptiert wird
    if (!acceptsPaypal && !acceptsBitcoin) {
      throw Exception('Mindestens eine Zahlungsmethode muss akzeptiert werden');
    }

    // Prüfe ob die Kategorie existiert
    final category = await Category.db.findById(session, categoryId);
    if (category == null) {
      throw Exception('Kategorie nicht gefunden');
    }

    // Finde einen verfügbaren (ungenutzten, aktiven) Slot
    final availableSlots = await UserSlot.db.find(
      session,
      where: (t) =>
          t.userId.equals(userId) & t.isActive.equals(true) & t.isUsed.equals(false),
      orderBy: (t) => t.expiresAt,
      limit: 1,
    );

    if (availableSlots.isEmpty) {
      throw Exception('Keine verfügbaren Slots. Bitte kaufe zuerst einen Slot.');
    }

    final slot = availableSlots.first;
    final now = DateTime.now();

    // Erstelle das Angebot
    final listing = Listing(
      userId: userId,
      categoryId: categoryId,
      title: title,
      description: description,
      quantity: quantity,
      quantityUnit: quantityUnit,
      pricePerUnit: pricePerUnit,
      acceptsPaypal: acceptsPaypal,
      acceptsBitcoin: acceptsBitcoin,
      hasShipping: hasShipping,
      shippingMethod: shippingMethod,
      shippingCostCents: shippingCostCents,
      isActive: true,
      expiresAt: slot.expiresAt,
      createdAt: now,
      updatedAt: now,
    );

    final createdListing = await Listing.db.insertRow(session, listing);

    // Verknüpfe den Slot mit dem Angebot
    slot.listingId = createdListing.id;
    slot.isUsed = true;
    await UserSlot.db.updateRow(session, slot);

    return createdListing;
  }

  /// Aktualisiert ein bestehendes Angebot.
  Future<Listing?> update(
    Session session, {
    required int id,
    int? categoryId,
    String? title,
    String? description,
    double? quantity,
    QuantityUnit? quantityUnit,
    int? pricePerUnit,
    bool? acceptsPaypal,
    bool? acceptsBitcoin,
    bool? hasShipping,
    String? shippingMethod,
    int? shippingCostCents,
  }) async {
    final userId = await _getAuthenticatedUserId(session);
    if (userId == null) {
      throw Exception('Nicht authentifiziert');
    }

    final listing = await Listing.db.findById(session, id);
    if (listing == null) {
      throw Exception('Angebot nicht gefunden');
    }

    // Nur der Eigentümer darf bearbeiten
    if (listing.userId != userId) {
      throw Exception('Keine Berechtigung');
    }

    // Prüfe Kategorie falls geändert
    if (categoryId != null) {
      final category = await Category.db.findById(session, categoryId);
      if (category == null) {
        throw Exception('Kategorie nicht gefunden');
      }
      listing.categoryId = categoryId;
    }

    // Aktualisiere Felder
    if (title != null) listing.title = title;
    if (description != null) listing.description = description;
    if (quantity != null) listing.quantity = quantity;
    if (quantityUnit != null) listing.quantityUnit = quantityUnit;
    if (pricePerUnit != null) listing.pricePerUnit = pricePerUnit;
    if (acceptsPaypal != null) listing.acceptsPaypal = acceptsPaypal;
    if (acceptsBitcoin != null) listing.acceptsBitcoin = acceptsBitcoin;
    if (hasShipping != null) listing.hasShipping = hasShipping;
    if (shippingMethod != null) listing.shippingMethod = shippingMethod;
    if (shippingCostCents != null) listing.shippingCostCents = shippingCostCents;

    // Prüfe ob mindestens eine Zahlungsmethode akzeptiert wird
    if (!listing.acceptsPaypal && !listing.acceptsBitcoin) {
      throw Exception('Mindestens eine Zahlungsmethode muss akzeptiert werden');
    }

    listing.updatedAt = DateTime.now();
    return await Listing.db.updateRow(session, listing);
  }

  /// Löscht ein Angebot (deaktiviert es).
  Future<bool> delete(Session session, int id) async {
    final userId = await _getAuthenticatedUserId(session);
    if (userId == null) {
      throw Exception('Nicht authentifiziert');
    }

    final listing = await Listing.db.findById(session, id);
    if (listing == null) {
      throw Exception('Angebot nicht gefunden');
    }

    // Nur der Eigentümer darf löschen
    if (listing.userId != userId) {
      throw Exception('Keine Berechtigung');
    }

    // Deaktiviere das Angebot
    listing.isActive = false;
    listing.updatedAt = DateTime.now();
    await Listing.db.updateRow(session, listing);

    // Gib den Slot wieder frei
    final slots = await UserSlot.db.find(
      session,
      where: (t) => t.listingId.equals(id),
    );
    for (final slot in slots) {
      slot.listingId = null;
      slot.isUsed = false;
      await UserSlot.db.updateRow(session, slot);
    }

    return true;
  }

  /// Ruft ein einzelnes Angebot ab.
  Future<Listing?> getById(Session session, int id) async {
    return await Listing.db.findById(session, id);
  }

  /// Ruft aktive Angebote ab (mit Pagination).
  Future<List<Listing>> getActive(
    Session session, {
    int? categoryId,
    int limit = 25,
    int offset = 0,
  }) async {
    final now = DateTime.now();

    // Hole alle aktiven Angebote
    final listings = await Listing.db.find(
      session,
      where: (t) => t.isActive.equals(true),
      orderBy: (t) => t.createdAt,
      orderDescending: true,
      limit: limit,
      offset: offset,
    );

    // Filtere nach Kategorie und Ablaufdatum
    return listings.where((listing) {
      // Prüfe Ablaufdatum
      if (listing.expiresAt != null && listing.expiresAt!.isBefore(now)) {
        return false;
      }
      // Prüfe Kategorie
      if (categoryId != null && listing.categoryId != categoryId) {
        return false;
      }
      return true;
    }).toList();
  }

  /// Ruft die eigenen Angebote des Benutzers ab.
  Future<List<Listing>> getMyListings(Session session) async {
    final userId = await _getAuthenticatedUserId(session);
    if (userId == null) {
      throw Exception('Nicht authentifiziert');
    }

    return await Listing.db.find(
      session,
      where: (t) => t.userId.equals(userId),
      orderBy: (t) => t.createdAt,
      orderDescending: true,
    );
  }

  /// Ruft Angebote eines bestimmten Benutzers ab (nur aktive).
  Future<List<Listing>> getByUser(Session session, int userId) async {
    final now = DateTime.now();

    final listings = await Listing.db.find(
      session,
      where: (t) => t.userId.equals(userId) & t.isActive.equals(true),
      orderBy: (t) => t.createdAt,
      orderDescending: true,
    );

    // Filtere abgelaufene
    return listings.where((listing) {
      if (listing.expiresAt != null && listing.expiresAt!.isBefore(now)) {
        return false;
      }
      return true;
    }).toList();
  }

  /// Zählt verfügbare Slots eines Benutzers.
  Future<int> getAvailableSlotCount(Session session) async {
    final userId = await _getAuthenticatedUserId(session);
    if (userId == null) {
      throw Exception('Nicht authentifiziert');
    }

    final now = DateTime.now();
    final slots = await UserSlot.db.find(
      session,
      where: (t) =>
          t.userId.equals(userId) & t.isActive.equals(true) & t.isUsed.equals(false),
    );

    // Filtere abgelaufene Slots
    return slots.where((slot) => slot.expiresAt.isAfter(now)).length;
  }
}
