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

/// User PGP Public Key for encrypted messaging
abstract class UserPublicKey implements _i1.SerializableModel {
  UserPublicKey._({
    this.id,
    required this.userId,
    required this.publicKeyArmored,
    required this.fingerprint,
    required this.algorithm,
    required this.keySize,
    required this.keyIdentity,
    bool? isActive,
    required this.createdAt,
    required this.updatedAt,
  }) : isActive = isActive ?? true;

  factory UserPublicKey({
    int? id,
    required int userId,
    required String publicKeyArmored,
    required String fingerprint,
    required String algorithm,
    required int keySize,
    required String keyIdentity,
    bool? isActive,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _UserPublicKeyImpl;

  factory UserPublicKey.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserPublicKey(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      publicKeyArmored: jsonSerialization['publicKeyArmored'] as String,
      fingerprint: jsonSerialization['fingerprint'] as String,
      algorithm: jsonSerialization['algorithm'] as String,
      keySize: jsonSerialization['keySize'] as int,
      keyIdentity: jsonSerialization['keyIdentity'] as String,
      isActive: jsonSerialization['isActive'] as bool,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  /// User who owns this key
  int userId;

  /// Armored PGP public key (ASCII format)
  String publicKeyArmored;

  /// Key fingerprint (40 hex chars for SHA-1 fingerprint)
  String fingerprint;

  /// Key algorithm (RSA, ECDSA, etc.)
  String algorithm;

  /// Key size in bits (e.g., 4096 for RSA)
  int keySize;

  /// Name/email associated with key
  String keyIdentity;

  /// Whether this is the user's active key
  bool isActive;

  /// Creation timestamp
  DateTime createdAt;

  /// Last update timestamp
  DateTime updatedAt;

  /// Returns a shallow copy of this [UserPublicKey]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UserPublicKey copyWith({
    int? id,
    int? userId,
    String? publicKeyArmored,
    String? fingerprint,
    String? algorithm,
    int? keySize,
    String? keyIdentity,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'publicKeyArmored': publicKeyArmored,
      'fingerprint': fingerprint,
      'algorithm': algorithm,
      'keySize': keySize,
      'keyIdentity': keyIdentity,
      'isActive': isActive,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserPublicKeyImpl extends UserPublicKey {
  _UserPublicKeyImpl({
    int? id,
    required int userId,
    required String publicKeyArmored,
    required String fingerprint,
    required String algorithm,
    required int keySize,
    required String keyIdentity,
    bool? isActive,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
          id: id,
          userId: userId,
          publicKeyArmored: publicKeyArmored,
          fingerprint: fingerprint,
          algorithm: algorithm,
          keySize: keySize,
          keyIdentity: keyIdentity,
          isActive: isActive,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [UserPublicKey]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UserPublicKey copyWith({
    Object? id = _Undefined,
    int? userId,
    String? publicKeyArmored,
    String? fingerprint,
    String? algorithm,
    int? keySize,
    String? keyIdentity,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserPublicKey(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      publicKeyArmored: publicKeyArmored ?? this.publicKeyArmored,
      fingerprint: fingerprint ?? this.fingerprint,
      algorithm: algorithm ?? this.algorithm,
      keySize: keySize ?? this.keySize,
      keyIdentity: keyIdentity ?? this.keyIdentity,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
