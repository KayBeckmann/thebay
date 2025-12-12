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

/// User-Slots - Gekaufte Slots eines Benutzers
abstract class UserSlot
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  UserSlot._({
    this.id,
    required this.userId,
    required this.slotVariantId,
    this.listingId,
    required this.purchasedAt,
    required this.expiresAt,
    required this.isActive,
    required this.isUsed,
  });

  factory UserSlot({
    int? id,
    required int userId,
    required int slotVariantId,
    int? listingId,
    required DateTime purchasedAt,
    required DateTime expiresAt,
    required bool isActive,
    required bool isUsed,
  }) = _UserSlotImpl;

  factory UserSlot.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserSlot(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      slotVariantId: jsonSerialization['slotVariantId'] as int,
      listingId: jsonSerialization['listingId'] as int?,
      purchasedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['purchasedAt']),
      expiresAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['expiresAt']),
      isActive: jsonSerialization['isActive'] as bool,
      isUsed: jsonSerialization['isUsed'] as bool,
    );
  }

  static final t = UserSlotTable();

  static const db = UserSlotRepository._();

  @override
  int? id;

  int userId;

  int slotVariantId;

  int? listingId;

  /// Laufzeit
  DateTime purchasedAt;

  DateTime expiresAt;

  /// Status
  bool isActive;

  /// Status
  bool isUsed;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [UserSlot]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UserSlot copyWith({
    int? id,
    int? userId,
    int? slotVariantId,
    int? listingId,
    DateTime? purchasedAt,
    DateTime? expiresAt,
    bool? isActive,
    bool? isUsed,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'slotVariantId': slotVariantId,
      if (listingId != null) 'listingId': listingId,
      'purchasedAt': purchasedAt.toJson(),
      'expiresAt': expiresAt.toJson(),
      'isActive': isActive,
      'isUsed': isUsed,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'slotVariantId': slotVariantId,
      if (listingId != null) 'listingId': listingId,
      'purchasedAt': purchasedAt.toJson(),
      'expiresAt': expiresAt.toJson(),
      'isActive': isActive,
      'isUsed': isUsed,
    };
  }

  static UserSlotInclude include() {
    return UserSlotInclude._();
  }

  static UserSlotIncludeList includeList({
    _i1.WhereExpressionBuilder<UserSlotTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserSlotTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserSlotTable>? orderByList,
    UserSlotInclude? include,
  }) {
    return UserSlotIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(UserSlot.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(UserSlot.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserSlotImpl extends UserSlot {
  _UserSlotImpl({
    int? id,
    required int userId,
    required int slotVariantId,
    int? listingId,
    required DateTime purchasedAt,
    required DateTime expiresAt,
    required bool isActive,
    required bool isUsed,
  }) : super._(
          id: id,
          userId: userId,
          slotVariantId: slotVariantId,
          listingId: listingId,
          purchasedAt: purchasedAt,
          expiresAt: expiresAt,
          isActive: isActive,
          isUsed: isUsed,
        );

  /// Returns a shallow copy of this [UserSlot]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UserSlot copyWith({
    Object? id = _Undefined,
    int? userId,
    int? slotVariantId,
    Object? listingId = _Undefined,
    DateTime? purchasedAt,
    DateTime? expiresAt,
    bool? isActive,
    bool? isUsed,
  }) {
    return UserSlot(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      slotVariantId: slotVariantId ?? this.slotVariantId,
      listingId: listingId is int? ? listingId : this.listingId,
      purchasedAt: purchasedAt ?? this.purchasedAt,
      expiresAt: expiresAt ?? this.expiresAt,
      isActive: isActive ?? this.isActive,
      isUsed: isUsed ?? this.isUsed,
    );
  }
}

class UserSlotTable extends _i1.Table<int?> {
  UserSlotTable({super.tableRelation}) : super(tableName: 'user_slots') {
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    slotVariantId = _i1.ColumnInt(
      'slotVariantId',
      this,
    );
    listingId = _i1.ColumnInt(
      'listingId',
      this,
    );
    purchasedAt = _i1.ColumnDateTime(
      'purchasedAt',
      this,
    );
    expiresAt = _i1.ColumnDateTime(
      'expiresAt',
      this,
    );
    isActive = _i1.ColumnBool(
      'isActive',
      this,
    );
    isUsed = _i1.ColumnBool(
      'isUsed',
      this,
    );
  }

  late final _i1.ColumnInt userId;

  late final _i1.ColumnInt slotVariantId;

  late final _i1.ColumnInt listingId;

  /// Laufzeit
  late final _i1.ColumnDateTime purchasedAt;

  late final _i1.ColumnDateTime expiresAt;

  /// Status
  late final _i1.ColumnBool isActive;

  /// Status
  late final _i1.ColumnBool isUsed;

  @override
  List<_i1.Column> get columns => [
        id,
        userId,
        slotVariantId,
        listingId,
        purchasedAt,
        expiresAt,
        isActive,
        isUsed,
      ];
}

class UserSlotInclude extends _i1.IncludeObject {
  UserSlotInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => UserSlot.t;
}

class UserSlotIncludeList extends _i1.IncludeList {
  UserSlotIncludeList._({
    _i1.WhereExpressionBuilder<UserSlotTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(UserSlot.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => UserSlot.t;
}

class UserSlotRepository {
  const UserSlotRepository._();

  /// Returns a list of [UserSlot]s matching the given query parameters.
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
  Future<List<UserSlot>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserSlotTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserSlotTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserSlotTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<UserSlot>(
      where: where?.call(UserSlot.t),
      orderBy: orderBy?.call(UserSlot.t),
      orderByList: orderByList?.call(UserSlot.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [UserSlot] matching the given query parameters.
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
  Future<UserSlot?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserSlotTable>? where,
    int? offset,
    _i1.OrderByBuilder<UserSlotTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserSlotTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<UserSlot>(
      where: where?.call(UserSlot.t),
      orderBy: orderBy?.call(UserSlot.t),
      orderByList: orderByList?.call(UserSlot.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [UserSlot] by its [id] or null if no such row exists.
  Future<UserSlot?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<UserSlot>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [UserSlot]s in the list and returns the inserted rows.
  ///
  /// The returned [UserSlot]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<UserSlot>> insert(
    _i1.Session session,
    List<UserSlot> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<UserSlot>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [UserSlot] and returns the inserted row.
  ///
  /// The returned [UserSlot] will have its `id` field set.
  Future<UserSlot> insertRow(
    _i1.Session session,
    UserSlot row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<UserSlot>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [UserSlot]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<UserSlot>> update(
    _i1.Session session,
    List<UserSlot> rows, {
    _i1.ColumnSelections<UserSlotTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<UserSlot>(
      rows,
      columns: columns?.call(UserSlot.t),
      transaction: transaction,
    );
  }

  /// Updates a single [UserSlot]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<UserSlot> updateRow(
    _i1.Session session,
    UserSlot row, {
    _i1.ColumnSelections<UserSlotTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<UserSlot>(
      row,
      columns: columns?.call(UserSlot.t),
      transaction: transaction,
    );
  }

  /// Deletes all [UserSlot]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<UserSlot>> delete(
    _i1.Session session,
    List<UserSlot> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<UserSlot>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [UserSlot].
  Future<UserSlot> deleteRow(
    _i1.Session session,
    UserSlot row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<UserSlot>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<UserSlot>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<UserSlotTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<UserSlot>(
      where: where(UserSlot.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserSlotTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<UserSlot>(
      where: where?.call(UserSlot.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
