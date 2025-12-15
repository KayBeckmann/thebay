import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Endpoint für Favoriten-Verwaltung.
class FavoriteEndpoint extends Endpoint {
  /// Prüft ob der Benutzer eingeloggt ist und gibt die User-ID zurück.
  Future<int?> _getAuthenticatedUserId(Session session) async {
    final authInfo = await session.authenticated;
    return authInfo?.userId;
  }

  /// Fügt ein Angebot zu den Favoriten hinzu.
  Future<Favorite?> add(Session session, int listingId) async {
    final userId = await _getAuthenticatedUserId(session);
    if (userId == null) {
      throw Exception('Nicht authentifiziert');
    }

    // Prüfe ob Listing existiert und aktiv ist
    final listing = await Listing.db.findById(session, listingId);
    if (listing == null || !listing.isActive) {
      throw Exception('Angebot nicht gefunden oder nicht aktiv');
    }

    // Prüfe ob bereits favorisiert
    final existing = await Favorite.db.findFirstRow(
      session,
      where: (t) => t.userId.equals(userId) & t.listingId.equals(listingId),
    );

    if (existing != null) {
      return existing; // Bereits favorisiert
    }

    // Erstelle neuen Favoriten
    final favorite = Favorite(
      userId: userId,
      listingId: listingId,
      createdAt: DateTime.now(),
    );

    return await Favorite.db.insertRow(session, favorite);
  }

  /// Entfernt ein Angebot aus den Favoriten.
  Future<bool> remove(Session session, int listingId) async {
    final userId = await _getAuthenticatedUserId(session);
    if (userId == null) {
      throw Exception('Nicht authentifiziert');
    }

    final favorite = await Favorite.db.findFirstRow(
      session,
      where: (t) => t.userId.equals(userId) & t.listingId.equals(listingId),
    );

    if (favorite == null) {
      return false; // War nicht favorisiert
    }

    await Favorite.db.deleteRow(session, favorite);
    return true;
  }

  /// Prüft ob ein Angebot favorisiert ist.
  Future<bool> isFavorite(Session session, int listingId) async {
    final userId = await _getAuthenticatedUserId(session);
    if (userId == null) {
      return false;
    }

    final favorite = await Favorite.db.findFirstRow(
      session,
      where: (t) => t.userId.equals(userId) & t.listingId.equals(listingId),
    );

    return favorite != null;
  }

  /// Ruft alle Favoriten des Benutzers ab.
  Future<List<Listing>> getMyFavorites(Session session) async {
    final userId = await _getAuthenticatedUserId(session);
    if (userId == null) {
      throw Exception('Nicht authentifiziert');
    }

    final favorites = await Favorite.db.find(
      session,
      where: (t) => t.userId.equals(userId),
      orderBy: (t) => t.createdAt,
      orderDescending: true,
    );

    // Lade zugehörige Listings
    final listings = <Listing>[];
    for (final fav in favorites) {
      final listing = await Listing.db.findById(session, fav.listingId);
      if (listing != null && listing.isActive) {
        listings.add(listing);
      }
    }

    return listings;
  }

  /// Zählt die Anzahl der Favoriten eines Benutzers.
  Future<int> getCount(Session session) async {
    final userId = await _getAuthenticatedUserId(session);
    if (userId == null) {
      return 0;
    }

    final favorites = await Favorite.db.find(
      session,
      where: (t) => t.userId.equals(userId),
    );

    return favorites.length;
  }

  /// Prüft mehrere Listings auf Favoriten-Status (für Listen-Ansichten).
  Future<Map<int, bool>> checkMultiple(
      Session session, List<int> listingIds) async {
    final userId = await _getAuthenticatedUserId(session);
    if (userId == null) {
      return {for (var id in listingIds) id: false};
    }

    final favorites = await Favorite.db.find(
      session,
      where: (t) => t.userId.equals(userId),
    );

    final favoriteListingIds = favorites.map((f) => f.listingId).toSet();

    return {
      for (var id in listingIds) id: favoriteListingIds.contains(id),
    };
  }
}
