/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'user_role.dart' as _i2;

/// User model for authentication and user management
abstract class User implements _i1.SerializableModel {
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

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
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
