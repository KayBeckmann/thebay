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

/// Log entry for user ban/unban actions
abstract class UserBanLog
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  UserBanLog._({
    this.id,
    required this.userId,
    required this.adminId,
    required this.action,
    this.reason,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory UserBanLog({
    int? id,
    required int userId,
    required int adminId,
    required String action,
    String? reason,
    DateTime? createdAt,
  }) = _UserBanLogImpl;

  factory UserBanLog.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserBanLog(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      adminId: jsonSerialization['adminId'] as int,
      action: jsonSerialization['action'] as String,
      reason: jsonSerialization['reason'] as String?,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = UserBanLogTable();

  static const db = UserBanLogRepository._();

  @override
  int? id;

  /// User who was banned/unbanned
  int userId;

  /// Admin who performed the action
  int adminId;

  /// Action type: ban or unban
  String action;

  /// Reason for the action
  String? reason;

  /// Timestamp of the action
  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [UserBanLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UserBanLog copyWith({
    int? id,
    int? userId,
    int? adminId,
    String? action,
    String? reason,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'adminId': adminId,
      'action': action,
      if (reason != null) 'reason': reason,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'adminId': adminId,
      'action': action,
      if (reason != null) 'reason': reason,
      'createdAt': createdAt.toJson(),
    };
  }

  static UserBanLogInclude include() {
    return UserBanLogInclude._();
  }

  static UserBanLogIncludeList includeList({
    _i1.WhereExpressionBuilder<UserBanLogTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserBanLogTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserBanLogTable>? orderByList,
    UserBanLogInclude? include,
  }) {
    return UserBanLogIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(UserBanLog.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(UserBanLog.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserBanLogImpl extends UserBanLog {
  _UserBanLogImpl({
    int? id,
    required int userId,
    required int adminId,
    required String action,
    String? reason,
    DateTime? createdAt,
  }) : super._(
          id: id,
          userId: userId,
          adminId: adminId,
          action: action,
          reason: reason,
          createdAt: createdAt,
        );

  /// Returns a shallow copy of this [UserBanLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UserBanLog copyWith({
    Object? id = _Undefined,
    int? userId,
    int? adminId,
    String? action,
    Object? reason = _Undefined,
    DateTime? createdAt,
  }) {
    return UserBanLog(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      adminId: adminId ?? this.adminId,
      action: action ?? this.action,
      reason: reason is String? ? reason : this.reason,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class UserBanLogTable extends _i1.Table<int?> {
  UserBanLogTable({super.tableRelation}) : super(tableName: 'user_ban_log') {
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    adminId = _i1.ColumnInt(
      'adminId',
      this,
    );
    action = _i1.ColumnString(
      'action',
      this,
    );
    reason = _i1.ColumnString(
      'reason',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  /// User who was banned/unbanned
  late final _i1.ColumnInt userId;

  /// Admin who performed the action
  late final _i1.ColumnInt adminId;

  /// Action type: ban or unban
  late final _i1.ColumnString action;

  /// Reason for the action
  late final _i1.ColumnString reason;

  /// Timestamp of the action
  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
        id,
        userId,
        adminId,
        action,
        reason,
        createdAt,
      ];
}

class UserBanLogInclude extends _i1.IncludeObject {
  UserBanLogInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => UserBanLog.t;
}

class UserBanLogIncludeList extends _i1.IncludeList {
  UserBanLogIncludeList._({
    _i1.WhereExpressionBuilder<UserBanLogTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(UserBanLog.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => UserBanLog.t;
}

class UserBanLogRepository {
  const UserBanLogRepository._();

  /// Returns a list of [UserBanLog]s matching the given query parameters.
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
  Future<List<UserBanLog>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserBanLogTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserBanLogTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserBanLogTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<UserBanLog>(
      where: where?.call(UserBanLog.t),
      orderBy: orderBy?.call(UserBanLog.t),
      orderByList: orderByList?.call(UserBanLog.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [UserBanLog] matching the given query parameters.
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
  Future<UserBanLog?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserBanLogTable>? where,
    int? offset,
    _i1.OrderByBuilder<UserBanLogTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserBanLogTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<UserBanLog>(
      where: where?.call(UserBanLog.t),
      orderBy: orderBy?.call(UserBanLog.t),
      orderByList: orderByList?.call(UserBanLog.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [UserBanLog] by its [id] or null if no such row exists.
  Future<UserBanLog?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<UserBanLog>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [UserBanLog]s in the list and returns the inserted rows.
  ///
  /// The returned [UserBanLog]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<UserBanLog>> insert(
    _i1.Session session,
    List<UserBanLog> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<UserBanLog>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [UserBanLog] and returns the inserted row.
  ///
  /// The returned [UserBanLog] will have its `id` field set.
  Future<UserBanLog> insertRow(
    _i1.Session session,
    UserBanLog row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<UserBanLog>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [UserBanLog]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<UserBanLog>> update(
    _i1.Session session,
    List<UserBanLog> rows, {
    _i1.ColumnSelections<UserBanLogTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<UserBanLog>(
      rows,
      columns: columns?.call(UserBanLog.t),
      transaction: transaction,
    );
  }

  /// Updates a single [UserBanLog]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<UserBanLog> updateRow(
    _i1.Session session,
    UserBanLog row, {
    _i1.ColumnSelections<UserBanLogTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<UserBanLog>(
      row,
      columns: columns?.call(UserBanLog.t),
      transaction: transaction,
    );
  }

  /// Deletes all [UserBanLog]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<UserBanLog>> delete(
    _i1.Session session,
    List<UserBanLog> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<UserBanLog>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [UserBanLog].
  Future<UserBanLog> deleteRow(
    _i1.Session session,
    UserBanLog row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<UserBanLog>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<UserBanLog>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<UserBanLogTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<UserBanLog>(
      where: where(UserBanLog.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserBanLogTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<UserBanLog>(
      where: where?.call(UserBanLog.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
