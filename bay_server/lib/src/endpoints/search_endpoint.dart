import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Endpoint für die Suche nach Angeboten.
class SearchEndpoint extends Endpoint {
  /// Sucht nach Angeboten mit optionalen Filtern.
  ///
  /// [query] - Suchbegriff (durchsucht Titel und Beschreibung)
  /// [categoryId] - Optional: Filtert nach Hauptkategorie (inkl. Subkategorien)
  /// [subcategoryId] - Optional: Filtert nach spezifischer Subkategorie
  /// [acceptsPaypal] - Optional: Nur PayPal-Angebote
  /// [acceptsBitcoin] - Optional: Nur Bitcoin-Angebote
  /// [page] - Seitennummer (0-basiert)
  /// [pageSize] - Anzahl pro Seite (Standard: 25)
  Future<SearchResult> search(
    Session session, {
    String? query,
    int? categoryId,
    int? subcategoryId,
    bool? acceptsPaypal,
    bool? acceptsBitcoin,
    int page = 0,
    int pageSize = 25,
  }) async {
    final now = DateTime.now();

    // Bestimme die zu suchenden Kategorie-IDs
    List<int>? categoryIds;
    if (subcategoryId != null) {
      categoryIds = [subcategoryId];
    } else if (categoryId != null) {
      final subcategories = await Category.db.find(
        session,
        where: (t) => t.parentId.equals(categoryId),
      );
      categoryIds = [categoryId, ...subcategories.map((c) => c.id!)];
    }

    // Hole alle aktiven Listings mit DB-Filtern
    var listings = await Listing.db.find(
      session,
      where: (t) {
        var condition = t.isActive.equals(true);

        // Zahlungsmethoden-Filter
        if (acceptsPaypal == true) {
          condition = condition & t.acceptsPaypal.equals(true);
        }
        if (acceptsBitcoin == true) {
          condition = condition & t.acceptsBitcoin.equals(true);
        }

        return condition;
      },
      orderBy: (t) => t.createdAt,
      orderDescending: true,
    );

    // Filtere lokal nach Ablaufdatum
    listings = listings.where((listing) {
      if (listing.expiresAt != null && listing.expiresAt!.isBefore(now)) {
        return false;
      }
      return true;
    }).toList();

    // Filtere lokal nach Kategorie
    if (categoryIds != null) {
      listings = listings.where((listing) {
        return categoryIds!.contains(listing.categoryId);
      }).toList();
    }

    // Filtere lokal nach Suchbegriff (case-insensitive)
    if (query != null && query.trim().isNotEmpty) {
      final lowerQuery = query.trim().toLowerCase();
      listings = listings.where((listing) {
        return listing.title.toLowerCase().contains(lowerQuery) ||
            listing.description.toLowerCase().contains(lowerQuery);
      }).toList();
    }

    // Berechne Pagination
    final totalCount = listings.length;
    final offset = page * pageSize;
    final paginatedListings = listings.skip(offset).take(pageSize).toList();

    return SearchResult(
      listings: paginatedListings,
      totalCount: totalCount,
      page: page,
      pageSize: pageSize,
      hasMore: (page + 1) * pageSize < totalCount,
    );
  }

  /// Schnellsuche - nur Titel, optimiert für Autocomplete.
  Future<List<Listing>> quickSearch(
    Session session,
    String query, {
    int limit = 10,
  }) async {
    if (query.trim().isEmpty) return [];

    final now = DateTime.now();
    final lowerQuery = query.trim().toLowerCase();

    // Hole aktive Listings
    var listings = await Listing.db.find(
      session,
      where: (t) => t.isActive.equals(true),
      orderBy: (t) => t.createdAt,
      orderDescending: true,
    );

    // Filtere lokal
    return listings
        .where((listing) {
          // Ablaufdatum prüfen
          if (listing.expiresAt != null && listing.expiresAt!.isBefore(now)) {
            return false;
          }
          // Titel durchsuchen
          return listing.title.toLowerCase().contains(lowerQuery);
        })
        .take(limit)
        .toList();
  }

  /// Zählt die Gesamtanzahl aktiver Listings.
  Future<int> countActive(Session session) async {
    final now = DateTime.now();

    final listings = await Listing.db.find(
      session,
      where: (t) => t.isActive.equals(true),
    );

    return listings.where((listing) {
      if (listing.expiresAt != null && listing.expiresAt!.isBefore(now)) {
        return false;
      }
      return true;
    }).length;
  }
}
