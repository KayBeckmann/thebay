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

/// Slot variant defining pricing and duration for listing slots
abstract class SlotVariant implements _i1.SerializableModel {
  SlotVariant._({
    this.id,
    required this.name,
    this.description,
    required this.priceUsdCents,
    required this.durationDays,
    required this.allowPaypal,
    required this.allowBitcoin,
    required this.isActive,
    required this.sortOrder,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SlotVariant({
    int? id,
    required String name,
    String? description,
    required int priceUsdCents,
    required int durationDays,
    required bool allowPaypal,
    required bool allowBitcoin,
    required bool isActive,
    required int sortOrder,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _SlotVariantImpl;

  factory SlotVariant.fromJson(Map<String, dynamic> jsonSerialization) {
    return SlotVariant(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      description: jsonSerialization['description'] as String?,
      priceUsdCents: jsonSerialization['priceUsdCents'] as int,
      durationDays: jsonSerialization['durationDays'] as int,
      allowPaypal: jsonSerialization['allowPaypal'] as bool,
      allowBitcoin: jsonSerialization['allowBitcoin'] as bool,
      isActive: jsonSerialization['isActive'] as bool,
      sortOrder: jsonSerialization['sortOrder'] as int,
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

  /// Variant name (e.g., "Basic", "Premium", "30 Days")
  String name;

  /// Description of what's included
  String? description;

  /// Price in cents (USD)
  int priceUsdCents;

  /// Duration in days
  int durationDays;

  /// Whether PayPal payment is allowed
  bool allowPaypal;

  /// Whether Bitcoin payment is allowed
  bool allowBitcoin;

  /// Whether this variant is active and available for purchase
  bool isActive;

  /// Sort order for display
  int sortOrder;

  /// Creation timestamp
  DateTime createdAt;

  /// Last modification timestamp
  DateTime updatedAt;

  /// Returns a shallow copy of this [SlotVariant]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SlotVariant copyWith({
    int? id,
    String? name,
    String? description,
    int? priceUsdCents,
    int? durationDays,
    bool? allowPaypal,
    bool? allowBitcoin,
    bool? isActive,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      if (description != null) 'description': description,
      'priceUsdCents': priceUsdCents,
      'durationDays': durationDays,
      'allowPaypal': allowPaypal,
      'allowBitcoin': allowBitcoin,
      'isActive': isActive,
      'sortOrder': sortOrder,
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

class _SlotVariantImpl extends SlotVariant {
  _SlotVariantImpl({
    int? id,
    required String name,
    String? description,
    required int priceUsdCents,
    required int durationDays,
    required bool allowPaypal,
    required bool allowBitcoin,
    required bool isActive,
    required int sortOrder,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
          id: id,
          name: name,
          description: description,
          priceUsdCents: priceUsdCents,
          durationDays: durationDays,
          allowPaypal: allowPaypal,
          allowBitcoin: allowBitcoin,
          isActive: isActive,
          sortOrder: sortOrder,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [SlotVariant]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SlotVariant copyWith({
    Object? id = _Undefined,
    String? name,
    Object? description = _Undefined,
    int? priceUsdCents,
    int? durationDays,
    bool? allowPaypal,
    bool? allowBitcoin,
    bool? isActive,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return SlotVariant(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      description: description is String? ? description : this.description,
      priceUsdCents: priceUsdCents ?? this.priceUsdCents,
      durationDays: durationDays ?? this.durationDays,
      allowPaypal: allowPaypal ?? this.allowPaypal,
      allowBitcoin: allowBitcoin ?? this.allowBitcoin,
      isActive: isActive ?? this.isActive,
      sortOrder: sortOrder ?? this.sortOrder,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
