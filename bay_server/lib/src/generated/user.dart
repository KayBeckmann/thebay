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
import 'user_role.dart' as _i2;

/// User model for authentication and user management
abstract class User implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  User._({
    this.id,
    required this.username,
    required this.passwordHash,
    _i2.UserRole? role,
    required this.createdAt,
    this.lastLoginAt,
    bool? isActive,
    bool? acceptedTerms,
    int? failedLoginAttempts,
    this.lockedUntil,
    bool? stayLoggedIn,
    bool? isBanned,
    this.bannedAt,
    this.bannedReason,
    this.bannedBy,
  })  : role = role ?? _i2.UserRole.user,
        isActive = isActive ?? true,
        acceptedTerms = acceptedTerms ?? false,
        failedLoginAttempts = failedLoginAttempts ?? 0,
        stayLoggedIn = stayLoggedIn ?? false,
        isBanned = isBanned ?? false;

  factory User({
    int? id,
    required String username,
    required String passwordHash,
    _i2.UserRole? role,
    required DateTime createdAt,
    DateTime? lastLoginAt,
    bool? isActive,
    bool? acceptedTerms,
    int? failedLoginAttempts,
    DateTime? lockedUntil,
    bool? stayLoggedIn,
    bool? isBanned,
    DateTime? bannedAt,
    String? bannedReason,
    int? bannedBy,
  }) = _UserImpl;

  factory User.fromJson(Map<String, dynamic> jsonSerialization) {
    return User(
      id: jsonSerialization['id'] as int?,
      username: jsonSerialization['username'] as String,
      passwordHash: jsonSerialization['passwordHash'] as String,
      role: _i2.UserRole.fromJson((jsonSerialization['role'] as int)),
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      lastLoginAt: jsonSerialization['lastLoginAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastLoginAt']),
      isActive: jsonSerialization['isActive'] as bool,
      acceptedTerms: jsonSerialization['acceptedTerms'] as bool,
      failedLoginAttempts: jsonSerialization['failedLoginAttempts'] as int,
      lockedUntil: jsonSerialization['lockedUntil'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['lockedUntil']),
      stayLoggedIn: jsonSerialization['stayLoggedIn'] as bool,
      isBanned: jsonSerialization['isBanned'] as bool,
      bannedAt: jsonSerialization['bannedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['bannedAt']),
      bannedReason: jsonSerialization['bannedReason'] as String?,
      bannedBy: jsonSerialization['bannedBy'] as int?,
    );
  }

  static final t = UserTable();

  static const db = UserRepository._();

  @override
  int? id;

  /// Unique username for login
  String username;

  /// Argon2id password hash
  String passwordHash;

  /// User role: user, moderator, admin
  _i2.UserRole role;

  /// Account creation timestamp
  DateTime createdAt;

  /// Last login timestamp
  DateTime? lastLoginAt;

  /// Whether the account is active (not banned)
  bool isActive;

  /// Whether the user accepted terms of service
  bool acceptedTerms;

  /// Number of failed login attempts (for rate limiting)
  int failedLoginAttempts;

  /// Lockout end time (for rate limiting)
  DateTime? lockedUntil;

  /// Whether "stay logged in" is enabled
  bool stayLoggedIn;

  /// Whether the user is banned
  bool isBanned;

  /// Ban timestamp
  DateTime? bannedAt;

  /// Reason for ban
  String? bannedReason;

  /// Admin who banned the user
  int? bannedBy;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [User]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  User copyWith({
    int? id,
    String? username,
    String? passwordHash,
    _i2.UserRole? role,
    DateTime? createdAt,
    DateTime? lastLoginAt,
    bool? isActive,
    bool? acceptedTerms,
    int? failedLoginAttempts,
    DateTime? lockedUntil,
    bool? stayLoggedIn,
    bool? isBanned,
    DateTime? bannedAt,
    String? bannedReason,
    int? bannedBy,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'username': username,
      'passwordHash': passwordHash,
      'role': role.toJson(),
      'createdAt': createdAt.toJson(),
      if (lastLoginAt != null) 'lastLoginAt': lastLoginAt?.toJson(),
      'isActive': isActive,
      'acceptedTerms': acceptedTerms,
      'failedLoginAttempts': failedLoginAttempts,
      if (lockedUntil != null) 'lockedUntil': lockedUntil?.toJson(),
      'stayLoggedIn': stayLoggedIn,
      'isBanned': isBanned,
      if (bannedAt != null) 'bannedAt': bannedAt?.toJson(),
      if (bannedReason != null) 'bannedReason': bannedReason,
      if (bannedBy != null) 'bannedBy': bannedBy,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'username': username,
      'passwordHash': passwordHash,
      'role': role.toJson(),
      'createdAt': createdAt.toJson(),
      if (lastLoginAt != null) 'lastLoginAt': lastLoginAt?.toJson(),
      'isActive': isActive,
      'acceptedTerms': acceptedTerms,
      'failedLoginAttempts': failedLoginAttempts,
      if (lockedUntil != null) 'lockedUntil': lockedUntil?.toJson(),
      'stayLoggedIn': stayLoggedIn,
      'isBanned': isBanned,
      if (bannedAt != null) 'bannedAt': bannedAt?.toJson(),
      if (bannedReason != null) 'bannedReason': bannedReason,
      if (bannedBy != null) 'bannedBy': bannedBy,
    };
  }

  static UserInclude include() {
    return UserInclude._();
  }

  static UserIncludeList includeList({
    _i1.WhereExpressionBuilder<UserTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserTable>? orderByList,
    UserInclude? include,
  }) {
    return UserIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(User.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(User.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserImpl extends User {
  _UserImpl({
    int? id,
    required String username,
    required String passwordHash,
    _i2.UserRole? role,
    required DateTime createdAt,
    DateTime? lastLoginAt,
    bool? isActive,
    bool? acceptedTerms,
    int? failedLoginAttempts,
    DateTime? lockedUntil,
    bool? stayLoggedIn,
    bool? isBanned,
    DateTime? bannedAt,
    String? bannedReason,
    int? bannedBy,
  }) : super._(
          id: id,
          username: username,
          passwordHash: passwordHash,
          role: role,
          createdAt: createdAt,
          lastLoginAt: lastLoginAt,
          isActive: isActive,
          acceptedTerms: acceptedTerms,
          failedLoginAttempts: failedLoginAttempts,
          lockedUntil: lockedUntil,
          stayLoggedIn: stayLoggedIn,
          isBanned: isBanned,
          bannedAt: bannedAt,
          bannedReason: bannedReason,
          bannedBy: bannedBy,
        );

  /// Returns a shallow copy of this [User]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  User copyWith({
    Object? id = _Undefined,
    String? username,
    String? passwordHash,
    _i2.UserRole? role,
    DateTime? createdAt,
    Object? lastLoginAt = _Undefined,
    bool? isActive,
    bool? acceptedTerms,
    int? failedLoginAttempts,
    Object? lockedUntil = _Undefined,
    bool? stayLoggedIn,
    bool? isBanned,
    Object? bannedAt = _Undefined,
    Object? bannedReason = _Undefined,
    Object? bannedBy = _Undefined,
  }) {
    return User(
      id: id is int? ? id : this.id,
      username: username ?? this.username,
      passwordHash: passwordHash ?? this.passwordHash,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
      lastLoginAt: lastLoginAt is DateTime? ? lastLoginAt : this.lastLoginAt,
      isActive: isActive ?? this.isActive,
      acceptedTerms: acceptedTerms ?? this.acceptedTerms,
      failedLoginAttempts: failedLoginAttempts ?? this.failedLoginAttempts,
      lockedUntil: lockedUntil is DateTime? ? lockedUntil : this.lockedUntil,
      stayLoggedIn: stayLoggedIn ?? this.stayLoggedIn,
      isBanned: isBanned ?? this.isBanned,
      bannedAt: bannedAt is DateTime? ? bannedAt : this.bannedAt,
      bannedReason: bannedReason is String? ? bannedReason : this.bannedReason,
      bannedBy: bannedBy is int? ? bannedBy : this.bannedBy,
    );
  }
}

class UserTable extends _i1.Table<int?> {
  UserTable({super.tableRelation}) : super(tableName: 'users') {
    username = _i1.ColumnString(
      'username',
      this,
    );
    passwordHash = _i1.ColumnString(
      'passwordHash',
      this,
    );
    role = _i1.ColumnEnum(
      'role',
      this,
      _i1.EnumSerialization.byIndex,
      hasDefault: true,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
    lastLoginAt = _i1.ColumnDateTime(
      'lastLoginAt',
      this,
    );
    isActive = _i1.ColumnBool(
      'isActive',
      this,
      hasDefault: true,
    );
    acceptedTerms = _i1.ColumnBool(
      'acceptedTerms',
      this,
      hasDefault: true,
    );
    failedLoginAttempts = _i1.ColumnInt(
      'failedLoginAttempts',
      this,
      hasDefault: true,
    );
    lockedUntil = _i1.ColumnDateTime(
      'lockedUntil',
      this,
    );
    stayLoggedIn = _i1.ColumnBool(
      'stayLoggedIn',
      this,
      hasDefault: true,
    );
    isBanned = _i1.ColumnBool(
      'isBanned',
      this,
      hasDefault: true,
    );
    bannedAt = _i1.ColumnDateTime(
      'bannedAt',
      this,
    );
    bannedReason = _i1.ColumnString(
      'bannedReason',
      this,
    );
    bannedBy = _i1.ColumnInt(
      'bannedBy',
      this,
    );
  }

  /// Unique username for login
  late final _i1.ColumnString username;

  /// Argon2id password hash
  late final _i1.ColumnString passwordHash;

  /// User role: user, moderator, admin
  late final _i1.ColumnEnum<_i2.UserRole> role;

  /// Account creation timestamp
  late final _i1.ColumnDateTime createdAt;

  /// Last login timestamp
  late final _i1.ColumnDateTime lastLoginAt;

  /// Whether the account is active (not banned)
  late final _i1.ColumnBool isActive;

  /// Whether the user accepted terms of service
  late final _i1.ColumnBool acceptedTerms;

  /// Number of failed login attempts (for rate limiting)
  late final _i1.ColumnInt failedLoginAttempts;

  /// Lockout end time (for rate limiting)
  late final _i1.ColumnDateTime lockedUntil;

  /// Whether "stay logged in" is enabled
  late final _i1.ColumnBool stayLoggedIn;

  /// Whether the user is banned
  late final _i1.ColumnBool isBanned;

  /// Ban timestamp
  late final _i1.ColumnDateTime bannedAt;

  /// Reason for ban
  late final _i1.ColumnString bannedReason;

  /// Admin who banned the user
  late final _i1.ColumnInt bannedBy;

  @override
  List<_i1.Column> get columns => [
        id,
        username,
        passwordHash,
        role,
        createdAt,
        lastLoginAt,
        isActive,
        acceptedTerms,
        failedLoginAttempts,
        lockedUntil,
        stayLoggedIn,
        isBanned,
        bannedAt,
        bannedReason,
        bannedBy,
      ];
}

class UserInclude extends _i1.IncludeObject {
  UserInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => User.t;
}

class UserIncludeList extends _i1.IncludeList {
  UserIncludeList._({
    _i1.WhereExpressionBuilder<UserTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(User.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => User.t;
}

class UserRepository {
  const UserRepository._();

  /// Returns a list of [User]s matching the given query parameters.
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
  Future<List<User>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<User>(
      where: where?.call(User.t),
      orderBy: orderBy?.call(User.t),
      orderByList: orderByList?.call(User.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [User] matching the given query parameters.
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
  Future<User?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserTable>? where,
    int? offset,
    _i1.OrderByBuilder<UserTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<User>(
      where: where?.call(User.t),
      orderBy: orderBy?.call(User.t),
      orderByList: orderByList?.call(User.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [User] by its [id] or null if no such row exists.
  Future<User?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<User>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [User]s in the list and returns the inserted rows.
  ///
  /// The returned [User]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<User>> insert(
    _i1.Session session,
    List<User> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<User>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [User] and returns the inserted row.
  ///
  /// The returned [User] will have its `id` field set.
  Future<User> insertRow(
    _i1.Session session,
    User row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<User>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [User]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<User>> update(
    _i1.Session session,
    List<User> rows, {
    _i1.ColumnSelections<UserTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<User>(
      rows,
      columns: columns?.call(User.t),
      transaction: transaction,
    );
  }

  /// Updates a single [User]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<User> updateRow(
    _i1.Session session,
    User row, {
    _i1.ColumnSelections<UserTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<User>(
      row,
      columns: columns?.call(User.t),
      transaction: transaction,
    );
  }

  /// Deletes all [User]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<User>> delete(
    _i1.Session session,
    List<User> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<User>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [User].
  Future<User> deleteRow(
    _i1.Session session,
    User row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<User>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<User>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<UserTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<User>(
      where: where(User.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<User>(
      where: where?.call(User.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
