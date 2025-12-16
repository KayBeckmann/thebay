import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Endpoint für PGP Key Management.
class PgpKeyEndpoint extends Endpoint {
  /// Prüft ob der Benutzer eingeloggt ist und gibt die User-ID zurück.
  Future<int?> _getAuthenticatedUserId(Session session) async {
    final authInfo = await session.authenticated;
    return authInfo?.userId;
  }

  /// Lädt den Public Key eines Benutzers zum Server hoch.
  /// Validiert das Key-Format und extrahiert Metadaten.
  Future<UserPublicKey?> uploadPublicKey(
    Session session,
    String publicKeyArmored,
    String keyIdentity,
    String fingerprint,
    String algorithm,
    int keySize,
  ) async {
    final userId = await _getAuthenticatedUserId(session);
    if (userId == null) {
      throw Exception('Nicht authentifiziert');
    }

    // Validiere Key-Format (muss mit -----BEGIN PGP PUBLIC KEY BLOCK----- beginnen)
    if (!publicKeyArmored.contains('-----BEGIN PGP PUBLIC KEY BLOCK-----')) {
      throw Exception('Ungültiges PGP Public Key Format');
    }

    // Deaktiviere vorhandene Keys des Users
    final existingKeys = await UserPublicKey.db.find(
      session,
      where: (t) => t.userId.equals(userId) & t.isActive.equals(true),
    );

    for (final key in existingKeys) {
      key.isActive = false;
      key.updatedAt = DateTime.now();
      await UserPublicKey.db.updateRow(session, key);
    }

    // Erstelle neuen Key
    final now = DateTime.now();
    final publicKey = UserPublicKey(
      userId: userId,
      publicKeyArmored: publicKeyArmored,
      fingerprint: fingerprint.toUpperCase().replaceAll(' ', ''),
      algorithm: algorithm,
      keySize: keySize,
      keyIdentity: keyIdentity,
      isActive: true,
      createdAt: now,
      updatedAt: now,
    );

    return await UserPublicKey.db.insertRow(session, publicKey);
  }

  /// Ruft den aktiven Public Key des eingeloggten Benutzers ab.
  Future<UserPublicKey?> getMyPublicKey(Session session) async {
    final userId = await _getAuthenticatedUserId(session);
    if (userId == null) {
      throw Exception('Nicht authentifiziert');
    }

    return await UserPublicKey.db.findFirstRow(
      session,
      where: (t) => t.userId.equals(userId) & t.isActive.equals(true),
    );
  }

  /// Ruft den Public Key eines Benutzers per User-ID ab.
  Future<UserPublicKey?> getPublicKey(Session session, int userId) async {
    final authUserId = await _getAuthenticatedUserId(session);
    if (authUserId == null) {
      throw Exception('Nicht authentifiziert');
    }

    return await UserPublicKey.db.findFirstRow(
      session,
      where: (t) => t.userId.equals(userId) & t.isActive.equals(true),
    );
  }

  /// Ruft den Public Key eines Benutzers per Username ab.
  Future<UserPublicKey?> getPublicKeyByUsername(
    Session session,
    String username,
  ) async {
    final authUserId = await _getAuthenticatedUserId(session);
    if (authUserId == null) {
      throw Exception('Nicht authentifiziert');
    }

    // Finde User per Username
    final user = await User.db.findFirstRow(
      session,
      where: (t) => t.username.equals(username),
    );

    if (user == null) {
      return null;
    }

    return await UserPublicKey.db.findFirstRow(
      session,
      where: (t) => t.userId.equals(user.id!) & t.isActive.equals(true),
    );
  }

  /// Prüft ob ein Benutzer einen aktiven Public Key hat.
  Future<bool> hasPublicKey(Session session, int? userId) async {
    final authUserId = await _getAuthenticatedUserId(session);
    if (authUserId == null) {
      throw Exception('Nicht authentifiziert');
    }

    final targetUserId = userId ?? authUserId;

    final key = await UserPublicKey.db.findFirstRow(
      session,
      where: (t) => t.userId.equals(targetUserId) & t.isActive.equals(true),
    );

    return key != null;
  }

  /// Deaktiviert den aktuellen Key des Benutzers.
  Future<bool> deactivateKey(Session session) async {
    final userId = await _getAuthenticatedUserId(session);
    if (userId == null) {
      throw Exception('Nicht authentifiziert');
    }

    final key = await UserPublicKey.db.findFirstRow(
      session,
      where: (t) => t.userId.equals(userId) & t.isActive.equals(true),
    );

    if (key == null) {
      return false;
    }

    key.isActive = false;
    key.updatedAt = DateTime.now();
    await UserPublicKey.db.updateRow(session, key);
    return true;
  }

  /// Ruft Key-Metadaten ab (ohne den eigentlichen Key).
  Future<Map<String, dynamic>?> getKeyMetadata(Session session) async {
    final userId = await _getAuthenticatedUserId(session);
    if (userId == null) {
      throw Exception('Nicht authentifiziert');
    }

    final key = await UserPublicKey.db.findFirstRow(
      session,
      where: (t) => t.userId.equals(userId) & t.isActive.equals(true),
    );

    if (key == null) {
      return null;
    }

    return {
      'fingerprint': key.fingerprint,
      'algorithm': key.algorithm,
      'keySize': key.keySize,
      'keyIdentity': key.keyIdentity,
      'createdAt': key.createdAt.toIso8601String(),
    };
  }

  // === Encrypted Key Backup (Optional) ===

  /// Lädt ein verschlüsseltes Private Key Backup hoch.
  /// WARNUNG: Der Server speichert nur den verschlüsselten Key.
  /// Die Entschlüsselung erfolgt ausschließlich auf dem Client.
  Future<EncryptedKeyBackup?> uploadEncryptedBackup(
    Session session,
    String encryptedPrivateKey,
    String fingerprint,
    String encryptionSalt,
    String kdfParams,
  ) async {
    final userId = await _getAuthenticatedUserId(session);
    if (userId == null) {
      throw Exception('Nicht authentifiziert');
    }

    // Deaktiviere vorhandene Backups mit gleichem Fingerprint
    final existingBackups = await EncryptedKeyBackup.db.find(
      session,
      where: (t) =>
          t.userId.equals(userId) &
          t.fingerprint.equals(fingerprint) &
          t.isActive.equals(true),
    );

    for (final backup in existingBackups) {
      backup.isActive = false;
      await EncryptedKeyBackup.db.updateRow(session, backup);
    }

    // Erstelle neues Backup
    final backup = EncryptedKeyBackup(
      userId: userId,
      encryptedPrivateKey: encryptedPrivateKey,
      fingerprint: fingerprint.toUpperCase().replaceAll(' ', ''),
      encryptionSalt: encryptionSalt,
      kdfParams: kdfParams,
      createdAt: DateTime.now(),
      isActive: true,
    );

    return await EncryptedKeyBackup.db.insertRow(session, backup);
  }

  /// Lädt ein verschlüsseltes Private Key Backup herunter.
  Future<EncryptedKeyBackup?> downloadEncryptedBackup(
    Session session,
    String fingerprint,
  ) async {
    final userId = await _getAuthenticatedUserId(session);
    if (userId == null) {
      throw Exception('Nicht authentifiziert');
    }

    return await EncryptedKeyBackup.db.findFirstRow(
      session,
      where: (t) =>
          t.userId.equals(userId) &
          t.fingerprint.equals(fingerprint.toUpperCase().replaceAll(' ', '')) &
          t.isActive.equals(true),
    );
  }

  /// Listet alle aktiven Backups des Benutzers auf.
  Future<List<EncryptedKeyBackup>> listBackups(Session session) async {
    final userId = await _getAuthenticatedUserId(session);
    if (userId == null) {
      throw Exception('Nicht authentifiziert');
    }

    return await EncryptedKeyBackup.db.find(
      session,
      where: (t) => t.userId.equals(userId) & t.isActive.equals(true),
      orderBy: (t) => t.createdAt,
      orderDescending: true,
    );
  }

  /// Löscht ein Backup.
  Future<bool> deleteBackup(Session session, int backupId) async {
    final userId = await _getAuthenticatedUserId(session);
    if (userId == null) {
      throw Exception('Nicht authentifiziert');
    }

    final backup = await EncryptedKeyBackup.db.findById(session, backupId);
    if (backup == null || backup.userId != userId) {
      return false;
    }

    await EncryptedKeyBackup.db.deleteRow(session, backup);
    return true;
  }
}
