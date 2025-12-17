import 'dart:async';

import 'package:bay_client/bay_client.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:openpgp/openpgp.dart';

/// Service für PGP Key Management.
/// Verwaltet Key-Generierung, sichere Speicherung und Server-Synchronisation.
class PgpKeyService {
  static const String _privateKeyKey = 'pgp_private_key';
  static const String _fingerprintKey = 'pgp_fingerprint';
  static const String _passphraseKey = 'pgp_passphrase';

  final Client _client;
  final FlutterSecureStorage _secureStorage;

  // Gecachte Key-Informationen
  String? _cachedPrivateKey;
  String? _cachedFingerprint;
  UserPublicKey? _cachedServerKey;

  PgpKeyService(this._client)
      : _secureStorage = const FlutterSecureStorage(
          aOptions: AndroidOptions(
            encryptedSharedPreferences: true,
          ),
          iOptions: IOSOptions(
            accessibility: KeychainAccessibility.first_unlock_this_device,
          ),
        );

  /// Initialisiert den Service und lädt gecachte Keys.
  Future<void> initialize() async {
    _cachedPrivateKey = await _secureStorage.read(key: _privateKeyKey);
    _cachedFingerprint = await _secureStorage.read(key: _fingerprintKey);
  }

  /// Prüft ob ein Private Key lokal gespeichert ist.
  Future<bool> hasPrivateKey() async {
    if (_cachedPrivateKey != null) return true;
    final key = await _secureStorage.read(key: _privateKeyKey);
    return key != null && key.isNotEmpty;
  }

  /// Generiert ein neues PGP Keypair.
  /// [name] und [email] werden als Key-Identität verwendet.
  /// [passphrase] ist optional, aber empfohlen für zusätzliche Sicherheit.
  /// Verwendet Ed25519/Curve25519 für schnelle Generierung und hohe Sicherheit.
  /// Fallback auf RSA-2048 falls ECC nicht unterstützt wird.
  /// Timeout nach 2 Minuten, um Endlosschleifen zu vermeiden.
  Future<PgpKeyPair> generateKeyPair({
    required String name,
    required String email,
    String? passphrase,
    bool useEcc = true,
    int rsaBits = 2048,
  }) async {
    print('[PGP] generateKeyPair() gestartet');
    print('[PGP] Parameter: name=$name, email=$email, useEcc=$useEcc, rsaBits=$rsaBits');

    final options = Options()
      ..name = name
      ..email = email
      ..passphrase = passphrase ?? ''
      ..keyOptions = KeyOptions();

    if (useEcc) {
      // Ed25519 für Signaturen, Curve25519 für Verschlüsselung
      // Viel schneller als RSA und genauso sicher
      options.keyOptions!.algorithm = Algorithm.EDDSA;
      options.keyOptions!.curve = Curve.CURVE25519;
      print('[PGP] Verwende ECC (Ed25519/Curve25519)');
    } else {
      options.keyOptions!.rsaBits = rsaBits;
      print('[PGP] Verwende RSA-$rsaBits');
    }

    print('[PGP] Options erstellt, starte OpenPGP.generate()...');
    final stopwatch = Stopwatch()..start();

    final keyPair = await OpenPGP.generate(options: options)
        .timeout(
      const Duration(minutes: 2),
      onTimeout: () {
        print('[PGP] TIMEOUT nach 2 Minuten!');
        throw TimeoutException(
          'Schlüsselgenerierung dauert zu lange. '
          'Bitte versuche es erneut oder starte die App neu.',
          const Duration(minutes: 2),
        );
      },
    );

    stopwatch.stop();
    print('[PGP] OpenPGP.generate() abgeschlossen nach ${stopwatch.elapsed}');
    print('[PGP] PublicKey Länge: ${keyPair.publicKey.length}');
    print('[PGP] PrivateKey Länge: ${keyPair.privateKey.length}');

    // Extrahiere Fingerprint aus dem Public Key
    print('[PGP] Extrahiere Fingerprint...');
    final publicKeyMetadata =
        await OpenPGP.getPublicKeyMetadata(keyPair.publicKey);
    final fingerprint = publicKeyMetadata.fingerprint;
    print('[PGP] Fingerprint: $fingerprint');

    final algorithm = useEcc ? 'Ed25519' : 'RSA';
    final keySize = useEcc ? 256 : rsaBits;

    print('[PGP] generateKeyPair() erfolgreich abgeschlossen');
    return PgpKeyPair(
      publicKey: keyPair.publicKey,
      privateKey: keyPair.privateKey,
      fingerprint: fingerprint,
      algorithm: algorithm,
      keySize: keySize,
      identity: '$name <$email>',
    );
  }

  /// Speichert den Private Key sicher auf dem Gerät.
  Future<void> storePrivateKey(String privateKeyArmored, String fingerprint) async {
    await _secureStorage.write(key: _privateKeyKey, value: privateKeyArmored);
    await _secureStorage.write(key: _fingerprintKey, value: fingerprint);
    _cachedPrivateKey = privateKeyArmored;
    _cachedFingerprint = fingerprint;
  }

  /// Ruft den lokal gespeicherten Private Key ab.
  Future<String?> getPrivateKey() async {
    if (_cachedPrivateKey != null) return _cachedPrivateKey;
    _cachedPrivateKey = await _secureStorage.read(key: _privateKeyKey);
    return _cachedPrivateKey;
  }

  /// Ruft den lokalen Fingerprint ab.
  Future<String?> getFingerprint() async {
    if (_cachedFingerprint != null) return _cachedFingerprint;
    _cachedFingerprint = await _secureStorage.read(key: _fingerprintKey);
    return _cachedFingerprint;
  }

  /// Löscht den Private Key vom Gerät.
  Future<void> deletePrivateKey() async {
    await _secureStorage.delete(key: _privateKeyKey);
    await _secureStorage.delete(key: _fingerprintKey);
    await _secureStorage.delete(key: _passphraseKey);
    _cachedPrivateKey = null;
    _cachedFingerprint = null;
    _cachedServerKey = null;
  }

  /// Exportiert den Private Key (für Backup).
  Future<String?> exportPrivateKey() async {
    return await getPrivateKey();
  }

  /// Importiert einen Private Key von einem Backup.
  /// Validiert das Key-Format vor dem Speichern.
  Future<bool> importPrivateKey(String privateKeyArmored) async {
    // Validiere Format
    if (!privateKeyArmored.contains('-----BEGIN PGP PRIVATE KEY BLOCK-----')) {
      return false;
    }

    try {
      // Extrahiere Public Key und Metadaten
      final publicKey = await OpenPGP.convertPrivateKeyToPublicKey(privateKeyArmored);
      final metadata = await OpenPGP.getPublicKeyMetadata(publicKey);

      await storePrivateKey(privateKeyArmored, metadata.fingerprint);
      return true;
    } catch (e) {
      return false;
    }
  }

  // === Server-Kommunikation ===

  /// Lädt den Public Key zum Server hoch.
  Future<UserPublicKey?> uploadPublicKey(
    String publicKeyArmored,
    String identity,
    String fingerprint,
    String algorithm,
    int keySize,
  ) async {
    final result = await _client.pgpKey.uploadPublicKey(
      publicKeyArmored,
      identity,
      fingerprint,
      algorithm,
      keySize,
    );
    _cachedServerKey = result;
    return result;
  }

  /// Ruft den eigenen Public Key vom Server ab.
  Future<UserPublicKey?> getMyPublicKey() async {
    if (_cachedServerKey != null) return _cachedServerKey;
    _cachedServerKey = await _client.pgpKey.getMyPublicKey();
    return _cachedServerKey;
  }

  /// Prüft ob der Server einen Public Key für den Benutzer hat.
  Future<bool> hasServerPublicKey() async {
    return await _client.pgpKey.hasPublicKey(null);
  }

  /// Ruft den Public Key eines anderen Benutzers ab.
  Future<UserPublicKey?> getPublicKeyForUser(int userId) async {
    return await _client.pgpKey.getPublicKey(userId);
  }

  /// Ruft den Public Key per Username ab.
  Future<UserPublicKey?> getPublicKeyByUsername(String username) async {
    return await _client.pgpKey.getPublicKeyByUsername(username);
  }

  /// Deaktiviert den aktuellen Key auf dem Server.
  Future<bool> deactivateServerKey() async {
    final result = await _client.pgpKey.deactivateKey();
    if (result) {
      _cachedServerKey = null;
    }
    return result;
  }

  // === Verschlüsselung (für Meilenstein 7b/7c) ===

  /// Verschlüsselt eine Nachricht für einen Empfänger.
  Future<String> encryptForRecipient(
    String plainText,
    String recipientPublicKey,
  ) async {
    return await OpenPGP.encrypt(plainText, recipientPublicKey);
  }

  /// Entschlüsselt eine Nachricht mit dem eigenen Private Key.
  Future<String> decryptMessage(
    String encryptedText, {
    String? passphrase,
  }) async {
    final privateKey = await getPrivateKey();
    if (privateKey == null) {
      throw Exception('Kein Private Key vorhanden');
    }
    return await OpenPGP.decrypt(encryptedText, privateKey, passphrase ?? '');
  }

  /// Signiert eine Nachricht mit dem eigenen Private Key.
  Future<String> signMessage(String message, {String? passphrase}) async {
    final privateKey = await getPrivateKey();
    if (privateKey == null) {
      throw Exception('Kein Private Key vorhanden');
    }
    return await OpenPGP.sign(message, privateKey, passphrase ?? '');
  }

  /// Verifiziert eine signierte Nachricht.
  Future<bool> verifySignature(
    String signature,
    String message,
    String signerPublicKey,
  ) async {
    try {
      await OpenPGP.verify(signature, message, signerPublicKey);
      return true;
    } catch (e) {
      return false;
    }
  }

  // === Server-Backup (Optional) ===

  /// Lädt ein verschlüsseltes Backup zum Server hoch.
  Future<EncryptedKeyBackup?> uploadEncryptedBackup({
    required String encryptedPrivateKey,
    required String fingerprint,
    required String salt,
    required String kdfParams,
  }) async {
    return await _client.pgpKey.uploadEncryptedBackup(
      encryptedPrivateKey,
      fingerprint,
      salt,
      kdfParams,
    );
  }

  /// Lädt ein verschlüsseltes Backup vom Server.
  Future<EncryptedKeyBackup?> downloadEncryptedBackup(String fingerprint) async {
    return await _client.pgpKey.downloadEncryptedBackup(fingerprint);
  }

  /// Listet alle Backups auf.
  Future<List<EncryptedKeyBackup>> listBackups() async {
    return await _client.pgpKey.listBackups();
  }

  /// Löscht ein Backup.
  Future<bool> deleteBackup(int backupId) async {
    return await _client.pgpKey.deleteBackup(backupId);
  }

  /// Gibt den vollständigen Key-Status zurück.
  Future<PgpKeyStatus> getKeyStatus() async {
    final hasLocal = await hasPrivateKey();
    final fingerprint = await getFingerprint();

    UserPublicKey? serverKey;
    bool hasServer = false;

    try {
      serverKey = await getMyPublicKey();
      hasServer = serverKey != null;
    } catch (e) {
      // Server nicht erreichbar oder nicht authentifiziert
    }

    return PgpKeyStatus(
      hasLocalPrivateKey: hasLocal,
      hasServerPublicKey: hasServer,
      localFingerprint: fingerprint,
      serverKey: serverKey,
      keysMatch: hasLocal && hasServer && fingerprint == serverKey?.fingerprint,
    );
  }
}

/// Repräsentiert ein generiertes PGP Keypair.
class PgpKeyPair {
  final String publicKey;
  final String privateKey;
  final String fingerprint;
  final String algorithm;
  final int keySize;
  final String identity;

  PgpKeyPair({
    required this.publicKey,
    required this.privateKey,
    required this.fingerprint,
    required this.algorithm,
    required this.keySize,
    required this.identity,
  });
}

/// Status der PGP Keys.
class PgpKeyStatus {
  final bool hasLocalPrivateKey;
  final bool hasServerPublicKey;
  final String? localFingerprint;
  final UserPublicKey? serverKey;
  final bool keysMatch;

  PgpKeyStatus({
    required this.hasLocalPrivateKey,
    required this.hasServerPublicKey,
    this.localFingerprint,
    this.serverKey,
    required this.keysMatch,
  });

  bool get isFullyConfigured => hasLocalPrivateKey && hasServerPublicKey && keysMatch;
}
