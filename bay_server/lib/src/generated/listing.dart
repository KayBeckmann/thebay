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
import 'quantity_unit.dart' as _i2;

/// Angebot/Listing - Haupttabelle für alle Angebote
abstract class Listing
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Listing._({
    this.id,
    required this.userId,
    required this.categoryId,
    required this.title,
    required this.description,
    required this.quantity,
    required this.quantityUnit,
    required this.pricePerUnit,
    required this.acceptsPaypal,
    required this.acceptsBitcoin,
    required this.hasShipping,
    this.shippingMethod,
    this.shippingCostCents,
    required this.isActive,
    this.expiresAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Listing({
    int? id,
    required int userId,
    required int categoryId,
    required String title,
    required String description,
    required double quantity,
    required _i2.QuantityUnit quantityUnit,
    required int pricePerUnit,
    required bool acceptsPaypal,
    required bool acceptsBitcoin,
    required bool hasShipping,
    String? shippingMethod,
    int? shippingCostCents,
    required bool isActive,
    DateTime? expiresAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _ListingImpl;

  factory Listing.fromJson(Map<String, dynamic> jsonSerialization) {
    return Listing(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      categoryId: jsonSerialization['categoryId'] as int,
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String,
      quantity: (jsonSerialization['quantity'] as num).toDouble(),
      quantityUnit:
          _i2.QuantityUnit.fromJson((jsonSerialization['quantityUnit'] as int)),
      pricePerUnit: jsonSerialization['pricePerUnit'] as int,
      acceptsPaypal: jsonSerialization['acceptsPaypal'] as bool,
      acceptsBitcoin: jsonSerialization['acceptsBitcoin'] as bool,
      hasShipping: jsonSerialization['hasShipping'] as bool,
      shippingMethod: jsonSerialization['shippingMethod'] as String?,
      shippingCostCents: jsonSerialization['shippingCostCents'] as int?,
      isActive: jsonSerialization['isActive'] as bool,
      expiresAt: jsonSerialization['expiresAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['expiresAt']),
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = ListingTable();

  static const db = ListingRepository._();

  @override
  int? id;

  /// Beziehungen
  int userId;

  int categoryId;

  /// Basis-Informationen
  String title;

  String description;

  /// Menge & Preis
  double quantity;

  _i2.QuantityUnit quantityUnit;

  int pricePerUnit;

  /// Zahlungsoptionen
  bool acceptsPaypal;

  bool acceptsBitcoin;

  /// Versand
  bool hasShipping;

  String? shippingMethod;

  int? shippingCostCents;

  /// Status
  bool isActive;

  DateTime? expiresAt;

  /// Timestamps
  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Listing]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Listing copyWith({
    int? id,
    int? userId,
    int? categoryId,
    String? title,
    String? description,
    double? quantity,
    _i2.QuantityUnit? quantityUnit,
    int? pricePerUnit,
    bool? acceptsPaypal,
    bool? acceptsBitcoin,
    bool? hasShipping,
    String? shippingMethod,
    int? shippingCostCents,
    bool? isActive,
    DateTime? expiresAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'categoryId': categoryId,
      'title': title,
      'description': description,
      'quantity': quantity,
      'quantityUnit': quantityUnit.toJson(),
      'pricePerUnit': pricePerUnit,
      'acceptsPaypal': acceptsPaypal,
      'acceptsBitcoin': acceptsBitcoin,
      'hasShipping': hasShipping,
      if (shippingMethod != null) 'shippingMethod': shippingMethod,
      if (shippingCostCents != null) 'shippingCostCents': shippingCostCents,
      'isActive': isActive,
      if (expiresAt != null) 'expiresAt': expiresAt?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'categoryId': categoryId,
      'title': title,
      'description': description,
      'quantity': quantity,
      'quantityUnit': quantityUnit.toJson(),
      'pricePerUnit': pricePerUnit,
      'acceptsPaypal': acceptsPaypal,
      'acceptsBitcoin': acceptsBitcoin,
      'hasShipping': hasShipping,
      if (shippingMethod != null) 'shippingMethod': shippingMethod,
      if (shippingCostCents != null) 'shippingCostCents': shippingCostCents,
      'isActive': isActive,
      if (expiresAt != null) 'expiresAt': expiresAt?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static ListingInclude include() {
    return ListingInclude._();
  }

  static ListingIncludeList includeList({
    _i1.WhereExpressionBuilder<ListingTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ListingTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ListingTable>? orderByList,
    ListingInclude? include,
  }) {
    return ListingIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Listing.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Listing.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ListingImpl extends Listing {
  _ListingImpl({
    int? id,
    required int userId,
    required int categoryId,
    required String title,
    required String description,
    required double quantity,
    required _i2.QuantityUnit quantityUnit,
    required int pricePerUnit,
    required bool acceptsPaypal,
    required bool acceptsBitcoin,
    required bool hasShipping,
    String? shippingMethod,
    int? shippingCostCents,
    required bool isActive,
    DateTime? expiresAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
          id: id,
          userId: userId,
          categoryId: categoryId,
          title: title,
          description: description,
          quantity: quantity,
          quantityUnit: quantityUnit,
          pricePerUnit: pricePerUnit,
          acceptsPaypal: acceptsPaypal,
          acceptsBitcoin: acceptsBitcoin,
          hasShipping: hasShipping,
          shippingMethod: shippingMethod,
          shippingCostCents: shippingCostCents,
          isActive: isActive,
          expiresAt: expiresAt,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [Listing]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Listing copyWith({
    Object? id = _Undefined,
    int? userId,
    int? categoryId,
    String? title,
    String? description,
    double? quantity,
    _i2.QuantityUnit? quantityUnit,
    int? pricePerUnit,
    bool? acceptsPaypal,
    bool? acceptsBitcoin,
    bool? hasShipping,
    Object? shippingMethod = _Undefined,
    Object? shippingCostCents = _Undefined,
    bool? isActive,
    Object? expiresAt = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Listing(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      categoryId: categoryId ?? this.categoryId,
      title: title ?? this.title,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      quantityUnit: quantityUnit ?? this.quantityUnit,
      pricePerUnit: pricePerUnit ?? this.pricePerUnit,
      acceptsPaypal: acceptsPaypal ?? this.acceptsPaypal,
      acceptsBitcoin: acceptsBitcoin ?? this.acceptsBitcoin,
      hasShipping: hasShipping ?? this.hasShipping,
      shippingMethod:
          shippingMethod is String? ? shippingMethod : this.shippingMethod,
      shippingCostCents: shippingCostCents is int?
          ? shippingCostCents
          : this.shippingCostCents,
      isActive: isActive ?? this.isActive,
      expiresAt: expiresAt is DateTime? ? expiresAt : this.expiresAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class ListingTable extends _i1.Table<int?> {
  ListingTable({super.tableRelation}) : super(tableName: 'listings') {
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    categoryId = _i1.ColumnInt(
      'categoryId',
      this,
    );
    title = _i1.ColumnString(
      'title',
      this,
    );
    description = _i1.ColumnString(
      'description',
      this,
    );
    quantity = _i1.ColumnDouble(
      'quantity',
      this,
    );
    quantityUnit = _i1.ColumnEnum(
      'quantityUnit',
      this,
      _i1.EnumSerialization.byIndex,
    );
    pricePerUnit = _i1.ColumnInt(
      'pricePerUnit',
      this,
    );
    acceptsPaypal = _i1.ColumnBool(
      'acceptsPaypal',
      this,
    );
    acceptsBitcoin = _i1.ColumnBool(
      'acceptsBitcoin',
      this,
    );
    hasShipping = _i1.ColumnBool(
      'hasShipping',
      this,
    );
    shippingMethod = _i1.ColumnString(
      'shippingMethod',
      this,
    );
    shippingCostCents = _i1.ColumnInt(
      'shippingCostCents',
      this,
    );
    isActive = _i1.ColumnBool(
      'isActive',
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

  /// Beziehungen
  late final _i1.ColumnInt userId;

  late final _i1.ColumnInt categoryId;

  /// Basis-Informationen
  late final _i1.ColumnString title;

  late final _i1.ColumnString description;

  /// Menge & Preis
  late final _i1.ColumnDouble quantity;

  late final _i1.ColumnEnum<_i2.QuantityUnit> quantityUnit;

  late final _i1.ColumnInt pricePerUnit;

  /// Zahlungsoptionen
  late final _i1.ColumnBool acceptsPaypal;

  late final _i1.ColumnBool acceptsBitcoin;

  /// Versand
  late final _i1.ColumnBool hasShipping;

  late final _i1.ColumnString shippingMethod;

  late final _i1.ColumnInt shippingCostCents;

  /// Status
  late final _i1.ColumnBool isActive;

  late final _i1.ColumnDateTime expiresAt;

  /// Timestamps
  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
        id,
        userId,
        categoryId,
        title,
        description,
        quantity,
        quantityUnit,
        pricePerUnit,
        acceptsPaypal,
        acceptsBitcoin,
        hasShipping,
        shippingMethod,
        shippingCostCents,
        isActive,
        expiresAt,
        createdAt,
        updatedAt,
      ];
}

class ListingInclude extends _i1.IncludeObject {
  ListingInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Listing.t;
}

class ListingIncludeList extends _i1.IncludeList {
  ListingIncludeList._({
    _i1.WhereExpressionBuilder<ListingTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Listing.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Listing.t;
}

class ListingRepository {
  const ListingRepository._();

  /// Returns a list of [Listing]s matching the given query parameters.
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
  Future<List<Listing>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ListingTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ListingTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ListingTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Listing>(
      where: where?.call(Listing.t),
      orderBy: orderBy?.call(Listing.t),
      orderByList: orderByList?.call(Listing.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Listing] matching the given query parameters.
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
  Future<Listing?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ListingTable>? where,
    int? offset,
    _i1.OrderByBuilder<ListingTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ListingTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Listing>(
      where: where?.call(Listing.t),
      orderBy: orderBy?.call(Listing.t),
      orderByList: orderByList?.call(Listing.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Listing] by its [id] or null if no such row exists.
  Future<Listing?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Listing>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Listing]s in the list and returns the inserted rows.
  ///
  /// The returned [Listing]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Listing>> insert(
    _i1.Session session,
    List<Listing> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Listing>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Listing] and returns the inserted row.
  ///
  /// The returned [Listing] will have its `id` field set.
  Future<Listing> insertRow(
    _i1.Session session,
    Listing row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Listing>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Listing]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Listing>> update(
    _i1.Session session,
    List<Listing> rows, {
    _i1.ColumnSelections<ListingTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Listing>(
      rows,
      columns: columns?.call(Listing.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Listing]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Listing> updateRow(
    _i1.Session session,
    Listing row, {
    _i1.ColumnSelections<ListingTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Listing>(
      row,
      columns: columns?.call(Listing.t),
      transaction: transaction,
    );
  }

  /// Deletes all [Listing]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Listing>> delete(
    _i1.Session session,
    List<Listing> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Listing>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Listing].
  Future<Listing> deleteRow(
    _i1.Session session,
    Listing row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Listing>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Listing>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ListingTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Listing>(
      where: where(Listing.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ListingTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Listing>(
      where: where?.call(Listing.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
