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

/// Encrypted private key backup (stored encrypted with user's passphrase)
abstract class EncryptedKeyBackup
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  EncryptedKeyBackup._({
    this.id,
    required this.userId,
    required this.encryptedPrivateKey,
    required this.fingerprint,
    required this.encryptionSalt,
    required this.kdfParams,
    required this.createdAt,
    bool? isActive,
  }) : isActive = isActive ?? true;

  factory EncryptedKeyBackup({
    int? id,
    required int userId,
    required String encryptedPrivateKey,
    required String fingerprint,
    required String encryptionSalt,
    required String kdfParams,
    required DateTime createdAt,
    bool? isActive,
  }) = _EncryptedKeyBackupImpl;

  factory EncryptedKeyBackup.fromJson(Map<String, dynamic> jsonSerialization) {
    return EncryptedKeyBackup(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      encryptedPrivateKey: jsonSerialization['encryptedPrivateKey'] as String,
      fingerprint: jsonSerialization['fingerprint'] as String,
      encryptionSalt: jsonSerialization['encryptionSalt'] as String,
      kdfParams: jsonSerialization['kdfParams'] as String,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      isActive: jsonSerialization['isActive'] as bool,
    );
  }

  static final t = EncryptedKeyBackupTable();

  static const db = EncryptedKeyBackupRepository._();

  @override
  int? id;

  /// User who owns this backup
  int userId;

  /// Encrypted private key (double-encrypted: PGP passphrase + additional encryption)
  String encryptedPrivateKey;

  /// Fingerprint of the backed-up key
  String fingerprint;

  /// Salt used for backup encryption
  String encryptionSalt;

  /// Key derivation parameters (JSON: iterations, memory, etc.)
  String kdfParams;

  /// Creation timestamp
  DateTime createdAt;

  /// Whether backup is still valid
  bool isActive;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [EncryptedKeyBackup]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  EncryptedKeyBackup copyWith({
    int? id,
    int? userId,
    String? encryptedPrivateKey,
    String? fingerprint,
    String? encryptionSalt,
    String? kdfParams,
    DateTime? createdAt,
    bool? isActive,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'encryptedPrivateKey': encryptedPrivateKey,
      'fingerprint': fingerprint,
      'encryptionSalt': encryptionSalt,
      'kdfParams': kdfParams,
      'createdAt': createdAt.toJson(),
      'isActive': isActive,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'encryptedPrivateKey': encryptedPrivateKey,
      'fingerprint': fingerprint,
      'encryptionSalt': encryptionSalt,
      'kdfParams': kdfParams,
      'createdAt': createdAt.toJson(),
      'isActive': isActive,
    };
  }

  static EncryptedKeyBackupInclude include() {
    return EncryptedKeyBackupInclude._();
  }

  static EncryptedKeyBackupIncludeList includeList({
    _i1.WhereExpressionBuilder<EncryptedKeyBackupTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<EncryptedKeyBackupTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<EncryptedKeyBackupTable>? orderByList,
    EncryptedKeyBackupInclude? include,
  }) {
    return EncryptedKeyBackupIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(EncryptedKeyBackup.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(EncryptedKeyBackup.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _EncryptedKeyBackupImpl extends EncryptedKeyBackup {
  _EncryptedKeyBackupImpl({
    int? id,
    required int userId,
    required String encryptedPrivateKey,
    required String fingerprint,
    required String encryptionSalt,
    required String kdfParams,
    required DateTime createdAt,
    bool? isActive,
  }) : super._(
          id: id,
          userId: userId,
          encryptedPrivateKey: encryptedPrivateKey,
          fingerprint: fingerprint,
          encryptionSalt: encryptionSalt,
          kdfParams: kdfParams,
          createdAt: createdAt,
          isActive: isActive,
        );

  /// Returns a shallow copy of this [EncryptedKeyBackup]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  EncryptedKeyBackup copyWith({
    Object? id = _Undefined,
    int? userId,
    String? encryptedPrivateKey,
    String? fingerprint,
    String? encryptionSalt,
    String? kdfParams,
    DateTime? createdAt,
    bool? isActive,
  }) {
    return EncryptedKeyBackup(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      encryptedPrivateKey: encryptedPrivateKey ?? this.encryptedPrivateKey,
      fingerprint: fingerprint ?? this.fingerprint,
      encryptionSalt: encryptionSalt ?? this.encryptionSalt,
      kdfParams: kdfParams ?? this.kdfParams,
      createdAt: createdAt ?? this.createdAt,
      isActive: isActive ?? this.isActive,
    );
  }
}

class EncryptedKeyBackupTable extends _i1.Table<int?> {
  EncryptedKeyBackupTable({super.tableRelation})
      : super(tableName: 'encrypted_key_backups') {
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    encryptedPrivateKey = _i1.ColumnString(
      'encryptedPrivateKey',
      this,
    );
    fingerprint = _i1.ColumnString(
      'fingerprint',
      this,
    );
    encryptionSalt = _i1.ColumnString(
      'encryptionSalt',
      this,
    );
    kdfParams = _i1.ColumnString(
      'kdfParams',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
    isActive = _i1.ColumnBool(
      'isActive',
      this,
      hasDefault: true,
    );
  }

  /// User who owns this backup
  late final _i1.ColumnInt userId;

  /// Encrypted private key (double-encrypted: PGP passphrase + additional encryption)
  late final _i1.ColumnString encryptedPrivateKey;

  /// Fingerprint of the backed-up key
  late final _i1.ColumnString fingerprint;

  /// Salt used for backup encryption
  late final _i1.ColumnString encryptionSalt;

  /// Key derivation parameters (JSON: iterations, memory, etc.)
  late final _i1.ColumnString kdfParams;

  /// Creation timestamp
  late final _i1.ColumnDateTime createdAt;

  /// Whether backup is still valid
  late final _i1.ColumnBool isActive;

  @override
  List<_i1.Column> get columns => [
        id,
        userId,
        encryptedPrivateKey,
        fingerprint,
        encryptionSalt,
        kdfParams,
        createdAt,
        isActive,
      ];
}

class EncryptedKeyBackupInclude extends _i1.IncludeObject {
  EncryptedKeyBackupInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => EncryptedKeyBackup.t;
}

class EncryptedKeyBackupIncludeList extends _i1.IncludeList {
  EncryptedKeyBackupIncludeList._({
    _i1.WhereExpressionBuilder<EncryptedKeyBackupTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(EncryptedKeyBackup.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => EncryptedKeyBackup.t;
}

class EncryptedKeyBackupRepository {
  const EncryptedKeyBackupRepository._();

  /// Returns a list of [EncryptedKeyBackup]s matching the given query parameters.
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
  Future<List<EncryptedKeyBackup>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<EncryptedKeyBackupTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<EncryptedKeyBackupTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<EncryptedKeyBackupTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<EncryptedKeyBackup>(
      where: where?.call(EncryptedKeyBackup.t),
      orderBy: orderBy?.call(EncryptedKeyBackup.t),
      orderByList: orderByList?.call(EncryptedKeyBackup.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [EncryptedKeyBackup] matching the given query parameters.
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
  Future<EncryptedKeyBackup?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<EncryptedKeyBackupTable>? where,
    int? offset,
    _i1.OrderByBuilder<EncryptedKeyBackupTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<EncryptedKeyBackupTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<EncryptedKeyBackup>(
      where: where?.call(EncryptedKeyBackup.t),
      orderBy: orderBy?.call(EncryptedKeyBackup.t),
      orderByList: orderByList?.call(EncryptedKeyBackup.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [EncryptedKeyBackup] by its [id] or null if no such row exists.
  Future<EncryptedKeyBackup?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<EncryptedKeyBackup>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [EncryptedKeyBackup]s in the list and returns the inserted rows.
  ///
  /// The returned [EncryptedKeyBackup]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<EncryptedKeyBackup>> insert(
    _i1.Session session,
    List<EncryptedKeyBackup> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<EncryptedKeyBackup>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [EncryptedKeyBackup] and returns the inserted row.
  ///
  /// The returned [EncryptedKeyBackup] will have its `id` field set.
  Future<EncryptedKeyBackup> insertRow(
    _i1.Session session,
    EncryptedKeyBackup row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<EncryptedKeyBackup>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [EncryptedKeyBackup]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<EncryptedKeyBackup>> update(
    _i1.Session session,
    List<EncryptedKeyBackup> rows, {
    _i1.ColumnSelections<EncryptedKeyBackupTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<EncryptedKeyBackup>(
      rows,
      columns: columns?.call(EncryptedKeyBackup.t),
      transaction: transaction,
    );
  }

  /// Updates a single [EncryptedKeyBackup]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<EncryptedKeyBackup> updateRow(
    _i1.Session session,
    EncryptedKeyBackup row, {
    _i1.ColumnSelections<EncryptedKeyBackupTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<EncryptedKeyBackup>(
      row,
      columns: columns?.call(EncryptedKeyBackup.t),
      transaction: transaction,
    );
  }

  /// Deletes all [EncryptedKeyBackup]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<EncryptedKeyBackup>> delete(
    _i1.Session session,
    List<EncryptedKeyBackup> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<EncryptedKeyBackup>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [EncryptedKeyBackup].
  Future<EncryptedKeyBackup> deleteRow(
    _i1.Session session,
    EncryptedKeyBackup row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<EncryptedKeyBackup>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<EncryptedKeyBackup>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<EncryptedKeyBackupTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<EncryptedKeyBackup>(
      where: where(EncryptedKeyBackup.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<EncryptedKeyBackupTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<EncryptedKeyBackup>(
      where: where?.call(EncryptedKeyBackup.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
