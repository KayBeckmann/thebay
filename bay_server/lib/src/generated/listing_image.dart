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

/// Bilder zu Angeboten
abstract class ListingImage
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  ListingImage._({
    this.id,
    required this.listingId,
    required this.fileName,
    required this.originalName,
    required this.mimeType,
    required this.sizeBytes,
    required this.sortOrder,
    required this.createdAt,
  });

  factory ListingImage({
    int? id,
    required int listingId,
    required String fileName,
    required String originalName,
    required String mimeType,
    required int sizeBytes,
    required int sortOrder,
    required DateTime createdAt,
  }) = _ListingImageImpl;

  factory ListingImage.fromJson(Map<String, dynamic> jsonSerialization) {
    return ListingImage(
      id: jsonSerialization['id'] as int?,
      listingId: jsonSerialization['listingId'] as int,
      fileName: jsonSerialization['fileName'] as String,
      originalName: jsonSerialization['originalName'] as String,
      mimeType: jsonSerialization['mimeType'] as String,
      sizeBytes: jsonSerialization['sizeBytes'] as int,
      sortOrder: jsonSerialization['sortOrder'] as int,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = ListingImageTable();

  static const db = ListingImageRepository._();

  @override
  int? id;

  int listingId;

  String fileName;

  String originalName;

  String mimeType;

  int sizeBytes;

  int sortOrder;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [ListingImage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ListingImage copyWith({
    int? id,
    int? listingId,
    String? fileName,
    String? originalName,
    String? mimeType,
    int? sizeBytes,
    int? sortOrder,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'listingId': listingId,
      'fileName': fileName,
      'originalName': originalName,
      'mimeType': mimeType,
      'sizeBytes': sizeBytes,
      'sortOrder': sortOrder,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'listingId': listingId,
      'fileName': fileName,
      'originalName': originalName,
      'mimeType': mimeType,
      'sizeBytes': sizeBytes,
      'sortOrder': sortOrder,
      'createdAt': createdAt.toJson(),
    };
  }

  static ListingImageInclude include() {
    return ListingImageInclude._();
  }

  static ListingImageIncludeList includeList({
    _i1.WhereExpressionBuilder<ListingImageTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ListingImageTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ListingImageTable>? orderByList,
    ListingImageInclude? include,
  }) {
    return ListingImageIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ListingImage.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ListingImage.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ListingImageImpl extends ListingImage {
  _ListingImageImpl({
    int? id,
    required int listingId,
    required String fileName,
    required String originalName,
    required String mimeType,
    required int sizeBytes,
    required int sortOrder,
    required DateTime createdAt,
  }) : super._(
          id: id,
          listingId: listingId,
          fileName: fileName,
          originalName: originalName,
          mimeType: mimeType,
          sizeBytes: sizeBytes,
          sortOrder: sortOrder,
          createdAt: createdAt,
        );

  /// Returns a shallow copy of this [ListingImage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ListingImage copyWith({
    Object? id = _Undefined,
    int? listingId,
    String? fileName,
    String? originalName,
    String? mimeType,
    int? sizeBytes,
    int? sortOrder,
    DateTime? createdAt,
  }) {
    return ListingImage(
      id: id is int? ? id : this.id,
      listingId: listingId ?? this.listingId,
      fileName: fileName ?? this.fileName,
      originalName: originalName ?? this.originalName,
      mimeType: mimeType ?? this.mimeType,
      sizeBytes: sizeBytes ?? this.sizeBytes,
      sortOrder: sortOrder ?? this.sortOrder,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class ListingImageTable extends _i1.Table<int?> {
  ListingImageTable({super.tableRelation})
      : super(tableName: 'listing_images') {
    listingId = _i1.ColumnInt(
      'listingId',
      this,
    );
    fileName = _i1.ColumnString(
      'fileName',
      this,
    );
    originalName = _i1.ColumnString(
      'originalName',
      this,
    );
    mimeType = _i1.ColumnString(
      'mimeType',
      this,
    );
    sizeBytes = _i1.ColumnInt(
      'sizeBytes',
      this,
    );
    sortOrder = _i1.ColumnInt(
      'sortOrder',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final _i1.ColumnInt listingId;

  late final _i1.ColumnString fileName;

  late final _i1.ColumnString originalName;

  late final _i1.ColumnString mimeType;

  late final _i1.ColumnInt sizeBytes;

  late final _i1.ColumnInt sortOrder;

  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
        id,
        listingId,
        fileName,
        originalName,
        mimeType,
        sizeBytes,
        sortOrder,
        createdAt,
      ];
}

class ListingImageInclude extends _i1.IncludeObject {
  ListingImageInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => ListingImage.t;
}

class ListingImageIncludeList extends _i1.IncludeList {
  ListingImageIncludeList._({
    _i1.WhereExpressionBuilder<ListingImageTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ListingImage.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ListingImage.t;
}

class ListingImageRepository {
  const ListingImageRepository._();

  /// Returns a list of [ListingImage]s matching the given query parameters.
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
  Future<List<ListingImage>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ListingImageTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ListingImageTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ListingImageTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<ListingImage>(
      where: where?.call(ListingImage.t),
      orderBy: orderBy?.call(ListingImage.t),
      orderByList: orderByList?.call(ListingImage.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [ListingImage] matching the given query parameters.
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
  Future<ListingImage?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ListingImageTable>? where,
    int? offset,
    _i1.OrderByBuilder<ListingImageTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ListingImageTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<ListingImage>(
      where: where?.call(ListingImage.t),
      orderBy: orderBy?.call(ListingImage.t),
      orderByList: orderByList?.call(ListingImage.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [ListingImage] by its [id] or null if no such row exists.
  Future<ListingImage?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<ListingImage>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [ListingImage]s in the list and returns the inserted rows.
  ///
  /// The returned [ListingImage]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<ListingImage>> insert(
    _i1.Session session,
    List<ListingImage> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<ListingImage>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [ListingImage] and returns the inserted row.
  ///
  /// The returned [ListingImage] will have its `id` field set.
  Future<ListingImage> insertRow(
    _i1.Session session,
    ListingImage row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ListingImage>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ListingImage]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ListingImage>> update(
    _i1.Session session,
    List<ListingImage> rows, {
    _i1.ColumnSelections<ListingImageTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ListingImage>(
      rows,
      columns: columns?.call(ListingImage.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ListingImage]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ListingImage> updateRow(
    _i1.Session session,
    ListingImage row, {
    _i1.ColumnSelections<ListingImageTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ListingImage>(
      row,
      columns: columns?.call(ListingImage.t),
      transaction: transaction,
    );
  }

  /// Deletes all [ListingImage]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ListingImage>> delete(
    _i1.Session session,
    List<ListingImage> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ListingImage>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ListingImage].
  Future<ListingImage> deleteRow(
    _i1.Session session,
    ListingImage row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ListingImage>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ListingImage>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ListingImageTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ListingImage>(
      where: where(ListingImage.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ListingImageTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ListingImage>(
      where: where?.call(ListingImage.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
