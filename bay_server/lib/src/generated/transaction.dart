/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import 'transaction_status.dart' as _i2;
import 'payment_method.dart' as _i3;

/// Transaktion zwischen Käufer und Verkäufer
abstract class Transaction
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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

  static final t = TransactionTable();

  static const db = TransactionRepository._();

  @override
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

  @override
  _i1.Table<int?> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
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

  static TransactionInclude include() {
    return TransactionInclude._();
  }

  static TransactionIncludeList includeList({
    _i1.WhereExpressionBuilder<TransactionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TransactionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TransactionTable>? orderByList,
    TransactionInclude? include,
  }) {
    return TransactionIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Transaction.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Transaction.t),
      include: include,
    );
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

class TransactionTable extends _i1.Table<int?> {
  TransactionTable({super.tableRelation}) : super(tableName: 'transactions') {
    buyerId = _i1.ColumnInt(
      'buyerId',
      this,
    );
    sellerId = _i1.ColumnInt(
      'sellerId',
      this,
    );
    listingId = _i1.ColumnInt(
      'listingId',
      this,
    );
    status = _i1.ColumnEnum(
      'status',
      this,
      _i1.EnumSerialization.byIndex,
      hasDefault: true,
    );
    quantity = _i1.ColumnDouble(
      'quantity',
      this,
    );
    totalPriceCents = _i1.ColumnInt(
      'totalPriceCents',
      this,
    );
    paymentMethod = _i1.ColumnEnum(
      'paymentMethod',
      this,
      _i1.EnumSerialization.byIndex,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
    );
    shippedAt = _i1.ColumnDateTime(
      'shippedAt',
      this,
    );
    receivedAt = _i1.ColumnDateTime(
      'receivedAt',
      this,
    );
    completedAt = _i1.ColumnDateTime(
      'completedAt',
      this,
    );
    autoCompleteAt = _i1.ColumnDateTime(
      'autoCompleteAt',
      this,
    );
    buyerNote = _i1.ColumnString(
      'buyerNote',
      this,
    );
  }

  /// Käufer (User-ID)
  late final _i1.ColumnInt buyerId;

  /// Verkäufer (User-ID)
  late final _i1.ColumnInt sellerId;

  /// Angebot das gekauft wird
  late final _i1.ColumnInt listingId;

  /// Aktueller Status der Transaktion
  late final _i1.ColumnEnum<_i2.TransactionStatus> status;

  /// Gekaufte Menge
  late final _i1.ColumnDouble quantity;

  /// Gesamtpreis in Cents
  late final _i1.ColumnInt totalPriceCents;

  /// Gewählte Zahlungsmethode
  late final _i1.ColumnEnum<_i3.PaymentMethod> paymentMethod;

  /// Erstellungszeitpunkt
  late final _i1.ColumnDateTime createdAt;

  /// Letzte Aktualisierung
  late final _i1.ColumnDateTime updatedAt;

  /// Zeitpunkt als versendet markiert
  late final _i1.ColumnDateTime shippedAt;

  /// Zeitpunkt als erhalten markiert
  late final _i1.ColumnDateTime receivedAt;

  /// Zeitpunkt des Abschlusses
  late final _i1.ColumnDateTime completedAt;

  /// Datum für automatischen Abschluss (14 Tage nach shipped)
  late final _i1.ColumnDateTime autoCompleteAt;

  /// Optionale Nachricht vom Käufer
  late final _i1.ColumnString buyerNote;

  @override
  List<_i1.Column> get columns => [
        id,
        buyerId,
        sellerId,
        listingId,
        status,
        quantity,
        totalPriceCents,
        paymentMethod,
        createdAt,
        updatedAt,
        shippedAt,
        receivedAt,
        completedAt,
        autoCompleteAt,
        buyerNote,
      ];
}

class TransactionInclude extends _i1.IncludeObject {
  TransactionInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Transaction.t;
}

class TransactionIncludeList extends _i1.IncludeList {
  TransactionIncludeList._({
    _i1.WhereExpressionBuilder<TransactionTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Transaction.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Transaction.t;
}

class TransactionRepository {
  const TransactionRepository._();

  /// Returns a list of [Transaction]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<Transaction>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<TransactionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TransactionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TransactionTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Transaction>(
      where: where?.call(Transaction.t),
      orderBy: orderBy?.call(Transaction.t),
      orderByList: orderByList?.call(Transaction.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Transaction] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<Transaction?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<TransactionTable>? where,
    int? offset,
    _i1.OrderByBuilder<TransactionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TransactionTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Transaction>(
      where: where?.call(Transaction.t),
      orderBy: orderBy?.call(Transaction.t),
      orderByList: orderByList?.call(Transaction.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Transaction] by its [id] or null if no such row exists.
  Future<Transaction?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Transaction>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Transaction]s in the list and returns the inserted rows.
  ///
  /// The returned [Transaction]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Transaction>> insert(
    _i1.Session session,
    List<Transaction> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Transaction>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Transaction] and returns the inserted row.
  ///
  /// The returned [Transaction] will have its `id` field set.
  Future<Transaction> insertRow(
    _i1.Session session,
    Transaction row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Transaction>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Transaction]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Transaction>> update(
    _i1.Session session,
    List<Transaction> rows, {
    _i1.ColumnSelections<TransactionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Transaction>(
      rows,
      columns: columns?.call(Transaction.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Transaction]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Transaction> updateRow(
    _i1.Session session,
    Transaction row, {
    _i1.ColumnSelections<TransactionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Transaction>(
      row,
      columns: columns?.call(Transaction.t),
      transaction: transaction,
    );
  }

  /// Deletes all [Transaction]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Transaction>> delete(
    _i1.Session session,
    List<Transaction> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Transaction>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Transaction].
  Future<Transaction> deleteRow(
    _i1.Session session,
    Transaction row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Transaction>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Transaction>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<TransactionTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Transaction>(
      where: where(Transaction.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<TransactionTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Transaction>(
      where: where?.call(Transaction.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
