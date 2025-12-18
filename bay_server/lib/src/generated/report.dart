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
import 'report_status.dart' as _i2;
import 'report_target_type.dart' as _i3;
import 'report_reason.dart' as _i4;

/// Report for listings or users
abstract class Report implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Report._({
    this.id,
    required this.reporterId,
    required this.targetType,
    required this.targetId,
    required this.reason,
    this.details,
    _i2.ReportStatus? status,
    this.assignedModeratorId,
    this.moderatorNotes,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.resolvedAt,
  })  : status = status ?? _i2.ReportStatus.open,
        createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  factory Report({
    int? id,
    required int reporterId,
    required _i3.ReportTargetType targetType,
    required int targetId,
    required _i4.ReportReason reason,
    String? details,
    _i2.ReportStatus? status,
    int? assignedModeratorId,
    String? moderatorNotes,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? resolvedAt,
  }) = _ReportImpl;

  factory Report.fromJson(Map<String, dynamic> jsonSerialization) {
    return Report(
      id: jsonSerialization['id'] as int?,
      reporterId: jsonSerialization['reporterId'] as int,
      targetType: _i3.ReportTargetType.fromJson(
          (jsonSerialization['targetType'] as int)),
      targetId: jsonSerialization['targetId'] as int,
      reason: _i4.ReportReason.fromJson((jsonSerialization['reason'] as int)),
      details: jsonSerialization['details'] as String?,
      status: _i2.ReportStatus.fromJson((jsonSerialization['status'] as int)),
      assignedModeratorId: jsonSerialization['assignedModeratorId'] as int?,
      moderatorNotes: jsonSerialization['moderatorNotes'] as String?,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
      resolvedAt: jsonSerialization['resolvedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['resolvedAt']),
    );
  }

  static final t = ReportTable();

  static const db = ReportRepository._();

  @override
  int? id;

  /// User who created the report
  int reporterId;

  /// Type of entity being reported (listing or user)
  _i3.ReportTargetType targetType;

  /// ID of the reported entity
  int targetId;

  /// Reason for the report
  _i4.ReportReason reason;

  /// Additional details provided by reporter
  String? details;

  /// Current status of the report
  _i2.ReportStatus status;

  /// Moderator who is handling this report
  int? assignedModeratorId;

  /// Internal notes from moderators
  String? moderatorNotes;

  /// When the report was created
  DateTime createdAt;

  /// When the report status was last updated
  DateTime updatedAt;

  /// When the report was resolved
  DateTime? resolvedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Report]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Report copyWith({
    int? id,
    int? reporterId,
    _i3.ReportTargetType? targetType,
    int? targetId,
    _i4.ReportReason? reason,
    String? details,
    _i2.ReportStatus? status,
    int? assignedModeratorId,
    String? moderatorNotes,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? resolvedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'reporterId': reporterId,
      'targetType': targetType.toJson(),
      'targetId': targetId,
      'reason': reason.toJson(),
      if (details != null) 'details': details,
      'status': status.toJson(),
      if (assignedModeratorId != null)
        'assignedModeratorId': assignedModeratorId,
      if (moderatorNotes != null) 'moderatorNotes': moderatorNotes,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
      if (resolvedAt != null) 'resolvedAt': resolvedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'reporterId': reporterId,
      'targetType': targetType.toJson(),
      'targetId': targetId,
      'reason': reason.toJson(),
      if (details != null) 'details': details,
      'status': status.toJson(),
      if (assignedModeratorId != null)
        'assignedModeratorId': assignedModeratorId,
      if (moderatorNotes != null) 'moderatorNotes': moderatorNotes,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
      if (resolvedAt != null) 'resolvedAt': resolvedAt?.toJson(),
    };
  }

  static ReportInclude include() {
    return ReportInclude._();
  }

  static ReportIncludeList includeList({
    _i1.WhereExpressionBuilder<ReportTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ReportTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ReportTable>? orderByList,
    ReportInclude? include,
  }) {
    return ReportIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Report.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Report.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ReportImpl extends Report {
  _ReportImpl({
    int? id,
    required int reporterId,
    required _i3.ReportTargetType targetType,
    required int targetId,
    required _i4.ReportReason reason,
    String? details,
    _i2.ReportStatus? status,
    int? assignedModeratorId,
    String? moderatorNotes,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? resolvedAt,
  }) : super._(
          id: id,
          reporterId: reporterId,
          targetType: targetType,
          targetId: targetId,
          reason: reason,
          details: details,
          status: status,
          assignedModeratorId: assignedModeratorId,
          moderatorNotes: moderatorNotes,
          createdAt: createdAt,
          updatedAt: updatedAt,
          resolvedAt: resolvedAt,
        );

  /// Returns a shallow copy of this [Report]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Report copyWith({
    Object? id = _Undefined,
    int? reporterId,
    _i3.ReportTargetType? targetType,
    int? targetId,
    _i4.ReportReason? reason,
    Object? details = _Undefined,
    _i2.ReportStatus? status,
    Object? assignedModeratorId = _Undefined,
    Object? moderatorNotes = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
    Object? resolvedAt = _Undefined,
  }) {
    return Report(
      id: id is int? ? id : this.id,
      reporterId: reporterId ?? this.reporterId,
      targetType: targetType ?? this.targetType,
      targetId: targetId ?? this.targetId,
      reason: reason ?? this.reason,
      details: details is String? ? details : this.details,
      status: status ?? this.status,
      assignedModeratorId: assignedModeratorId is int?
          ? assignedModeratorId
          : this.assignedModeratorId,
      moderatorNotes:
          moderatorNotes is String? ? moderatorNotes : this.moderatorNotes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      resolvedAt: resolvedAt is DateTime? ? resolvedAt : this.resolvedAt,
    );
  }
}

class ReportTable extends _i1.Table<int?> {
  ReportTable({super.tableRelation}) : super(tableName: 'reports') {
    reporterId = _i1.ColumnInt(
      'reporterId',
      this,
    );
    targetType = _i1.ColumnEnum(
      'targetType',
      this,
      _i1.EnumSerialization.byIndex,
    );
    targetId = _i1.ColumnInt(
      'targetId',
      this,
    );
    reason = _i1.ColumnEnum(
      'reason',
      this,
      _i1.EnumSerialization.byIndex,
    );
    details = _i1.ColumnString(
      'details',
      this,
    );
    status = _i1.ColumnEnum(
      'status',
      this,
      _i1.EnumSerialization.byIndex,
      hasDefault: true,
    );
    assignedModeratorId = _i1.ColumnInt(
      'assignedModeratorId',
      this,
    );
    moderatorNotes = _i1.ColumnString(
      'moderatorNotes',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
      hasDefault: true,
    );
    resolvedAt = _i1.ColumnDateTime(
      'resolvedAt',
      this,
    );
  }

  /// User who created the report
  late final _i1.ColumnInt reporterId;

  /// Type of entity being reported (listing or user)
  late final _i1.ColumnEnum<_i3.ReportTargetType> targetType;

  /// ID of the reported entity
  late final _i1.ColumnInt targetId;

  /// Reason for the report
  late final _i1.ColumnEnum<_i4.ReportReason> reason;

  /// Additional details provided by reporter
  late final _i1.ColumnString details;

  /// Current status of the report
  late final _i1.ColumnEnum<_i2.ReportStatus> status;

  /// Moderator who is handling this report
  late final _i1.ColumnInt assignedModeratorId;

  /// Internal notes from moderators
  late final _i1.ColumnString moderatorNotes;

  /// When the report was created
  late final _i1.ColumnDateTime createdAt;

  /// When the report status was last updated
  late final _i1.ColumnDateTime updatedAt;

  /// When the report was resolved
  late final _i1.ColumnDateTime resolvedAt;

  @override
  List<_i1.Column> get columns => [
        id,
        reporterId,
        targetType,
        targetId,
        reason,
        details,
        status,
        assignedModeratorId,
        moderatorNotes,
        createdAt,
        updatedAt,
        resolvedAt,
      ];
}

class ReportInclude extends _i1.IncludeObject {
  ReportInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Report.t;
}

class ReportIncludeList extends _i1.IncludeList {
  ReportIncludeList._({
    _i1.WhereExpressionBuilder<ReportTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Report.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Report.t;
}

class ReportRepository {
  const ReportRepository._();

  /// Returns a list of [Report]s matching the given query parameters.
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
  Future<List<Report>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ReportTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ReportTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ReportTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Report>(
      where: where?.call(Report.t),
      orderBy: orderBy?.call(Report.t),
      orderByList: orderByList?.call(Report.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Report] matching the given query parameters.
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
  Future<Report?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ReportTable>? where,
    int? offset,
    _i1.OrderByBuilder<ReportTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ReportTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Report>(
      where: where?.call(Report.t),
      orderBy: orderBy?.call(Report.t),
      orderByList: orderByList?.call(Report.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Report] by its [id] or null if no such row exists.
  Future<Report?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Report>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Report]s in the list and returns the inserted rows.
  ///
  /// The returned [Report]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Report>> insert(
    _i1.Session session,
    List<Report> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Report>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Report] and returns the inserted row.
  ///
  /// The returned [Report] will have its `id` field set.
  Future<Report> insertRow(
    _i1.Session session,
    Report row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Report>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Report]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Report>> update(
    _i1.Session session,
    List<Report> rows, {
    _i1.ColumnSelections<ReportTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Report>(
      rows,
      columns: columns?.call(Report.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Report]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Report> updateRow(
    _i1.Session session,
    Report row, {
    _i1.ColumnSelections<ReportTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Report>(
      row,
      columns: columns?.call(Report.t),
      transaction: transaction,
    );
  }

  /// Deletes all [Report]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Report>> delete(
    _i1.Session session,
    List<Report> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Report>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Report].
  Future<Report> deleteRow(
    _i1.Session session,
    Report row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Report>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Report>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ReportTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Report>(
      where: where(Report.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ReportTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Report>(
      where: where?.call(Report.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
