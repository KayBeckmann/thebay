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

/// Global application settings
abstract class Settings
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Settings._({
    this.id,
    required this.key,
    required this.value,
    this.description,
    required this.updatedAt,
  });

  factory Settings({
    int? id,
    required String key,
    required String value,
    String? description,
    required DateTime updatedAt,
  }) = _SettingsImpl;

  factory Settings.fromJson(Map<String, dynamic> jsonSerialization) {
    return Settings(
      id: jsonSerialization['id'] as int?,
      key: jsonSerialization['key'] as String,
      value: jsonSerialization['value'] as String,
      description: jsonSerialization['description'] as String?,
      updatedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = SettingsTable();

  static const db = SettingsRepository._();

  @override
  int? id;

  /// Setting key (unique identifier)
  String key;

  /// Setting value (stored as JSON string for flexibility)
  String value;

  /// Human-readable description
  String? description;

  /// Last modification timestamp
  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Settings]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Settings copyWith({
    int? id,
    String? key,
    String? value,
    String? description,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'key': key,
      'value': value,
      if (description != null) 'description': description,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'key': key,
      'value': value,
      if (description != null) 'description': description,
      'updatedAt': updatedAt.toJson(),
    };
  }

  static SettingsInclude include() {
    return SettingsInclude._();
  }

  static SettingsIncludeList includeList({
    _i1.WhereExpressionBuilder<SettingsTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SettingsTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SettingsTable>? orderByList,
    SettingsInclude? include,
  }) {
    return SettingsIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Settings.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Settings.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SettingsImpl extends Settings {
  _SettingsImpl({
    int? id,
    required String key,
    required String value,
    String? description,
    required DateTime updatedAt,
  }) : super._(
          id: id,
          key: key,
          value: value,
          description: description,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [Settings]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Settings copyWith({
    Object? id = _Undefined,
    String? key,
    String? value,
    Object? description = _Undefined,
    DateTime? updatedAt,
  }) {
    return Settings(
      id: id is int? ? id : this.id,
      key: key ?? this.key,
      value: value ?? this.value,
      description: description is String? ? description : this.description,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class SettingsTable extends _i1.Table<int?> {
  SettingsTable({super.tableRelation}) : super(tableName: 'settings') {
    key = _i1.ColumnString(
      'key',
      this,
    );
    value = _i1.ColumnString(
      'value',
      this,
    );
    description = _i1.ColumnString(
      'description',
      this,
    );
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
    );
  }

  /// Setting key (unique identifier)
  late final _i1.ColumnString key;

  /// Setting value (stored as JSON string for flexibility)
  late final _i1.ColumnString value;

  /// Human-readable description
  late final _i1.ColumnString description;

  /// Last modification timestamp
  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
        id,
        key,
        value,
        description,
        updatedAt,
      ];
}

class SettingsInclude extends _i1.IncludeObject {
  SettingsInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Settings.t;
}

class SettingsIncludeList extends _i1.IncludeList {
  SettingsIncludeList._({
    _i1.WhereExpressionBuilder<SettingsTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Settings.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Settings.t;
}

class SettingsRepository {
  const SettingsRepository._();

  /// Returns a list of [Settings]s matching the given query parameters.
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
  Future<List<Settings>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SettingsTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SettingsTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SettingsTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Settings>(
      where: where?.call(Settings.t),
      orderBy: orderBy?.call(Settings.t),
      orderByList: orderByList?.call(Settings.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Settings] matching the given query parameters.
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
  Future<Settings?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SettingsTable>? where,
    int? offset,
    _i1.OrderByBuilder<SettingsTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SettingsTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Settings>(
      where: where?.call(Settings.t),
      orderBy: orderBy?.call(Settings.t),
      orderByList: orderByList?.call(Settings.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Settings] by its [id] or null if no such row exists.
  Future<Settings?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Settings>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Settings]s in the list and returns the inserted rows.
  ///
  /// The returned [Settings]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Settings>> insert(
    _i1.Session session,
    List<Settings> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Settings>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Settings] and returns the inserted row.
  ///
  /// The returned [Settings] will have its `id` field set.
  Future<Settings> insertRow(
    _i1.Session session,
    Settings row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Settings>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Settings]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Settings>> update(
    _i1.Session session,
    List<Settings> rows, {
    _i1.ColumnSelections<SettingsTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Settings>(
      rows,
      columns: columns?.call(Settings.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Settings]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Settings> updateRow(
    _i1.Session session,
    Settings row, {
    _i1.ColumnSelections<SettingsTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Settings>(
      row,
      columns: columns?.call(Settings.t),
      transaction: transaction,
    );
  }

  /// Deletes all [Settings]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Settings>> delete(
    _i1.Session session,
    List<Settings> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Settings>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Settings].
  Future<Settings> deleteRow(
    _i1.Session session,
    Settings row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Settings>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Settings>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<SettingsTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Settings>(
      where: where(Settings.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SettingsTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Settings>(
      where: where?.call(Settings.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
