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
import 'quantity_unit.dart' as _i2;

/// Angebot/Listing - Haupttabelle für alle Angebote
abstract class Listing implements _i1.SerializableModel {
  Listing._({
    this.id,
    required this.userId,
    required this.categoryId,
    required this.title,
    required this.description,
    required this.quantity,
    required this.quantityUnit,
    required this.pricePerUnit,
    required this.acceptsPaypal,
    required this.acceptsBitcoin,
    required this.hasShipping,
    this.shippingMethod,
    this.shippingCostCents,
    required this.isActive,
    this.expiresAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Listing({
    int? id,
    required int userId,
    required int categoryId,
    required String title,
    required String description,
    required double quantity,
    required _i2.QuantityUnit quantityUnit,
    required int pricePerUnit,
    required bool acceptsPaypal,
    required bool acceptsBitcoin,
    required bool hasShipping,
    String? shippingMethod,
    int? shippingCostCents,
    required bool isActive,
    DateTime? expiresAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _ListingImpl;

  factory Listing.fromJson(Map<String, dynamic> jsonSerialization) {
    return Listing(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      categoryId: jsonSerialization['categoryId'] as int,
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String,
      quantity: (jsonSerialization['quantity'] as num).toDouble(),
      quantityUnit:
          _i2.QuantityUnit.fromJson((jsonSerialization['quantityUnit'] as int)),
      pricePerUnit: jsonSerialization['pricePerUnit'] as int,
      acceptsPaypal: jsonSerialization['acceptsPaypal'] as bool,
      acceptsBitcoin: jsonSerialization['acceptsBitcoin'] as bool,
      hasShipping: jsonSerialization['hasShipping'] as bool,
      shippingMethod: jsonSerialization['shippingMethod'] as String?,
      shippingCostCents: jsonSerialization['shippingCostCents'] as int?,
      isActive: jsonSerialization['isActive'] as bool,
      expiresAt: jsonSerialization['expiresAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['expiresAt']),
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

  /// Beziehungen
  int userId;

  int categoryId;

  /// Basis-Informationen
  String title;

  String description;

  /// Menge & Preis
  double quantity;

  _i2.QuantityUnit quantityUnit;

  int pricePerUnit;

  /// Zahlungsoptionen
  bool acceptsPaypal;

  bool acceptsBitcoin;

  /// Versand
  bool hasShipping;

  String? shippingMethod;

  int? shippingCostCents;

  /// Status
  bool isActive;

  DateTime? expiresAt;

  /// Timestamps
  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [Listing]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Listing copyWith({
    int? id,
    int? userId,
    int? categoryId,
    String? title,
    String? description,
    double? quantity,
    _i2.QuantityUnit? quantityUnit,
    int? pricePerUnit,
    bool? acceptsPaypal,
    bool? acceptsBitcoin,
    bool? hasShipping,
    String? shippingMethod,
    int? shippingCostCents,
    bool? isActive,
    DateTime? expiresAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'categoryId': categoryId,
      'title': title,
      'description': description,
      'quantity': quantity,
      'quantityUnit': quantityUnit.toJson(),
      'pricePerUnit': pricePerUnit,
      'acceptsPaypal': acceptsPaypal,
      'acceptsBitcoin': acceptsBitcoin,
      'hasShipping': hasShipping,
      if (shippingMethod != null) 'shippingMethod': shippingMethod,
      if (shippingCostCents != null) 'shippingCostCents': shippingCostCents,
      'isActive': isActive,
      if (expiresAt != null) 'expiresAt': expiresAt?.toJson(),
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

class _ListingImpl extends Listing {
  _ListingImpl({
    int? id,
    required int userId,
    required int categoryId,
    required String title,
    required String description,
    required double quantity,
    required _i2.QuantityUnit quantityUnit,
    required int pricePerUnit,
    required bool acceptsPaypal,
    required bool acceptsBitcoin,
    required bool hasShipping,
    String? shippingMethod,
    int? shippingCostCents,
    required bool isActive,
    DateTime? expiresAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
          id: id,
          userId: userId,
          categoryId: categoryId,
          title: title,
          description: description,
          quantity: quantity,
          quantityUnit: quantityUnit,
          pricePerUnit: pricePerUnit,
          acceptsPaypal: acceptsPaypal,
          acceptsBitcoin: acceptsBitcoin,
          hasShipping: hasShipping,
          shippingMethod: shippingMethod,
          shippingCostCents: shippingCostCents,
          isActive: isActive,
          expiresAt: expiresAt,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [Listing]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Listing copyWith({
    Object? id = _Undefined,
    int? userId,
    int? categoryId,
    String? title,
    String? description,
    double? quantity,
    _i2.QuantityUnit? quantityUnit,
    int? pricePerUnit,
    bool? acceptsPaypal,
    bool? acceptsBitcoin,
    bool? hasShipping,
    Object? shippingMethod = _Undefined,
    Object? shippingCostCents = _Undefined,
    bool? isActive,
    Object? expiresAt = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Listing(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      categoryId: categoryId ?? this.categoryId,
      title: title ?? this.title,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      quantityUnit: quantityUnit ?? this.quantityUnit,
      pricePerUnit: pricePerUnit ?? this.pricePerUnit,
      acceptsPaypal: acceptsPaypal ?? this.acceptsPaypal,
      acceptsBitcoin: acceptsBitcoin ?? this.acceptsBitcoin,
      hasShipping: hasShipping ?? this.hasShipping,
      shippingMethod:
          shippingMethod is String? ? shippingMethod : this.shippingMethod,
      shippingCostCents: shippingCostCents is int?
          ? shippingCostCents
          : this.shippingCostCents,
      isActive: isActive ?? this.isActive,
      expiresAt: expiresAt is DateTime? ? expiresAt : this.expiresAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
