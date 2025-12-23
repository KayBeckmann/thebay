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

/// Slot variant defining pricing and duration for listing slots
abstract class SlotVariant
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  SlotVariant._({
    this.id,
    required this.name,
    this.description,
    required this.priceUsdCents,
    required this.durationDays,
    required this.allowPaypal,
    required this.allowBitcoin,
    required this.isActive,
    bool? isFree,
    required this.sortOrder,
    required this.createdAt,
    required this.updatedAt,
  }) : isFree = isFree ?? false;

  factory SlotVariant({
    int? id,
    required String name,
    String? description,
    required int priceUsdCents,
    required int durationDays,
    required bool allowPaypal,
    required bool allowBitcoin,
    required bool isActive,
    bool? isFree,
    required int sortOrder,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _SlotVariantImpl;

  factory SlotVariant.fromJson(Map<String, dynamic> jsonSerialization) {
    return SlotVariant(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      description: jsonSerialization['description'] as String?,
      priceUsdCents: jsonSerialization['priceUsdCents'] as int,
      durationDays: jsonSerialization['durationDays'] as int,
      allowPaypal: jsonSerialization['allowPaypal'] as bool,
      allowBitcoin: jsonSerialization['allowBitcoin'] as bool,
      isActive: jsonSerialization['isActive'] as bool,
      isFree: jsonSerialization['isFree'] as bool,
      sortOrder: jsonSerialization['sortOrder'] as int,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = SlotVariantTable();

  static const db = SlotVariantRepository._();

  @override
  int? id;

  /// Variant name (e.g., "Basic", "Premium", "30 Days")
  String name;

  /// Description of what's included
  String? description;

  /// Price in cents (USD)
  int priceUsdCents;

  /// Duration in days
  int durationDays;

  /// Whether PayPal payment is allowed
  bool allowPaypal;

  /// Whether Bitcoin payment is allowed
  bool allowBitcoin;

  /// Whether this variant is active and available for purchase
  bool isActive;

  /// Whether this is a free promotion slot (no payment required)
  bool isFree;

  /// Sort order for display
  int sortOrder;

  /// Creation timestamp
  DateTime createdAt;

  /// Last modification timestamp
  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [SlotVariant]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SlotVariant copyWith({
    int? id,
    String? name,
    String? description,
    int? priceUsdCents,
    int? durationDays,
    bool? allowPaypal,
    bool? allowBitcoin,
    bool? isActive,
    bool? isFree,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      if (description != null) 'description': description,
      'priceUsdCents': priceUsdCents,
      'durationDays': durationDays,
      'allowPaypal': allowPaypal,
      'allowBitcoin': allowBitcoin,
      'isActive': isActive,
      'isFree': isFree,
      'sortOrder': sortOrder,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'name': name,
      if (description != null) 'description': description,
      'priceUsdCents': priceUsdCents,
      'durationDays': durationDays,
      'allowPaypal': allowPaypal,
      'allowBitcoin': allowBitcoin,
      'isActive': isActive,
      'isFree': isFree,
      'sortOrder': sortOrder,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static SlotVariantInclude include() {
    return SlotVariantInclude._();
  }

  static SlotVariantIncludeList includeList({
    _i1.WhereExpressionBuilder<SlotVariantTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SlotVariantTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SlotVariantTable>? orderByList,
    SlotVariantInclude? include,
  }) {
    return SlotVariantIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SlotVariant.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(SlotVariant.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SlotVariantImpl extends SlotVariant {
  _SlotVariantImpl({
    int? id,
    required String name,
    String? description,
    required int priceUsdCents,
    required int durationDays,
    required bool allowPaypal,
    required bool allowBitcoin,
    required bool isActive,
    bool? isFree,
    required int sortOrder,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
          id: id,
          name: name,
          description: description,
          priceUsdCents: priceUsdCents,
          durationDays: durationDays,
          allowPaypal: allowPaypal,
          allowBitcoin: allowBitcoin,
          isActive: isActive,
          isFree: isFree,
          sortOrder: sortOrder,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [SlotVariant]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SlotVariant copyWith({
    Object? id = _Undefined,
    String? name,
    Object? description = _Undefined,
    int? priceUsdCents,
    int? durationDays,
    bool? allowPaypal,
    bool? allowBitcoin,
    bool? isActive,
    bool? isFree,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return SlotVariant(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      description: description is String? ? description : this.description,
      priceUsdCents: priceUsdCents ?? this.priceUsdCents,
      durationDays: durationDays ?? this.durationDays,
      allowPaypal: allowPaypal ?? this.allowPaypal,
      allowBitcoin: allowBitcoin ?? this.allowBitcoin,
      isActive: isActive ?? this.isActive,
      isFree: isFree ?? this.isFree,
      sortOrder: sortOrder ?? this.sortOrder,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class SlotVariantTable extends _i1.Table<int?> {
  SlotVariantTable({super.tableRelation}) : super(tableName: 'slot_variants') {
    name = _i1.ColumnString(
      'name',
      this,
    );
    description = _i1.ColumnString(
      'description',
      this,
    );
    priceUsdCents = _i1.ColumnInt(
      'priceUsdCents',
      this,
    );
    durationDays = _i1.ColumnInt(
      'durationDays',
      this,
    );
    allowPaypal = _i1.ColumnBool(
      'allowPaypal',
      this,
    );
    allowBitcoin = _i1.ColumnBool(
      'allowBitcoin',
      this,
    );
    isActive = _i1.ColumnBool(
      'isActive',
      this,
    );
    isFree = _i1.ColumnBool(
      'isFree',
      this,
      hasDefault: true,
    );
    sortOrder = _i1.ColumnInt(
      'sortOrder',
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

  /// Variant name (e.g., "Basic", "Premium", "30 Days")
  late final _i1.ColumnString name;

  /// Description of what's included
  late final _i1.ColumnString description;

  /// Price in cents (USD)
  late final _i1.ColumnInt priceUsdCents;

  /// Duration in days
  late final _i1.ColumnInt durationDays;

  /// Whether PayPal payment is allowed
  late final _i1.ColumnBool allowPaypal;

  /// Whether Bitcoin payment is allowed
  late final _i1.ColumnBool allowBitcoin;

  /// Whether this variant is active and available for purchase
  late final _i1.ColumnBool isActive;

  /// Whether this is a free promotion slot (no payment required)
  late final _i1.ColumnBool isFree;

  /// Sort order for display
  late final _i1.ColumnInt sortOrder;

  /// Creation timestamp
  late final _i1.ColumnDateTime createdAt;

  /// Last modification timestamp
  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
        id,
        name,
        description,
        priceUsdCents,
        durationDays,
        allowPaypal,
        allowBitcoin,
        isActive,
        isFree,
        sortOrder,
        createdAt,
        updatedAt,
      ];
}

class SlotVariantInclude extends _i1.IncludeObject {
  SlotVariantInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => SlotVariant.t;
}

class SlotVariantIncludeList extends _i1.IncludeList {
  SlotVariantIncludeList._({
    _i1.WhereExpressionBuilder<SlotVariantTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SlotVariant.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => SlotVariant.t;
}

class SlotVariantRepository {
  const SlotVariantRepository._();

  /// Returns a list of [SlotVariant]s matching the given query parameters.
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
  Future<List<SlotVariant>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SlotVariantTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SlotVariantTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SlotVariantTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<SlotVariant>(
      where: where?.call(SlotVariant.t),
      orderBy: orderBy?.call(SlotVariant.t),
      orderByList: orderByList?.call(SlotVariant.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [SlotVariant] matching the given query parameters.
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
  Future<SlotVariant?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SlotVariantTable>? where,
    int? offset,
    _i1.OrderByBuilder<SlotVariantTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SlotVariantTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<SlotVariant>(
      where: where?.call(SlotVariant.t),
      orderBy: orderBy?.call(SlotVariant.t),
      orderByList: orderByList?.call(SlotVariant.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [SlotVariant] by its [id] or null if no such row exists.
  Future<SlotVariant?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<SlotVariant>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [SlotVariant]s in the list and returns the inserted rows.
  ///
  /// The returned [SlotVariant]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<SlotVariant>> insert(
    _i1.Session session,
    List<SlotVariant> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<SlotVariant>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [SlotVariant] and returns the inserted row.
  ///
  /// The returned [SlotVariant] will have its `id` field set.
  Future<SlotVariant> insertRow(
    _i1.Session session,
    SlotVariant row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<SlotVariant>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [SlotVariant]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<SlotVariant>> update(
    _i1.Session session,
    List<SlotVariant> rows, {
    _i1.ColumnSelections<SlotVariantTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<SlotVariant>(
      rows,
      columns: columns?.call(SlotVariant.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SlotVariant]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SlotVariant> updateRow(
    _i1.Session session,
    SlotVariant row, {
    _i1.ColumnSelections<SlotVariantTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<SlotVariant>(
      row,
      columns: columns?.call(SlotVariant.t),
      transaction: transaction,
    );
  }

  /// Deletes all [SlotVariant]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<SlotVariant>> delete(
    _i1.Session session,
    List<SlotVariant> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<SlotVariant>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [SlotVariant].
  Future<SlotVariant> deleteRow(
    _i1.Session session,
    SlotVariant row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SlotVariant>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<SlotVariant>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<SlotVariantTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<SlotVariant>(
      where: where(SlotVariant.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SlotVariantTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<SlotVariant>(
      where: where?.call(SlotVariant.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
