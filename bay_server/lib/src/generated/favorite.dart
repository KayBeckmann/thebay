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

/// Favoriten-Tabelle für Benutzer-Lesezeichen
abstract class Favorite
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Favorite._({
    this.id,
    required this.userId,
    required this.listingId,
    required this.createdAt,
  });

  factory Favorite({
    int? id,
    required int userId,
    required int listingId,
    required DateTime createdAt,
  }) = _FavoriteImpl;

  factory Favorite.fromJson(Map<String, dynamic> jsonSerialization) {
    return Favorite(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      listingId: jsonSerialization['listingId'] as int,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = FavoriteTable();

  static const db = FavoriteRepository._();

  @override
  int? id;

  /// Benutzer, der das Angebot favorisiert hat
  int userId;

  /// Das favorisierte Angebot
  int listingId;

  /// Zeitstempel der Erstellung
  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Favorite]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Favorite copyWith({
    int? id,
    int? userId,
    int? listingId,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'listingId': listingId,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'listingId': listingId,
      'createdAt': createdAt.toJson(),
    };
  }

  static FavoriteInclude include() {
    return FavoriteInclude._();
  }

  static FavoriteIncludeList includeList({
    _i1.WhereExpressionBuilder<FavoriteTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FavoriteTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FavoriteTable>? orderByList,
    FavoriteInclude? include,
  }) {
    return FavoriteIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Favorite.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Favorite.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FavoriteImpl extends Favorite {
  _FavoriteImpl({
    int? id,
    required int userId,
    required int listingId,
    required DateTime createdAt,
  }) : super._(
          id: id,
          userId: userId,
          listingId: listingId,
          createdAt: createdAt,
        );

  /// Returns a shallow copy of this [Favorite]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Favorite copyWith({
    Object? id = _Undefined,
    int? userId,
    int? listingId,
    DateTime? createdAt,
  }) {
    return Favorite(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      listingId: listingId ?? this.listingId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class FavoriteTable extends _i1.Table<int?> {
  FavoriteTable({super.tableRelation}) : super(tableName: 'favorites') {
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    listingId = _i1.ColumnInt(
      'listingId',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  /// Benutzer, der das Angebot favorisiert hat
  late final _i1.ColumnInt userId;

  /// Das favorisierte Angebot
  late final _i1.ColumnInt listingId;

  /// Zeitstempel der Erstellung
  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
        id,
        userId,
        listingId,
        createdAt,
      ];
}

class FavoriteInclude extends _i1.IncludeObject {
  FavoriteInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Favorite.t;
}

class FavoriteIncludeList extends _i1.IncludeList {
  FavoriteIncludeList._({
    _i1.WhereExpressionBuilder<FavoriteTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Favorite.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Favorite.t;
}

class FavoriteRepository {
  const FavoriteRepository._();

  /// Returns a list of [Favorite]s matching the given query parameters.
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
  Future<List<Favorite>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FavoriteTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FavoriteTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FavoriteTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Favorite>(
      where: where?.call(Favorite.t),
      orderBy: orderBy?.call(Favorite.t),
      orderByList: orderByList?.call(Favorite.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Favorite] matching the given query parameters.
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
  Future<Favorite?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FavoriteTable>? where,
    int? offset,
    _i1.OrderByBuilder<FavoriteTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FavoriteTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Favorite>(
      where: where?.call(Favorite.t),
      orderBy: orderBy?.call(Favorite.t),
      orderByList: orderByList?.call(Favorite.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Favorite] by its [id] or null if no such row exists.
  Future<Favorite?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Favorite>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Favorite]s in the list and returns the inserted rows.
  ///
  /// The returned [Favorite]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Favorite>> insert(
    _i1.Session session,
    List<Favorite> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Favorite>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Favorite] and returns the inserted row.
  ///
  /// The returned [Favorite] will have its `id` field set.
  Future<Favorite> insertRow(
    _i1.Session session,
    Favorite row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Favorite>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Favorite]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Favorite>> update(
    _i1.Session session,
    List<Favorite> rows, {
    _i1.ColumnSelections<FavoriteTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Favorite>(
      rows,
      columns: columns?.call(Favorite.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Favorite]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Favorite> updateRow(
    _i1.Session session,
    Favorite row, {
    _i1.ColumnSelections<FavoriteTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Favorite>(
      row,
      columns: columns?.call(Favorite.t),
      transaction: transaction,
    );
  }

  /// Deletes all [Favorite]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Favorite>> delete(
    _i1.Session session,
    List<Favorite> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Favorite>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Favorite].
  Future<Favorite> deleteRow(
    _i1.Session session,
    Favorite row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Favorite>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Favorite>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<FavoriteTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Favorite>(
      where: where(Favorite.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FavoriteTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Favorite>(
      where: where?.call(Favorite.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
