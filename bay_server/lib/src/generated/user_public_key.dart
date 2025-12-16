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

/// User PGP Public Key for encrypted messaging
abstract class UserPublicKey
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  UserPublicKey._({
    this.id,
    required this.userId,
    required this.publicKeyArmored,
    required this.fingerprint,
    required this.algorithm,
    required this.keySize,
    required this.keyIdentity,
    bool? isActive,
    required this.createdAt,
    required this.updatedAt,
  }) : isActive = isActive ?? true;

  factory UserPublicKey({
    int? id,
    required int userId,
    required String publicKeyArmored,
    required String fingerprint,
    required String algorithm,
    required int keySize,
    required String keyIdentity,
    bool? isActive,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _UserPublicKeyImpl;

  factory UserPublicKey.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserPublicKey(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      publicKeyArmored: jsonSerialization['publicKeyArmored'] as String,
      fingerprint: jsonSerialization['fingerprint'] as String,
      algorithm: jsonSerialization['algorithm'] as String,
      keySize: jsonSerialization['keySize'] as int,
      keyIdentity: jsonSerialization['keyIdentity'] as String,
      isActive: jsonSerialization['isActive'] as bool,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = UserPublicKeyTable();

  static const db = UserPublicKeyRepository._();

  @override
  int? id;

  /// User who owns this key
  int userId;

  /// Armored PGP public key (ASCII format)
  String publicKeyArmored;

  /// Key fingerprint (40 hex chars for SHA-1 fingerprint)
  String fingerprint;

  /// Key algorithm (RSA, ECDSA, etc.)
  String algorithm;

  /// Key size in bits (e.g., 4096 for RSA)
  int keySize;

  /// Name/email associated with key
  String keyIdentity;

  /// Whether this is the user's active key
  bool isActive;

  /// Creation timestamp
  DateTime createdAt;

  /// Last update timestamp
  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [UserPublicKey]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UserPublicKey copyWith({
    int? id,
    int? userId,
    String? publicKeyArmored,
    String? fingerprint,
    String? algorithm,
    int? keySize,
    String? keyIdentity,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'publicKeyArmored': publicKeyArmored,
      'fingerprint': fingerprint,
      'algorithm': algorithm,
      'keySize': keySize,
      'keyIdentity': keyIdentity,
      'isActive': isActive,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'publicKeyArmored': publicKeyArmored,
      'fingerprint': fingerprint,
      'algorithm': algorithm,
      'keySize': keySize,
      'keyIdentity': keyIdentity,
      'isActive': isActive,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static UserPublicKeyInclude include() {
    return UserPublicKeyInclude._();
  }

  static UserPublicKeyIncludeList includeList({
    _i1.WhereExpressionBuilder<UserPublicKeyTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserPublicKeyTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserPublicKeyTable>? orderByList,
    UserPublicKeyInclude? include,
  }) {
    return UserPublicKeyIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(UserPublicKey.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(UserPublicKey.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserPublicKeyImpl extends UserPublicKey {
  _UserPublicKeyImpl({
    int? id,
    required int userId,
    required String publicKeyArmored,
    required String fingerprint,
    required String algorithm,
    required int keySize,
    required String keyIdentity,
    bool? isActive,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
          id: id,
          userId: userId,
          publicKeyArmored: publicKeyArmored,
          fingerprint: fingerprint,
          algorithm: algorithm,
          keySize: keySize,
          keyIdentity: keyIdentity,
          isActive: isActive,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [UserPublicKey]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UserPublicKey copyWith({
    Object? id = _Undefined,
    int? userId,
    String? publicKeyArmored,
    String? fingerprint,
    String? algorithm,
    int? keySize,
    String? keyIdentity,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserPublicKey(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      publicKeyArmored: publicKeyArmored ?? this.publicKeyArmored,
      fingerprint: fingerprint ?? this.fingerprint,
      algorithm: algorithm ?? this.algorithm,
      keySize: keySize ?? this.keySize,
      keyIdentity: keyIdentity ?? this.keyIdentity,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class UserPublicKeyTable extends _i1.Table<int?> {
  UserPublicKeyTable({super.tableRelation})
      : super(tableName: 'user_public_keys') {
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    publicKeyArmored = _i1.ColumnString(
      'publicKeyArmored',
      this,
    );
    fingerprint = _i1.ColumnString(
      'fingerprint',
      this,
    );
    algorithm = _i1.ColumnString(
      'algorithm',
      this,
    );
    keySize = _i1.ColumnInt(
      'keySize',
      this,
    );
    keyIdentity = _i1.ColumnString(
      'keyIdentity',
      this,
    );
    isActive = _i1.ColumnBool(
      'isActive',
      this,
      hasDefault: true,
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

  /// User who owns this key
  late final _i1.ColumnInt userId;

  /// Armored PGP public key (ASCII format)
  late final _i1.ColumnString publicKeyArmored;

  /// Key fingerprint (40 hex chars for SHA-1 fingerprint)
  late final _i1.ColumnString fingerprint;

  /// Key algorithm (RSA, ECDSA, etc.)
  late final _i1.ColumnString algorithm;

  /// Key size in bits (e.g., 4096 for RSA)
  late final _i1.ColumnInt keySize;

  /// Name/email associated with key
  late final _i1.ColumnString keyIdentity;

  /// Whether this is the user's active key
  late final _i1.ColumnBool isActive;

  /// Creation timestamp
  late final _i1.ColumnDateTime createdAt;

  /// Last update timestamp
  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
        id,
        userId,
        publicKeyArmored,
        fingerprint,
        algorithm,
        keySize,
        keyIdentity,
        isActive,
        createdAt,
        updatedAt,
      ];
}

class UserPublicKeyInclude extends _i1.IncludeObject {
  UserPublicKeyInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => UserPublicKey.t;
}

class UserPublicKeyIncludeList extends _i1.IncludeList {
  UserPublicKeyIncludeList._({
    _i1.WhereExpressionBuilder<UserPublicKeyTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(UserPublicKey.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => UserPublicKey.t;
}

class UserPublicKeyRepository {
  const UserPublicKeyRepository._();

  /// Returns a list of [UserPublicKey]s matching the given query parameters.
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
  Future<List<UserPublicKey>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserPublicKeyTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserPublicKeyTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserPublicKeyTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<UserPublicKey>(
      where: where?.call(UserPublicKey.t),
      orderBy: orderBy?.call(UserPublicKey.t),
      orderByList: orderByList?.call(UserPublicKey.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [UserPublicKey] matching the given query parameters.
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
  Future<UserPublicKey?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserPublicKeyTable>? where,
    int? offset,
    _i1.OrderByBuilder<UserPublicKeyTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserPublicKeyTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<UserPublicKey>(
      where: where?.call(UserPublicKey.t),
      orderBy: orderBy?.call(UserPublicKey.t),
      orderByList: orderByList?.call(UserPublicKey.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [UserPublicKey] by its [id] or null if no such row exists.
  Future<UserPublicKey?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<UserPublicKey>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [UserPublicKey]s in the list and returns the inserted rows.
  ///
  /// The returned [UserPublicKey]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<UserPublicKey>> insert(
    _i1.Session session,
    List<UserPublicKey> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<UserPublicKey>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [UserPublicKey] and returns the inserted row.
  ///
  /// The returned [UserPublicKey] will have its `id` field set.
  Future<UserPublicKey> insertRow(
    _i1.Session session,
    UserPublicKey row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<UserPublicKey>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [UserPublicKey]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<UserPublicKey>> update(
    _i1.Session session,
    List<UserPublicKey> rows, {
    _i1.ColumnSelections<UserPublicKeyTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<UserPublicKey>(
      rows,
      columns: columns?.call(UserPublicKey.t),
      transaction: transaction,
    );
  }

  /// Updates a single [UserPublicKey]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<UserPublicKey> updateRow(
    _i1.Session session,
    UserPublicKey row, {
    _i1.ColumnSelections<UserPublicKeyTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<UserPublicKey>(
      row,
      columns: columns?.call(UserPublicKey.t),
      transaction: transaction,
    );
  }

  /// Deletes all [UserPublicKey]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<UserPublicKey>> delete(
    _i1.Session session,
    List<UserPublicKey> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<UserPublicKey>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [UserPublicKey].
  Future<UserPublicKey> deleteRow(
    _i1.Session session,
    UserPublicKey row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<UserPublicKey>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<UserPublicKey>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<UserPublicKeyTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<UserPublicKey>(
      where: where(UserPublicKey.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserPublicKeyTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<UserPublicKey>(
      where: where?.call(UserPublicKey.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
