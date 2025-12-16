/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

/// Encrypted private key backup (stored encrypted with user's passphrase)
abstract class EncryptedKeyBackup implements _i1.SerializableModel {
  EncryptedKeyBackup._({
    this.id,
    required this.userId,
    required this.encryptedPrivateKey,
    required this.fingerprint,
    required this.encryptionSalt,
    required this.kdfParams,
    required this.createdAt,
    bool? isActive,
  }) : isActive = isActive ?? true;

  factory EncryptedKeyBackup({
    int? id,
    required int userId,
    required String encryptedPrivateKey,
    required String fingerprint,
    required String encryptionSalt,
    required String kdfParams,
    required DateTime createdAt,
    bool? isActive,
  }) = _EncryptedKeyBackupImpl;

  factory EncryptedKeyBackup.fromJson(Map<String, dynamic> jsonSerialization) {
    return EncryptedKeyBackup(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      encryptedPrivateKey: jsonSerialization['encryptedPrivateKey'] as String,
      fingerprint: jsonSerialization['fingerprint'] as String,
      encryptionSalt: jsonSerialization['encryptionSalt'] as String,
      kdfParams: jsonSerialization['kdfParams'] as String,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      isActive: jsonSerialization['isActive'] as bool,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  /// User who owns this backup
  int userId;

  /// Encrypted private key (double-encrypted: PGP passphrase + additional encryption)
  String encryptedPrivateKey;

  /// Fingerprint of the backed-up key
  String fingerprint;

  /// Salt used for backup encryption
  String encryptionSalt;

  /// Key derivation parameters (JSON: iterations, memory, etc.)
  String kdfParams;

  /// Creation timestamp
  DateTime createdAt;

  /// Whether backup is still valid
  bool isActive;

  /// Returns a shallow copy of this [EncryptedKeyBackup]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  EncryptedKeyBackup copyWith({
    int? id,
    int? userId,
    String? encryptedPrivateKey,
    String? fingerprint,
    String? encryptionSalt,
    String? kdfParams,
    DateTime? createdAt,
    bool? isActive,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'encryptedPrivateKey': encryptedPrivateKey,
      'fingerprint': fingerprint,
      'encryptionSalt': encryptionSalt,
      'kdfParams': kdfParams,
      'createdAt': createdAt.toJson(),
      'isActive': isActive,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _EncryptedKeyBackupImpl extends EncryptedKeyBackup {
  _EncryptedKeyBackupImpl({
    int? id,
    required int userId,
    required String encryptedPrivateKey,
    required String fingerprint,
    required String encryptionSalt,
    required String kdfParams,
    required DateTime createdAt,
    bool? isActive,
  }) : super._(
          id: id,
          userId: userId,
          encryptedPrivateKey: encryptedPrivateKey,
          fingerprint: fingerprint,
          encryptionSalt: encryptionSalt,
          kdfParams: kdfParams,
          createdAt: createdAt,
          isActive: isActive,
        );

  /// Returns a shallow copy of this [EncryptedKeyBackup]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  EncryptedKeyBackup copyWith({
    Object? id = _Undefined,
    int? userId,
    String? encryptedPrivateKey,
    String? fingerprint,
    String? encryptionSalt,
    String? kdfParams,
    DateTime? createdAt,
    bool? isActive,
  }) {
    return EncryptedKeyBackup(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      encryptedPrivateKey: encryptedPrivateKey ?? this.encryptedPrivateKey,
      fingerprint: fingerprint ?? this.fingerprint,
      encryptionSalt: encryptionSalt ?? this.encryptionSalt,
      kdfParams: kdfParams ?? this.kdfParams,
      createdAt: createdAt ?? this.createdAt,
      isActive: isActive ?? this.isActive,
    );
  }
}
