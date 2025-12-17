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
import 'transaction_status.dart' as _i2;
import 'payment_method.dart' as _i3;

/// Transaktion zwischen Käufer und Verkäufer
abstract class Transaction implements _i1.SerializableModel {
  Transaction._({
    this.id,
    required this.buyerId,
    required this.sellerId,
    required this.listingId,
    _i2.TransactionStatus? status,
    required this.quantity,
    required this.totalPriceCents,
    required this.paymentMethod,
    required this.createdAt,
    required this.updatedAt,
    this.shippedAt,
    this.receivedAt,
    this.completedAt,
    this.autoCompleteAt,
    this.buyerNote,
  }) : status = status ?? _i2.TransactionStatus.open;

  factory Transaction({
    int? id,
    required int buyerId,
    required int sellerId,
    required int listingId,
    _i2.TransactionStatus? status,
    required double quantity,
    required int totalPriceCents,
    required _i3.PaymentMethod paymentMethod,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? shippedAt,
    DateTime? receivedAt,
    DateTime? completedAt,
    DateTime? autoCompleteAt,
    String? buyerNote,
  }) = _TransactionImpl;

  factory Transaction.fromJson(Map<String, dynamic> jsonSerialization) {
    return Transaction(
      id: jsonSerialization['id'] as int?,
      buyerId: jsonSerialization['buyerId'] as int,
      sellerId: jsonSerialization['sellerId'] as int,
      listingId: jsonSerialization['listingId'] as int,
      status:
          _i2.TransactionStatus.fromJson((jsonSerialization['status'] as int)),
      quantity: (jsonSerialization['quantity'] as num).toDouble(),
      totalPriceCents: jsonSerialization['totalPriceCents'] as int,
      paymentMethod: _i3.PaymentMethod.fromJson(
          (jsonSerialization['paymentMethod'] as int)),
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
      shippedAt: jsonSerialization['shippedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['shippedAt']),
      receivedAt: jsonSerialization['receivedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['receivedAt']),
      completedAt: jsonSerialization['completedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['completedAt']),
      autoCompleteAt: jsonSerialization['autoCompleteAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['autoCompleteAt']),
      buyerNote: jsonSerialization['buyerNote'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  /// Käufer (User-ID)
  int buyerId;

  /// Verkäufer (User-ID)
  int sellerId;

  /// Angebot das gekauft wird
  int listingId;

  /// Aktueller Status der Transaktion
  _i2.TransactionStatus status;

  /// Gekaufte Menge
  double quantity;

  /// Gesamtpreis in Cents
  int totalPriceCents;

  /// Gewählte Zahlungsmethode
  _i3.PaymentMethod paymentMethod;

  /// Erstellungszeitpunkt
  DateTime createdAt;

  /// Letzte Aktualisierung
  DateTime updatedAt;

  /// Zeitpunkt als versendet markiert
  DateTime? shippedAt;

  /// Zeitpunkt als erhalten markiert
  DateTime? receivedAt;

  /// Zeitpunkt des Abschlusses
  DateTime? completedAt;

  /// Datum für automatischen Abschluss (14 Tage nach shipped)
  DateTime? autoCompleteAt;

  /// Optionale Nachricht vom Käufer
  String? buyerNote;

  /// Returns a shallow copy of this [Transaction]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Transaction copyWith({
    int? id,
    int? buyerId,
    int? sellerId,
    int? listingId,
    _i2.TransactionStatus? status,
    double? quantity,
    int? totalPriceCents,
    _i3.PaymentMethod? paymentMethod,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? shippedAt,
    DateTime? receivedAt,
    DateTime? completedAt,
    DateTime? autoCompleteAt,
    String? buyerNote,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'buyerId': buyerId,
      'sellerId': sellerId,
      'listingId': listingId,
      'status': status.toJson(),
      'quantity': quantity,
      'totalPriceCents': totalPriceCents,
      'paymentMethod': paymentMethod.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
      if (shippedAt != null) 'shippedAt': shippedAt?.toJson(),
      if (receivedAt != null) 'receivedAt': receivedAt?.toJson(),
      if (completedAt != null) 'completedAt': completedAt?.toJson(),
      if (autoCompleteAt != null) 'autoCompleteAt': autoCompleteAt?.toJson(),
      if (buyerNote != null) 'buyerNote': buyerNote,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TransactionImpl extends Transaction {
  _TransactionImpl({
    int? id,
    required int buyerId,
    required int sellerId,
    required int listingId,
    _i2.TransactionStatus? status,
    required double quantity,
    required int totalPriceCents,
    required _i3.PaymentMethod paymentMethod,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? shippedAt,
    DateTime? receivedAt,
    DateTime? completedAt,
    DateTime? autoCompleteAt,
    String? buyerNote,
  }) : super._(
          id: id,
          buyerId: buyerId,
          sellerId: sellerId,
          listingId: listingId,
          status: status,
          quantity: quantity,
          totalPriceCents: totalPriceCents,
          paymentMethod: paymentMethod,
          createdAt: createdAt,
          updatedAt: updatedAt,
          shippedAt: shippedAt,
          receivedAt: receivedAt,
          completedAt: completedAt,
          autoCompleteAt: autoCompleteAt,
          buyerNote: buyerNote,
        );

  /// Returns a shallow copy of this [Transaction]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Transaction copyWith({
    Object? id = _Undefined,
    int? buyerId,
    int? sellerId,
    int? listingId,
    _i2.TransactionStatus? status,
    double? quantity,
    int? totalPriceCents,
    _i3.PaymentMethod? paymentMethod,
    DateTime? createdAt,
    DateTime? updatedAt,
    Object? shippedAt = _Undefined,
    Object? receivedAt = _Undefined,
    Object? completedAt = _Undefined,
    Object? autoCompleteAt = _Undefined,
    Object? buyerNote = _Undefined,
  }) {
    return Transaction(
      id: id is int? ? id : this.id,
      buyerId: buyerId ?? this.buyerId,
      sellerId: sellerId ?? this.sellerId,
      listingId: listingId ?? this.listingId,
      status: status ?? this.status,
      quantity: quantity ?? this.quantity,
      totalPriceCents: totalPriceCents ?? this.totalPriceCents,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      shippedAt: shippedAt is DateTime? ? shippedAt : this.shippedAt,
      receivedAt: receivedAt is DateTime? ? receivedAt : this.receivedAt,
      completedAt: completedAt is DateTime? ? completedAt : this.completedAt,
      autoCompleteAt:
          autoCompleteAt is DateTime? ? autoCompleteAt : this.autoCompleteAt,
      buyerNote: buyerNote is String? ? buyerNote : this.buyerNote,
    );
  }
}
