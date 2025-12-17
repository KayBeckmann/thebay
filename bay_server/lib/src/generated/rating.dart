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
import 'rating_value.dart' as _i2;

/// Bewertung nach abgeschlossener Transaktion
abstract class Rating implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Rating._({
    this.id,
    required this.transactionId,
    required this.fromUserId,
    required this.toUserId,
    required this.rating,
    this.comment,
    required this.createdAt,
    bool? isAutomatic,
  }) : isAutomatic = isAutomatic ?? false;

  factory Rating({
    int? id,
    required int transactionId,
    required int fromUserId,
    required int toUserId,
    required _i2.RatingValue rating,
    String? comment,
    required DateTime createdAt,
    bool? isAutomatic,
  }) = _RatingImpl;

  factory Rating.fromJson(Map<String, dynamic> jsonSerialization) {
    return Rating(
      id: jsonSerialization['id'] as int?,
      transactionId: jsonSerialization['transactionId'] as int,
      fromUserId: jsonSerialization['fromUserId'] as int,
      toUserId: jsonSerialization['toUserId'] as int,
      rating: _i2.RatingValue.fromJson((jsonSerialization['rating'] as int)),
      comment: jsonSerialization['comment'] as String?,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      isAutomatic: jsonSerialization['isAutomatic'] as bool,
    );
  }

  static final t = RatingTable();

  static const db = RatingRepository._();

  @override
  int? id;

  /// Zugehörige Transaktion
  int transactionId;

  /// Benutzer der die Bewertung abgibt
  int fromUserId;

  /// Benutzer der bewertet wird
  int toUserId;

  /// Bewertungswert (positiv/neutral/negativ)
  _i2.RatingValue rating;

  /// Optionaler Kommentar (max 500 Zeichen)
  String? comment;

  /// Erstellungszeitpunkt
  DateTime createdAt;

  /// Ob die Bewertung automatisch erstellt wurde
  bool isAutomatic;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Rating]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Rating copyWith({
    int? id,
    int? transactionId,
    int? fromUserId,
    int? toUserId,
    _i2.RatingValue? rating,
    String? comment,
    DateTime? createdAt,
    bool? isAutomatic,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'transactionId': transactionId,
      'fromUserId': fromUserId,
      'toUserId': toUserId,
      'rating': rating.toJson(),
      if (comment != null) 'comment': comment,
      'createdAt': createdAt.toJson(),
      'isAutomatic': isAutomatic,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'transactionId': transactionId,
      'fromUserId': fromUserId,
      'toUserId': toUserId,
      'rating': rating.toJson(),
      if (comment != null) 'comment': comment,
      'createdAt': createdAt.toJson(),
      'isAutomatic': isAutomatic,
    };
  }

  static RatingInclude include() {
    return RatingInclude._();
  }

  static RatingIncludeList includeList({
    _i1.WhereExpressionBuilder<RatingTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RatingTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RatingTable>? orderByList,
    RatingInclude? include,
  }) {
    return RatingIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Rating.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Rating.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RatingImpl extends Rating {
  _RatingImpl({
    int? id,
    required int transactionId,
    required int fromUserId,
    required int toUserId,
    required _i2.RatingValue rating,
    String? comment,
    required DateTime createdAt,
    bool? isAutomatic,
  }) : super._(
          id: id,
          transactionId: transactionId,
          fromUserId: fromUserId,
          toUserId: toUserId,
          rating: rating,
          comment: comment,
          createdAt: createdAt,
          isAutomatic: isAutomatic,
        );

  /// Returns a shallow copy of this [Rating]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Rating copyWith({
    Object? id = _Undefined,
    int? transactionId,
    int? fromUserId,
    int? toUserId,
    _i2.RatingValue? rating,
    Object? comment = _Undefined,
    DateTime? createdAt,
    bool? isAutomatic,
  }) {
    return Rating(
      id: id is int? ? id : this.id,
      transactionId: transactionId ?? this.transactionId,
      fromUserId: fromUserId ?? this.fromUserId,
      toUserId: toUserId ?? this.toUserId,
      rating: rating ?? this.rating,
      comment: comment is String? ? comment : this.comment,
      createdAt: createdAt ?? this.createdAt,
      isAutomatic: isAutomatic ?? this.isAutomatic,
    );
  }
}

class RatingTable extends _i1.Table<int?> {
  RatingTable({super.tableRelation}) : super(tableName: 'ratings') {
    transactionId = _i1.ColumnInt(
      'transactionId',
      this,
    );
    fromUserId = _i1.ColumnInt(
      'fromUserId',
      this,
    );
    toUserId = _i1.ColumnInt(
      'toUserId',
      this,
    );
    rating = _i1.ColumnEnum(
      'rating',
      this,
      _i1.EnumSerialization.byIndex,
    );
    comment = _i1.ColumnString(
      'comment',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
    isAutomatic = _i1.ColumnBool(
      'isAutomatic',
      this,
      hasDefault: true,
    );
  }

  /// Zugehörige Transaktion
  late final _i1.ColumnInt transactionId;

  /// Benutzer der die Bewertung abgibt
  late final _i1.ColumnInt fromUserId;

  /// Benutzer der bewertet wird
  late final _i1.ColumnInt toUserId;

  /// Bewertungswert (positiv/neutral/negativ)
  late final _i1.ColumnEnum<_i2.RatingValue> rating;

  /// Optionaler Kommentar (max 500 Zeichen)
  late final _i1.ColumnString comment;

  /// Erstellungszeitpunkt
  late final _i1.ColumnDateTime createdAt;

  /// Ob die Bewertung automatisch erstellt wurde
  late final _i1.ColumnBool isAutomatic;

  @override
  List<_i1.Column> get columns => [
        id,
        transactionId,
        fromUserId,
        toUserId,
        rating,
        comment,
        createdAt,
        isAutomatic,
      ];
}

class RatingInclude extends _i1.IncludeObject {
  RatingInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Rating.t;
}

class RatingIncludeList extends _i1.IncludeList {
  RatingIncludeList._({
    _i1.WhereExpressionBuilder<RatingTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Rating.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Rating.t;
}

class RatingRepository {
  const RatingRepository._();

  /// Returns a list of [Rating]s matching the given query parameters.
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
  Future<List<Rating>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RatingTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RatingTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RatingTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Rating>(
      where: where?.call(Rating.t),
      orderBy: orderBy?.call(Rating.t),
      orderByList: orderByList?.call(Rating.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Rating] matching the given query parameters.
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
  Future<Rating?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RatingTable>? where,
    int? offset,
    _i1.OrderByBuilder<RatingTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RatingTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Rating>(
      where: where?.call(Rating.t),
      orderBy: orderBy?.call(Rating.t),
      orderByList: orderByList?.call(Rating.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Rating] by its [id] or null if no such row exists.
  Future<Rating?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Rating>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Rating]s in the list and returns the inserted rows.
  ///
  /// The returned [Rating]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Rating>> insert(
    _i1.Session session,
    List<Rating> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Rating>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Rating] and returns the inserted row.
  ///
  /// The returned [Rating] will have its `id` field set.
  Future<Rating> insertRow(
    _i1.Session session,
    Rating row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Rating>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Rating]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Rating>> update(
    _i1.Session session,
    List<Rating> rows, {
    _i1.ColumnSelections<RatingTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Rating>(
      rows,
      columns: columns?.call(Rating.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Rating]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Rating> updateRow(
    _i1.Session session,
    Rating row, {
    _i1.ColumnSelections<RatingTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Rating>(
      row,
      columns: columns?.call(Rating.t),
      transaction: transaction,
    );
  }

  /// Deletes all [Rating]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Rating>> delete(
    _i1.Session session,
    List<Rating> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Rating>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Rating].
  Future<Rating> deleteRow(
    _i1.Session session,
    Rating row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Rating>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Rating>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<RatingTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Rating>(
      where: where(Rating.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RatingTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Rating>(
      where: where?.call(Rating.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
