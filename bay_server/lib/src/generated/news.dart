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

/// News article for dashboard announcements
abstract class News implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  News._({
    this.id,
    required this.title,
    required this.content,
    required this.authorId,
    required this.isPublished,
    this.publishedAt,
    this.expiresAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory News({
    int? id,
    required String title,
    required String content,
    required int authorId,
    required bool isPublished,
    DateTime? publishedAt,
    DateTime? expiresAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _NewsImpl;

  factory News.fromJson(Map<String, dynamic> jsonSerialization) {
    return News(
      id: jsonSerialization['id'] as int?,
      title: jsonSerialization['title'] as String,
      content: jsonSerialization['content'] as String,
      authorId: jsonSerialization['authorId'] as int,
      isPublished: jsonSerialization['isPublished'] as bool,
      publishedAt: jsonSerialization['publishedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['publishedAt']),
      expiresAt: jsonSerialization['expiresAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['expiresAt']),
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = NewsTable();

  static const db = NewsRepository._();

  @override
  int? id;

  /// News title
  String title;

  /// News content (supports markdown)
  String content;

  /// Author user ID
  int authorId;

  /// Whether news is published
  bool isPublished;

  /// Publication date
  DateTime? publishedAt;

  /// Expiration date (auto-delete after this date)
  DateTime? expiresAt;

  /// Creation timestamp
  DateTime createdAt;

  /// Last modification timestamp
  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [News]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  News copyWith({
    int? id,
    String? title,
    String? content,
    int? authorId,
    bool? isPublished,
    DateTime? publishedAt,
    DateTime? expiresAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'title': title,
      'content': content,
      'authorId': authorId,
      'isPublished': isPublished,
      if (publishedAt != null) 'publishedAt': publishedAt?.toJson(),
      if (expiresAt != null) 'expiresAt': expiresAt?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'title': title,
      'content': content,
      'authorId': authorId,
      'isPublished': isPublished,
      if (publishedAt != null) 'publishedAt': publishedAt?.toJson(),
      if (expiresAt != null) 'expiresAt': expiresAt?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static NewsInclude include() {
    return NewsInclude._();
  }

  static NewsIncludeList includeList({
    _i1.WhereExpressionBuilder<NewsTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<NewsTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<NewsTable>? orderByList,
    NewsInclude? include,
  }) {
    return NewsIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(News.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(News.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _NewsImpl extends News {
  _NewsImpl({
    int? id,
    required String title,
    required String content,
    required int authorId,
    required bool isPublished,
    DateTime? publishedAt,
    DateTime? expiresAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
          id: id,
          title: title,
          content: content,
          authorId: authorId,
          isPublished: isPublished,
          publishedAt: publishedAt,
          expiresAt: expiresAt,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [News]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  News copyWith({
    Object? id = _Undefined,
    String? title,
    String? content,
    int? authorId,
    bool? isPublished,
    Object? publishedAt = _Undefined,
    Object? expiresAt = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return News(
      id: id is int? ? id : this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      authorId: authorId ?? this.authorId,
      isPublished: isPublished ?? this.isPublished,
      publishedAt: publishedAt is DateTime? ? publishedAt : this.publishedAt,
      expiresAt: expiresAt is DateTime? ? expiresAt : this.expiresAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class NewsTable extends _i1.Table<int?> {
  NewsTable({super.tableRelation}) : super(tableName: 'news') {
    title = _i1.ColumnString(
      'title',
      this,
    );
    content = _i1.ColumnString(
      'content',
      this,
    );
    authorId = _i1.ColumnInt(
      'authorId',
      this,
    );
    isPublished = _i1.ColumnBool(
      'isPublished',
      this,
    );
    publishedAt = _i1.ColumnDateTime(
      'publishedAt',
      this,
    );
    expiresAt = _i1.ColumnDateTime(
      'expiresAt',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
    );
  }

  /// News title
  late final _i1.ColumnString title;

  /// News content (supports markdown)
  late final _i1.ColumnString content;

  /// Author user ID
  late final _i1.ColumnInt authorId;

  /// Whether news is published
  late final _i1.ColumnBool isPublished;

  /// Publication date
  late final _i1.ColumnDateTime publishedAt;

  /// Expiration date (auto-delete after this date)
  late final _i1.ColumnDateTime expiresAt;

  /// Creation timestamp
  late final _i1.ColumnDateTime createdAt;

  /// Last modification timestamp
  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
        id,
        title,
        content,
        authorId,
        isPublished,
        publishedAt,
        expiresAt,
        createdAt,
        updatedAt,
      ];
}

class NewsInclude extends _i1.IncludeObject {
  NewsInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => News.t;
}

class NewsIncludeList extends _i1.IncludeList {
  NewsIncludeList._({
    _i1.WhereExpressionBuilder<NewsTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(News.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => News.t;
}

class NewsRepository {
  const NewsRepository._();

  /// Returns a list of [News]s matching the given query parameters.
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
  Future<List<News>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<NewsTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<NewsTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<NewsTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<News>(
      where: where?.call(News.t),
      orderBy: orderBy?.call(News.t),
      orderByList: orderByList?.call(News.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [News] matching the given query parameters.
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
  Future<News?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<NewsTable>? where,
    int? offset,
    _i1.OrderByBuilder<NewsTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<NewsTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<News>(
      where: where?.call(News.t),
      orderBy: orderBy?.call(News.t),
      orderByList: orderByList?.call(News.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [News] by its [id] or null if no such row exists.
  Future<News?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<News>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [News]s in the list and returns the inserted rows.
  ///
  /// The returned [News]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<News>> insert(
    _i1.Session session,
    List<News> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<News>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [News] and returns the inserted row.
  ///
  /// The returned [News] will have its `id` field set.
  Future<News> insertRow(
    _i1.Session session,
    News row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<News>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [News]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<News>> update(
    _i1.Session session,
    List<News> rows, {
    _i1.ColumnSelections<NewsTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<News>(
      rows,
      columns: columns?.call(News.t),
      transaction: transaction,
    );
  }

  /// Updates a single [News]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<News> updateRow(
    _i1.Session session,
    News row, {
    _i1.ColumnSelections<NewsTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<News>(
      row,
      columns: columns?.call(News.t),
      transaction: transaction,
    );
  }

  /// Deletes all [News]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<News>> delete(
    _i1.Session session,
    List<News> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<News>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [News].
  Future<News> deleteRow(
    _i1.Session session,
    News row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<News>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<News>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<NewsTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<News>(
      where: where(News.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<NewsTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<News>(
      where: where?.call(News.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
