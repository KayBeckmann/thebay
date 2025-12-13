import 'dart:io';
import 'dart:typed_data';

import 'package:image/image.dart' as img;
import 'package:mime/mime.dart';
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';

/// Service für Bildverarbeitung und -speicherung.
class ImageService {
  static const _uuid = Uuid();

  /// Maximale Dateigröße nach Komprimierung (300 KB).
  static const int maxFileSizeBytes = 300 * 1024;

  /// Erlaubte MIME-Typen.
  static const allowedMimeTypes = [
    'image/jpeg',
    'image/png',
    'image/webp',
    'image/gif',
  ];

  /// Erlaubte Dateiendungen.
  static const allowedExtensions = [
    '.jpg',
    '.jpeg',
    '.png',
    '.webp',
    '.gif',
  ];

  /// Basis-Verzeichnis für Uploads.
  final String uploadDirectory;

  ImageService({String? uploadDir})
      : uploadDirectory = uploadDir ?? '/app/uploads/images';

  /// Prüft ob der MIME-Typ erlaubt ist.
  bool isAllowedMimeType(String? mimeType) {
    if (mimeType == null) return false;
    return allowedMimeTypes.contains(mimeType.toLowerCase());
  }

  /// Prüft ob die Dateiendung erlaubt ist.
  bool isAllowedExtension(String filename) {
    final ext = path.extension(filename).toLowerCase();
    return allowedExtensions.contains(ext);
  }

  /// Ermittelt den MIME-Typ aus den Datei-Bytes.
  String? getMimeType(Uint8List bytes, String filename) {
    // Versuche MIME-Typ aus Bytes zu ermitteln
    final mimeType = lookupMimeType(filename, headerBytes: bytes);
    return mimeType;
  }

  /// Komprimiert ein Bild auf maximal [maxFileSizeBytes].
  /// Gibt die komprimierten Bytes und den neuen MIME-Typ zurück.
  Future<ImageResult?> compressImage(
    Uint8List bytes,
    String originalFilename,
  ) async {
    final mimeType = getMimeType(bytes, originalFilename);

    if (!isAllowedMimeType(mimeType)) {
      throw ImageException('Nicht erlaubter Dateityp: $mimeType');
    }

    // Wenn bereits klein genug, nicht komprimieren
    if (bytes.length <= maxFileSizeBytes) {
      return ImageResult(
        bytes: bytes,
        mimeType: mimeType!,
        extension: _getExtensionForMimeType(mimeType),
      );
    }

    // Dekodiere das Bild
    final image = img.decodeImage(bytes);
    if (image == null) {
      throw ImageException('Bild konnte nicht dekodiert werden');
    }

    // GIFs nicht komprimieren (Animation würde verloren gehen)
    if (mimeType == 'image/gif') {
      // Nur Größe reduzieren wenn nötig
      if (bytes.length > maxFileSizeBytes) {
        final resized = _resizeImage(image, maxDimension: 800);
        final encoded = img.encodeGif(resized);
        return ImageResult(
          bytes: Uint8List.fromList(encoded),
          mimeType: 'image/gif',
          extension: '.gif',
        );
      }
      return ImageResult(
        bytes: bytes,
        mimeType: mimeType!,
        extension: '.gif',
      );
    }

    // Für andere Formate: Zu JPEG konvertieren und komprimieren
    var quality = 85;
    var compressed = bytes;
    var currentImage = image;

    // Zuerst Größe reduzieren wenn sehr groß
    if (image.width > 1920 || image.height > 1920) {
      currentImage = _resizeImage(image, maxDimension: 1920);
    }

    // Iterativ Qualität reduzieren bis Zielgröße erreicht
    while (compressed.length > maxFileSizeBytes && quality > 20) {
      compressed = Uint8List.fromList(
        img.encodeJpg(currentImage, quality: quality),
      );
      quality -= 10;
    }

    // Falls immer noch zu groß, Bildgröße weiter reduzieren
    if (compressed.length > maxFileSizeBytes) {
      currentImage = _resizeImage(currentImage, maxDimension: 1280);
      quality = 75;
      while (compressed.length > maxFileSizeBytes && quality > 20) {
        compressed = Uint8List.fromList(
          img.encodeJpg(currentImage, quality: quality),
        );
        quality -= 10;
      }
    }

    // Letzte Chance: Noch kleiner machen
    if (compressed.length > maxFileSizeBytes) {
      currentImage = _resizeImage(currentImage, maxDimension: 800);
      compressed = Uint8List.fromList(
        img.encodeJpg(currentImage, quality: 60),
      );
    }

    return ImageResult(
      bytes: compressed,
      mimeType: 'image/jpeg',
      extension: '.jpg',
    );
  }

  /// Reduziert die Bildgröße proportional.
  img.Image _resizeImage(img.Image image, {required int maxDimension}) {
    if (image.width <= maxDimension && image.height <= maxDimension) {
      return image;
    }

    int newWidth;
    int newHeight;

    if (image.width > image.height) {
      newWidth = maxDimension;
      newHeight = (image.height * maxDimension / image.width).round();
    } else {
      newHeight = maxDimension;
      newWidth = (image.width * maxDimension / image.height).round();
    }

    return img.copyResize(image, width: newWidth, height: newHeight);
  }

  /// Gibt die Dateiendung für einen MIME-Typ zurück.
  String _getExtensionForMimeType(String mimeType) {
    switch (mimeType) {
      case 'image/jpeg':
        return '.jpg';
      case 'image/png':
        return '.png';
      case 'image/webp':
        return '.webp';
      case 'image/gif':
        return '.gif';
      default:
        return '.jpg';
    }
  }

  /// Generiert einen einzigartigen Dateinamen.
  String generateFileName(String extension) {
    final uuid = _uuid.v4();
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    return '${timestamp}_$uuid$extension';
  }

  /// Speichert ein Bild im Dateisystem.
  Future<String> saveImage(Uint8List bytes, String fileName) async {
    // Erstelle Unterverzeichnisse basierend auf Datum
    final now = DateTime.now();
    final subDir = '${now.year}/${now.month.toString().padLeft(2, '0')}';
    final fullDir = '$uploadDirectory/$subDir';

    // Erstelle Verzeichnis falls nicht vorhanden
    final directory = Directory(fullDir);
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }

    // Speichere Datei
    final filePath = '$fullDir/$fileName';
    final file = File(filePath);
    await file.writeAsBytes(bytes);

    // Gib relativen Pfad zurück (für Datenbank)
    return '$subDir/$fileName';
  }

  /// Liest ein Bild aus dem Dateisystem.
  Future<Uint8List?> readImage(String relativePath) async {
    final filePath = '$uploadDirectory/$relativePath';
    final file = File(filePath);

    if (!await file.exists()) {
      return null;
    }

    return await file.readAsBytes();
  }

  /// Löscht ein Bild aus dem Dateisystem.
  Future<bool> deleteImage(String relativePath) async {
    final filePath = '$uploadDirectory/$relativePath';
    final file = File(filePath);

    if (!await file.exists()) {
      return false;
    }

    await file.delete();
    return true;
  }

  /// Gibt den vollständigen Pfad für einen relativen Pfad zurück.
  String getFullPath(String relativePath) {
    return '$uploadDirectory/$relativePath';
  }
}

/// Ergebnis einer Bildkomprimierung.
class ImageResult {
  final Uint8List bytes;
  final String mimeType;
  final String extension;

  ImageResult({
    required this.bytes,
    required this.mimeType,
    required this.extension,
  });
}

/// Exception für Bildfehler.
class ImageException implements Exception {
  final String message;
  ImageException(this.message);

  @override
  String toString() => 'ImageException: $message';
}
