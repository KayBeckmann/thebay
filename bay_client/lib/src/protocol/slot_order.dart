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
import 'payment_method.dart' as _i2;
import 'order_status.dart' as _i3;

/// Slot-Bestellungen - Kaufvorgänge für Slots
abstract class SlotOrder implements _i1.SerializableModel {
  SlotOrder._({
    this.id,
    required this.userId,
    required this.slotVariantId,
    required this.paymentMethod,
    required this.amountCents,
    this.transactionId,
    required this.status,
    required this.createdAt,
    this.paidAt,
    this.completedAt,
  });

  factory SlotOrder({
    int? id,
    required int userId,
    required int slotVariantId,
    required _i2.PaymentMethod paymentMethod,
    required int amountCents,
    String? transactionId,
    required _i3.OrderStatus status,
    required DateTime createdAt,
    DateTime? paidAt,
    DateTime? completedAt,
  }) = _SlotOrderImpl;

  factory SlotOrder.fromJson(Map<String, dynamic> jsonSerialization) {
    return SlotOrder(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      slotVariantId: jsonSerialization['slotVariantId'] as int,
      paymentMethod: _i2.PaymentMethod.fromJson(
          (jsonSerialization['paymentMethod'] as int)),
      amountCents: jsonSerialization['amountCents'] as int,
      transactionId: jsonSerialization['transactionId'] as String?,
      status: _i3.OrderStatus.fromJson((jsonSerialization['status'] as int)),
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      paidAt: jsonSerialization['paidAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['paidAt']),
      completedAt: jsonSerialization['completedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['completedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  int slotVariantId;

  /// Zahlung
  _i2.PaymentMethod paymentMethod;

  int amountCents;

  String? transactionId;

  /// Status
  _i3.OrderStatus status;

  /// Timestamps
  DateTime createdAt;

  DateTime? paidAt;

  DateTime? completedAt;

  /// Returns a shallow copy of this [SlotOrder]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SlotOrder copyWith({
    int? id,
    int? userId,
    int? slotVariantId,
    _i2.PaymentMethod? paymentMethod,
    int? amountCents,
    String? transactionId,
    _i3.OrderStatus? status,
    DateTime? createdAt,
    DateTime? paidAt,
    DateTime? completedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'slotVariantId': slotVariantId,
      'paymentMethod': paymentMethod.toJson(),
      'amountCents': amountCents,
      if (transactionId != null) 'transactionId': transactionId,
      'status': status.toJson(),
      'createdAt': createdAt.toJson(),
      if (paidAt != null) 'paidAt': paidAt?.toJson(),
      if (completedAt != null) 'completedAt': completedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SlotOrderImpl extends SlotOrder {
  _SlotOrderImpl({
    int? id,
    required int userId,
    required int slotVariantId,
    required _i2.PaymentMethod paymentMethod,
    required int amountCents,
    String? transactionId,
    required _i3.OrderStatus status,
    required DateTime createdAt,
    DateTime? paidAt,
    DateTime? completedAt,
  }) : super._(
          id: id,
          userId: userId,
          slotVariantId: slotVariantId,
          paymentMethod: paymentMethod,
          amountCents: amountCents,
          transactionId: transactionId,
          status: status,
          createdAt: createdAt,
          paidAt: paidAt,
          completedAt: completedAt,
        );

  /// Returns a shallow copy of this [SlotOrder]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SlotOrder copyWith({
    Object? id = _Undefined,
    int? userId,
    int? slotVariantId,
    _i2.PaymentMethod? paymentMethod,
    int? amountCents,
    Object? transactionId = _Undefined,
    _i3.OrderStatus? status,
    DateTime? createdAt,
    Object? paidAt = _Undefined,
    Object? completedAt = _Undefined,
  }) {
    return SlotOrder(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      slotVariantId: slotVariantId ?? this.slotVariantId,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      amountCents: amountCents ?? this.amountCents,
      transactionId:
          transactionId is String? ? transactionId : this.transactionId,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      paidAt: paidAt is DateTime? ? paidAt : this.paidAt,
      completedAt: completedAt is DateTime? ? completedAt : this.completedAt,
    );
  }
}
