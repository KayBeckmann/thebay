import 'dart:typed_data';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/image_service.dart';

/// Endpoint für Listing-Bilder.
class ListingImageEndpoint extends Endpoint {
  final ImageService _imageService = ImageService();

  /// Maximale Anzahl Bilder pro Listing.
  static const int maxImagesPerListing = 3;

  /// Prüft ob der Benutzer eingeloggt ist und gibt die User-ID zurück.
  Future<int?> _getAuthenticatedUserId(Session session) async {
    final authInfo = await session.authenticated;
    return authInfo?.userId;
  }

  /// Prüft ob der Benutzer der Eigentümer des Listings ist.
  Future<bool> _isListingOwner(Session session, int listingId) async {
    final userId = await _getAuthenticatedUserId(session);
    if (userId == null) return false;

    final listing = await Listing.db.findById(session, listingId);
    if (listing == null) return false;

    return listing.userId == userId;
  }

  /// Lädt ein Bild für ein Listing hoch.
  /// Gibt das erstellte ListingImage-Objekt zurück.
  Future<ListingImage?> upload(
    Session session, {
    required int listingId,
    required String originalFileName,
    required Uint8List imageData,
  }) async {
    // Prüfe Authentifizierung
    final userId = await _getAuthenticatedUserId(session);
    if (userId == null) {
      throw Exception('Nicht authentifiziert');
    }

    // Prüfe Eigentümer
    if (!await _isListingOwner(session, listingId)) {
      throw Exception('Keine Berechtigung');
    }

    // Prüfe Anzahl bestehender Bilder
    final existingImages = await ListingImage.db.find(
      session,
      where: (t) => t.listingId.equals(listingId),
    );

    if (existingImages.length >= maxImagesPerListing) {
      throw Exception('Maximale Anzahl von $maxImagesPerListing Bildern erreicht');
    }

    // Prüfe Dateiendung
    if (!_imageService.isAllowedExtension(originalFileName)) {
      throw Exception(
        'Nicht erlaubtes Dateiformat. Erlaubt: JPG, PNG, WebP, GIF',
      );
    }

    // Komprimiere das Bild
    final result = await _imageService.compressImage(imageData, originalFileName);
    if (result == null) {
      throw Exception('Bild konnte nicht verarbeitet werden');
    }

    // Generiere Dateinamen und speichere
    final fileName = _imageService.generateFileName(result.extension);
    final relativePath = await _imageService.saveImage(result.bytes, fileName);

    // Bestimme sortOrder (nächste freie Position)
    final sortOrder = existingImages.length;

    // Erstelle Datenbankeintrag
    final listingImage = ListingImage(
      listingId: listingId,
      fileName: relativePath,
      originalName: originalFileName,
      mimeType: result.mimeType,
      sizeBytes: result.bytes.length,
      sortOrder: sortOrder,
      createdAt: DateTime.now(),
    );

    return await ListingImage.db.insertRow(session, listingImage);
  }

  /// Ruft alle Bilder eines Listings ab.
  Future<List<ListingImage>> getByListing(Session session, int listingId) async {
    return await ListingImage.db.find(
      session,
      where: (t) => t.listingId.equals(listingId),
      orderBy: (t) => t.sortOrder,
    );
  }

  /// Ruft die Bild-Daten ab (für Anzeige).
  Future<Uint8List?> getImageData(Session session, int imageId) async {
    final image = await ListingImage.db.findById(session, imageId);
    if (image == null) {
      return null;
    }

    return await _imageService.readImage(image.fileName);
  }

  /// Ruft die Bild-Daten über den Dateinamen ab.
  Future<Uint8List?> getImageDataByPath(Session session, String relativePath) async {
    return await _imageService.readImage(relativePath);
  }

  /// Löscht ein Bild.
  Future<bool> delete(Session session, int imageId) async {
    final userId = await _getAuthenticatedUserId(session);
    if (userId == null) {
      throw Exception('Nicht authentifiziert');
    }

    final image = await ListingImage.db.findById(session, imageId);
    if (image == null) {
      throw Exception('Bild nicht gefunden');
    }

    // Prüfe Eigentümer
    if (!await _isListingOwner(session, image.listingId)) {
      throw Exception('Keine Berechtigung');
    }

    // Lösche Datei
    await _imageService.deleteImage(image.fileName);

    // Lösche Datenbankeintrag
    await ListingImage.db.deleteRow(session, image);

    // Aktualisiere sortOrder der verbleibenden Bilder
    await _reorderImages(session, image.listingId);

    return true;
  }

  /// Ändert die Reihenfolge der Bilder.
  Future<bool> reorder(
    Session session, {
    required int listingId,
    required List<int> imageIds,
  }) async {
    final userId = await _getAuthenticatedUserId(session);
    if (userId == null) {
      throw Exception('Nicht authentifiziert');
    }

    // Prüfe Eigentümer
    if (!await _isListingOwner(session, listingId)) {
      throw Exception('Keine Berechtigung');
    }

    // Hole alle Bilder des Listings
    final images = await ListingImage.db.find(
      session,
      where: (t) => t.listingId.equals(listingId),
    );

    // Prüfe ob alle IDs gültig sind
    final existingIds = images.map((i) => i.id).toSet();
    for (final id in imageIds) {
      if (!existingIds.contains(id)) {
        throw Exception('Ungültige Bild-ID: $id');
      }
    }

    // Aktualisiere sortOrder
    for (var i = 0; i < imageIds.length; i++) {
      final image = images.firstWhere((img) => img.id == imageIds[i]);
      image.sortOrder = i;
      await ListingImage.db.updateRow(session, image);
    }

    return true;
  }

  /// Setzt das Hauptbild (sortOrder = 0).
  Future<bool> setMainImage(Session session, int imageId) async {
    final userId = await _getAuthenticatedUserId(session);
    if (userId == null) {
      throw Exception('Nicht authentifiziert');
    }

    final image = await ListingImage.db.findById(session, imageId);
    if (image == null) {
      throw Exception('Bild nicht gefunden');
    }

    // Prüfe Eigentümer
    if (!await _isListingOwner(session, image.listingId)) {
      throw Exception('Keine Berechtigung');
    }

    // Hole alle Bilder und ordne neu
    final images = await ListingImage.db.find(
      session,
      where: (t) => t.listingId.equals(image.listingId),
      orderBy: (t) => t.sortOrder,
    );

    // Setze das gewählte Bild an Position 0
    final newOrder = <int>[imageId];
    for (final img in images) {
      if (img.id != imageId) {
        newOrder.add(img.id!);
      }
    }

    return await reorder(
      session,
      listingId: image.listingId,
      imageIds: newOrder,
    );
  }

  /// Hilfsmethode: Aktualisiert sortOrder nach Löschung.
  Future<void> _reorderImages(Session session, int listingId) async {
    final images = await ListingImage.db.find(
      session,
      where: (t) => t.listingId.equals(listingId),
      orderBy: (t) => t.sortOrder,
    );

    for (var i = 0; i < images.length; i++) {
      if (images[i].sortOrder != i) {
        images[i].sortOrder = i;
        await ListingImage.db.updateRow(session, images[i]);
      }
    }
  }

  /// Löscht alle Bilder eines Listings.
  Future<int> deleteAllForListing(Session session, int listingId) async {
    final userId = await _getAuthenticatedUserId(session);
    if (userId == null) {
      throw Exception('Nicht authentifiziert');
    }

    // Prüfe Eigentümer
    if (!await _isListingOwner(session, listingId)) {
      throw Exception('Keine Berechtigung');
    }

    final images = await ListingImage.db.find(
      session,
      where: (t) => t.listingId.equals(listingId),
    );

    for (final image in images) {
      await _imageService.deleteImage(image.fileName);
      await ListingImage.db.deleteRow(session, image);
    }

    return images.length;
  }
}
