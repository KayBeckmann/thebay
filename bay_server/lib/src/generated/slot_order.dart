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
import 'payment_method.dart' as _i2;
import 'order_status.dart' as _i3;

/// Slot-Bestellungen - Kaufvorgänge für Slots
abstract class SlotOrder
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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

  static final t = SlotOrderTable();

  static const db = SlotOrderRepository._();

  @override
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

  @override
  _i1.Table<int?> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
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

  static SlotOrderInclude include() {
    return SlotOrderInclude._();
  }

  static SlotOrderIncludeList includeList({
    _i1.WhereExpressionBuilder<SlotOrderTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SlotOrderTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SlotOrderTable>? orderByList,
    SlotOrderInclude? include,
  }) {
    return SlotOrderIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SlotOrder.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(SlotOrder.t),
      include: include,
    );
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

class SlotOrderTable extends _i1.Table<int?> {
  SlotOrderTable({super.tableRelation}) : super(tableName: 'slot_orders') {
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    slotVariantId = _i1.ColumnInt(
      'slotVariantId',
      this,
    );
    paymentMethod = _i1.ColumnEnum(
      'paymentMethod',
      this,
      _i1.EnumSerialization.byIndex,
    );
    amountCents = _i1.ColumnInt(
      'amountCents',
      this,
    );
    transactionId = _i1.ColumnString(
      'transactionId',
      this,
    );
    status = _i1.ColumnEnum(
      'status',
      this,
      _i1.EnumSerialization.byIndex,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
    paidAt = _i1.ColumnDateTime(
      'paidAt',
      this,
    );
    completedAt = _i1.ColumnDateTime(
      'completedAt',
      this,
    );
  }

  late final _i1.ColumnInt userId;

  late final _i1.ColumnInt slotVariantId;

  /// Zahlung
  late final _i1.ColumnEnum<_i2.PaymentMethod> paymentMethod;

  late final _i1.ColumnInt amountCents;

  late final _i1.ColumnString transactionId;

  /// Status
  late final _i1.ColumnEnum<_i3.OrderStatus> status;

  /// Timestamps
  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime paidAt;

  late final _i1.ColumnDateTime completedAt;

  @override
  List<_i1.Column> get columns => [
        id,
        userId,
        slotVariantId,
        paymentMethod,
        amountCents,
        transactionId,
        status,
        createdAt,
        paidAt,
        completedAt,
      ];
}

class SlotOrderInclude extends _i1.IncludeObject {
  SlotOrderInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => SlotOrder.t;
}

class SlotOrderIncludeList extends _i1.IncludeList {
  SlotOrderIncludeList._({
    _i1.WhereExpressionBuilder<SlotOrderTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SlotOrder.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => SlotOrder.t;
}

class SlotOrderRepository {
  const SlotOrderRepository._();

  /// Returns a list of [SlotOrder]s matching the given query parameters.
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
  Future<List<SlotOrder>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SlotOrderTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SlotOrderTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SlotOrderTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<SlotOrder>(
      where: where?.call(SlotOrder.t),
      orderBy: orderBy?.call(SlotOrder.t),
      orderByList: orderByList?.call(SlotOrder.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [SlotOrder] matching the given query parameters.
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
  Future<SlotOrder?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SlotOrderTable>? where,
    int? offset,
    _i1.OrderByBuilder<SlotOrderTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SlotOrderTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<SlotOrder>(
      where: where?.call(SlotOrder.t),
      orderBy: orderBy?.call(SlotOrder.t),
      orderByList: orderByList?.call(SlotOrder.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [SlotOrder] by its [id] or null if no such row exists.
  Future<SlotOrder?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<SlotOrder>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [SlotOrder]s in the list and returns the inserted rows.
  ///
  /// The returned [SlotOrder]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<SlotOrder>> insert(
    _i1.Session session,
    List<SlotOrder> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<SlotOrder>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [SlotOrder] and returns the inserted row.
  ///
  /// The returned [SlotOrder] will have its `id` field set.
  Future<SlotOrder> insertRow(
    _i1.Session session,
    SlotOrder row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<SlotOrder>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [SlotOrder]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<SlotOrder>> update(
    _i1.Session session,
    List<SlotOrder> rows, {
    _i1.ColumnSelections<SlotOrderTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<SlotOrder>(
      rows,
      columns: columns?.call(SlotOrder.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SlotOrder]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SlotOrder> updateRow(
    _i1.Session session,
    SlotOrder row, {
    _i1.ColumnSelections<SlotOrderTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<SlotOrder>(
      row,
      columns: columns?.call(SlotOrder.t),
      transaction: transaction,
    );
  }

  /// Deletes all [SlotOrder]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<SlotOrder>> delete(
    _i1.Session session,
    List<SlotOrder> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<SlotOrder>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [SlotOrder].
  Future<SlotOrder> deleteRow(
    _i1.Session session,
    SlotOrder row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SlotOrder>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<SlotOrder>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<SlotOrderTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<SlotOrder>(
      where: where(SlotOrder.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SlotOrderTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<SlotOrder>(
      where: where?.call(SlotOrder.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
