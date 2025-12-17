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

/// User payment information for profile display
abstract class UserPaymentInfo
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  UserPaymentInfo._({
    this.id,
    required this.userId,
    this.paypalAddress,
    this.bitcoinWallet,
    required this.updatedAt,
  });

  factory UserPaymentInfo({
    int? id,
    required int userId,
    String? paypalAddress,
    String? bitcoinWallet,
    required DateTime updatedAt,
  }) = _UserPaymentInfoImpl;

  factory UserPaymentInfo.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserPaymentInfo(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      paypalAddress: jsonSerialization['paypalAddress'] as String?,
      bitcoinWallet: jsonSerialization['bitcoinWallet'] as String?,
      updatedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = UserPaymentInfoTable();

  static const db = UserPaymentInfoRepository._();

  @override
  int? id;

  /// Reference to user
  int userId;

  /// PayPal email address (optional)
  String? paypalAddress;

  /// Bitcoin wallet address (optional)
  String? bitcoinWallet;

  /// Last modification timestamp
  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [UserPaymentInfo]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UserPaymentInfo copyWith({
    int? id,
    int? userId,
    String? paypalAddress,
    String? bitcoinWallet,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      if (paypalAddress != null) 'paypalAddress': paypalAddress,
      if (bitcoinWallet != null) 'bitcoinWallet': bitcoinWallet,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      if (paypalAddress != null) 'paypalAddress': paypalAddress,
      if (bitcoinWallet != null) 'bitcoinWallet': bitcoinWallet,
      'updatedAt': updatedAt.toJson(),
    };
  }

  static UserPaymentInfoInclude include() {
    return UserPaymentInfoInclude._();
  }

  static UserPaymentInfoIncludeList includeList({
    _i1.WhereExpressionBuilder<UserPaymentInfoTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserPaymentInfoTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserPaymentInfoTable>? orderByList,
    UserPaymentInfoInclude? include,
  }) {
    return UserPaymentInfoIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(UserPaymentInfo.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(UserPaymentInfo.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserPaymentInfoImpl extends UserPaymentInfo {
  _UserPaymentInfoImpl({
    int? id,
    required int userId,
    String? paypalAddress,
    String? bitcoinWallet,
    required DateTime updatedAt,
  }) : super._(
          id: id,
          userId: userId,
          paypalAddress: paypalAddress,
          bitcoinWallet: bitcoinWallet,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [UserPaymentInfo]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UserPaymentInfo copyWith({
    Object? id = _Undefined,
    int? userId,
    Object? paypalAddress = _Undefined,
    Object? bitcoinWallet = _Undefined,
    DateTime? updatedAt,
  }) {
    return UserPaymentInfo(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      paypalAddress:
          paypalAddress is String? ? paypalAddress : this.paypalAddress,
      bitcoinWallet:
          bitcoinWallet is String? ? bitcoinWallet : this.bitcoinWallet,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class UserPaymentInfoTable extends _i1.Table<int?> {
  UserPaymentInfoTable({super.tableRelation})
      : super(tableName: 'user_payment_info') {
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    paypalAddress = _i1.ColumnString(
      'paypalAddress',
      this,
    );
    bitcoinWallet = _i1.ColumnString(
      'bitcoinWallet',
      this,
    );
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
    );
  }

  /// Reference to user
  late final _i1.ColumnInt userId;

  /// PayPal email address (optional)
  late final _i1.ColumnString paypalAddress;

  /// Bitcoin wallet address (optional)
  late final _i1.ColumnString bitcoinWallet;

  /// Last modification timestamp
  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
        id,
        userId,
        paypalAddress,
        bitcoinWallet,
        updatedAt,
      ];
}

class UserPaymentInfoInclude extends _i1.IncludeObject {
  UserPaymentInfoInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => UserPaymentInfo.t;
}

class UserPaymentInfoIncludeList extends _i1.IncludeList {
  UserPaymentInfoIncludeList._({
    _i1.WhereExpressionBuilder<UserPaymentInfoTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(UserPaymentInfo.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => UserPaymentInfo.t;
}

class UserPaymentInfoRepository {
  const UserPaymentInfoRepository._();

  /// Returns a list of [UserPaymentInfo]s matching the given query parameters.
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
  Future<List<UserPaymentInfo>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserPaymentInfoTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserPaymentInfoTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserPaymentInfoTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<UserPaymentInfo>(
      where: where?.call(UserPaymentInfo.t),
      orderBy: orderBy?.call(UserPaymentInfo.t),
      orderByList: orderByList?.call(UserPaymentInfo.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [UserPaymentInfo] matching the given query parameters.
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
  Future<UserPaymentInfo?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserPaymentInfoTable>? where,
    int? offset,
    _i1.OrderByBuilder<UserPaymentInfoTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserPaymentInfoTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<UserPaymentInfo>(
      where: where?.call(UserPaymentInfo.t),
      orderBy: orderBy?.call(UserPaymentInfo.t),
      orderByList: orderByList?.call(UserPaymentInfo.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [UserPaymentInfo] by its [id] or null if no such row exists.
  Future<UserPaymentInfo?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<UserPaymentInfo>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [UserPaymentInfo]s in the list and returns the inserted rows.
  ///
  /// The returned [UserPaymentInfo]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<UserPaymentInfo>> insert(
    _i1.Session session,
    List<UserPaymentInfo> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<UserPaymentInfo>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [UserPaymentInfo] and returns the inserted row.
  ///
  /// The returned [UserPaymentInfo] will have its `id` field set.
  Future<UserPaymentInfo> insertRow(
    _i1.Session session,
    UserPaymentInfo row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<UserPaymentInfo>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [UserPaymentInfo]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<UserPaymentInfo>> update(
    _i1.Session session,
    List<UserPaymentInfo> rows, {
    _i1.ColumnSelections<UserPaymentInfoTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<UserPaymentInfo>(
      rows,
      columns: columns?.call(UserPaymentInfo.t),
      transaction: transaction,
    );
  }

  /// Updates a single [UserPaymentInfo]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<UserPaymentInfo> updateRow(
    _i1.Session session,
    UserPaymentInfo row, {
    _i1.ColumnSelections<UserPaymentInfoTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<UserPaymentInfo>(
      row,
      columns: columns?.call(UserPaymentInfo.t),
      transaction: transaction,
    );
  }

  /// Deletes all [UserPaymentInfo]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<UserPaymentInfo>> delete(
    _i1.Session session,
    List<UserPaymentInfo> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<UserPaymentInfo>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [UserPaymentInfo].
  Future<UserPaymentInfo> deleteRow(
    _i1.Session session,
    UserPaymentInfo row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<UserPaymentInfo>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<UserPaymentInfo>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<UserPaymentInfoTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<UserPaymentInfo>(
      where: where(UserPaymentInfo.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserPaymentInfoTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<UserPaymentInfo>(
      where: where?.call(UserPaymentInfo.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
