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

/// User-Slots - Gekaufte Slots eines Benutzers
abstract class UserSlot implements _i1.SerializableModel {
  UserSlot._({
    this.id,
    required this.userId,
    required this.slotVariantId,
    this.listingId,
    required this.purchasedAt,
    required this.expiresAt,
    required this.isActive,
    required this.isUsed,
  });

  factory UserSlot({
    int? id,
    required int userId,
    required int slotVariantId,
    int? listingId,
    required DateTime purchasedAt,
    required DateTime expiresAt,
    required bool isActive,
    required bool isUsed,
  }) = _UserSlotImpl;

  factory UserSlot.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserSlot(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      slotVariantId: jsonSerialization['slotVariantId'] as int,
      listingId: jsonSerialization['listingId'] as int?,
      purchasedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['purchasedAt']),
      expiresAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['expiresAt']),
      isActive: jsonSerialization['isActive'] as bool,
      isUsed: jsonSerialization['isUsed'] as bool,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  int slotVariantId;

  int? listingId;

  /// Laufzeit
  DateTime purchasedAt;

  DateTime expiresAt;

  /// Status
  bool isActive;

  /// Status
  bool isUsed;

  /// Returns a shallow copy of this [UserSlot]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UserSlot copyWith({
    int? id,
    int? userId,
    int? slotVariantId,
    int? listingId,
    DateTime? purchasedAt,
    DateTime? expiresAt,
    bool? isActive,
    bool? isUsed,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'slotVariantId': slotVariantId,
      if (listingId != null) 'listingId': listingId,
      'purchasedAt': purchasedAt.toJson(),
      'expiresAt': expiresAt.toJson(),
      'isActive': isActive,
      'isUsed': isUsed,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserSlotImpl extends UserSlot {
  _UserSlotImpl({
    int? id,
    required int userId,
    required int slotVariantId,
    int? listingId,
    required DateTime purchasedAt,
    required DateTime expiresAt,
    required bool isActive,
    required bool isUsed,
  }) : super._(
          id: id,
          userId: userId,
          slotVariantId: slotVariantId,
          listingId: listingId,
          purchasedAt: purchasedAt,
          expiresAt: expiresAt,
          isActive: isActive,
          isUsed: isUsed,
        );

  /// Returns a shallow copy of this [UserSlot]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UserSlot copyWith({
    Object? id = _Undefined,
    int? userId,
    int? slotVariantId,
    Object? listingId = _Undefined,
    DateTime? purchasedAt,
    DateTime? expiresAt,
    bool? isActive,
    bool? isUsed,
  }) {
    return UserSlot(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      slotVariantId: slotVariantId ?? this.slotVariantId,
      listingId: listingId is int? ? listingId : this.listingId,
      purchasedAt: purchasedAt ?? this.purchasedAt,
      expiresAt: expiresAt ?? this.expiresAt,
      isActive: isActive ?? this.isActive,
      isUsed: isUsed ?? this.isUsed,
    );
  }
}
