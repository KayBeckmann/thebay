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
import 'dispute_status.dart' as _i2;

/// Reklamation zu einer Transaktion
abstract class Dispute
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Dispute._({
    this.id,
    required this.transactionId,
    required this.openedByUserId,
    required this.reason,
    _i2.DisputeStatus? status,
    this.resolution,
    this.moderatorId,
    required this.createdAt,
    this.resolvedAt,
  }) : status = status ?? _i2.DisputeStatus.open;

  factory Dispute({
    int? id,
    required int transactionId,
    required int openedByUserId,
    required String reason,
    _i2.DisputeStatus? status,
    String? resolution,
    int? moderatorId,
    required DateTime createdAt,
    DateTime? resolvedAt,
  }) = _DisputeImpl;

  factory Dispute.fromJson(Map<String, dynamic> jsonSerialization) {
    return Dispute(
      id: jsonSerialization['id'] as int?,
      transactionId: jsonSerialization['transactionId'] as int,
      openedByUserId: jsonSerialization['openedByUserId'] as int,
      reason: jsonSerialization['reason'] as String,
      status: _i2.DisputeStatus.fromJson((jsonSerialization['status'] as int)),
      resolution: jsonSerialization['resolution'] as String?,
      moderatorId: jsonSerialization['moderatorId'] as int?,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      resolvedAt: jsonSerialization['resolvedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['resolvedAt']),
    );
  }

  static final t = DisputeTable();

  static const db = DisputeRepository._();

  @override
  int? id;

  /// Zugehörige Transaktion
  int transactionId;

  /// Benutzer der die Reklamation eröffnet hat
  int openedByUserId;

  /// Grund für die Reklamation
  String reason;

  /// Aktueller Status
  _i2.DisputeStatus status;

  /// Lösung/Ergebnis (vom Moderator eingetragen)
  String? resolution;

  /// Moderator der die Reklamation bearbeitet
  int? moderatorId;

  /// Erstellungszeitpunkt
  DateTime createdAt;

  /// Zeitpunkt der Lösung
  DateTime? resolvedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Dispute]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Dispute copyWith({
    int? id,
    int? transactionId,
    int? openedByUserId,
    String? reason,
    _i2.DisputeStatus? status,
    String? resolution,
    int? moderatorId,
    DateTime? createdAt,
    DateTime? resolvedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'transactionId': transactionId,
      'openedByUserId': openedByUserId,
      'reason': reason,
      'status': status.toJson(),
      if (resolution != null) 'resolution': resolution,
      if (moderatorId != null) 'moderatorId': moderatorId,
      'createdAt': createdAt.toJson(),
      if (resolvedAt != null) 'resolvedAt': resolvedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'transactionId': transactionId,
      'openedByUserId': openedByUserId,
      'reason': reason,
      'status': status.toJson(),
      if (resolution != null) 'resolution': resolution,
      if (moderatorId != null) 'moderatorId': moderatorId,
      'createdAt': createdAt.toJson(),
      if (resolvedAt != null) 'resolvedAt': resolvedAt?.toJson(),
    };
  }

  static DisputeInclude include() {
    return DisputeInclude._();
  }

  static DisputeIncludeList includeList({
    _i1.WhereExpressionBuilder<DisputeTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DisputeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DisputeTable>? orderByList,
    DisputeInclude? include,
  }) {
    return DisputeIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Dispute.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Dispute.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DisputeImpl extends Dispute {
  _DisputeImpl({
    int? id,
    required int transactionId,
    required int openedByUserId,
    required String reason,
    _i2.DisputeStatus? status,
    String? resolution,
    int? moderatorId,
    required DateTime createdAt,
    DateTime? resolvedAt,
  }) : super._(
          id: id,
          transactionId: transactionId,
          openedByUserId: openedByUserId,
          reason: reason,
          status: status,
          resolution: resolution,
          moderatorId: moderatorId,
          createdAt: createdAt,
          resolvedAt: resolvedAt,
        );

  /// Returns a shallow copy of this [Dispute]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Dispute copyWith({
    Object? id = _Undefined,
    int? transactionId,
    int? openedByUserId,
    String? reason,
    _i2.DisputeStatus? status,
    Object? resolution = _Undefined,
    Object? moderatorId = _Undefined,
    DateTime? createdAt,
    Object? resolvedAt = _Undefined,
  }) {
    return Dispute(
      id: id is int? ? id : this.id,
      transactionId: transactionId ?? this.transactionId,
      openedByUserId: openedByUserId ?? this.openedByUserId,
      reason: reason ?? this.reason,
      status: status ?? this.status,
      resolution: resolution is String? ? resolution : this.resolution,
      moderatorId: moderatorId is int? ? moderatorId : this.moderatorId,
      createdAt: createdAt ?? this.createdAt,
      resolvedAt: resolvedAt is DateTime? ? resolvedAt : this.resolvedAt,
    );
  }
}

class DisputeTable extends _i1.Table<int?> {
  DisputeTable({super.tableRelation}) : super(tableName: 'disputes') {
    transactionId = _i1.ColumnInt(
      'transactionId',
      this,
    );
    openedByUserId = _i1.ColumnInt(
      'openedByUserId',
      this,
    );
    reason = _i1.ColumnString(
      'reason',
      this,
    );
    status = _i1.ColumnEnum(
      'status',
      this,
      _i1.EnumSerialization.byIndex,
      hasDefault: true,
    );
    resolution = _i1.ColumnString(
      'resolution',
      this,
    );
    moderatorId = _i1.ColumnInt(
      'moderatorId',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
    resolvedAt = _i1.ColumnDateTime(
      'resolvedAt',
      this,
    );
  }

  /// Zugehörige Transaktion
  late final _i1.ColumnInt transactionId;

  /// Benutzer der die Reklamation eröffnet hat
  late final _i1.ColumnInt openedByUserId;

  /// Grund für die Reklamation
  late final _i1.ColumnString reason;

  /// Aktueller Status
  late final _i1.ColumnEnum<_i2.DisputeStatus> status;

  /// Lösung/Ergebnis (vom Moderator eingetragen)
  late final _i1.ColumnString resolution;

  /// Moderator der die Reklamation bearbeitet
  late final _i1.ColumnInt moderatorId;

  /// Erstellungszeitpunkt
  late final _i1.ColumnDateTime createdAt;

  /// Zeitpunkt der Lösung
  late final _i1.ColumnDateTime resolvedAt;

  @override
  List<_i1.Column> get columns => [
        id,
        transactionId,
        openedByUserId,
        reason,
        status,
        resolution,
        moderatorId,
        createdAt,
        resolvedAt,
      ];
}

class DisputeInclude extends _i1.IncludeObject {
  DisputeInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Dispute.t;
}

class DisputeIncludeList extends _i1.IncludeList {
  DisputeIncludeList._({
    _i1.WhereExpressionBuilder<DisputeTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Dispute.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Dispute.t;
}

class DisputeRepository {
  const DisputeRepository._();

  /// Returns a list of [Dispute]s matching the given query parameters.
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
  Future<List<Dispute>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<DisputeTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DisputeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DisputeTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Dispute>(
      where: where?.call(Dispute.t),
      orderBy: orderBy?.call(Dispute.t),
      orderByList: orderByList?.call(Dispute.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Dispute] matching the given query parameters.
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
  Future<Dispute?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<DisputeTable>? where,
    int? offset,
    _i1.OrderByBuilder<DisputeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DisputeTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Dispute>(
      where: where?.call(Dispute.t),
      orderBy: orderBy?.call(Dispute.t),
      orderByList: orderByList?.call(Dispute.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Dispute] by its [id] or null if no such row exists.
  Future<Dispute?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Dispute>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Dispute]s in the list and returns the inserted rows.
  ///
  /// The returned [Dispute]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Dispute>> insert(
    _i1.Session session,
    List<Dispute> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Dispute>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Dispute] and returns the inserted row.
  ///
  /// The returned [Dispute] will have its `id` field set.
  Future<Dispute> insertRow(
    _i1.Session session,
    Dispute row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Dispute>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Dispute]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Dispute>> update(
    _i1.Session session,
    List<Dispute> rows, {
    _i1.ColumnSelections<DisputeTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Dispute>(
      rows,
      columns: columns?.call(Dispute.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Dispute]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Dispute> updateRow(
    _i1.Session session,
    Dispute row, {
    _i1.ColumnSelections<DisputeTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Dispute>(
      row,
      columns: columns?.call(Dispute.t),
      transaction: transaction,
    );
  }

  /// Deletes all [Dispute]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Dispute>> delete(
    _i1.Session session,
    List<Dispute> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Dispute>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Dispute].
  Future<Dispute> deleteRow(
    _i1.Session session,
    Dispute row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Dispute>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Dispute>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<DisputeTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Dispute>(
      where: where(Dispute.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<DisputeTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Dispute>(
      where: where?.call(Dispute.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
