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

/// Authentication response returned after successful login/registration
abstract class AuthResponse implements _i1.SerializableModel {
  AuthResponse._({
    required this.success,
    this.errorMessage,
    this.userId,
    this.username,
    this.role,
    this.sessionKey,
    this.lockoutSeconds,
  });

  factory AuthResponse({
    required bool success,
    String? errorMessage,
    int? userId,
    String? username,
    _i2.UserRole? role,
    String? sessionKey,
    int? lockoutSeconds,
  }) = _AuthResponseImpl;

  factory AuthResponse.fromJson(Map<String, dynamic> jsonSerialization) {
    return AuthResponse(
      success: jsonSerialization['success'] as bool,
      errorMessage: jsonSerialization['errorMessage'] as String?,
      userId: jsonSerialization['userId'] as int?,
      username: jsonSerialization['username'] as String?,
      role: jsonSerialization['role'] == null
          ? null
          : _i2.UserRole.fromJson((jsonSerialization['role'] as int)),
      sessionKey: jsonSerialization['sessionKey'] as String?,
      lockoutSeconds: jsonSerialization['lockoutSeconds'] as int?,
    );
  }

  /// Whether the authentication was successful
  bool success;

  /// Error message if authentication failed
  String? errorMessage;

  /// User ID if authentication was successful
  int? userId;

  /// Username if authentication was successful
  String? username;

  /// User role if authentication was successful
  _i2.UserRole? role;

  /// Session key for authenticated requests
  String? sessionKey;

  /// Remaining lockout time in seconds (for rate limiting)
  int? lockoutSeconds;

  /// Returns a shallow copy of this [AuthResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AuthResponse copyWith({
    bool? success,
    String? errorMessage,
    int? userId,
    String? username,
    _i2.UserRole? role,
    String? sessionKey,
    int? lockoutSeconds,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'success': success,
      if (errorMessage != null) 'errorMessage': errorMessage,
      if (userId != null) 'userId': userId,
      if (username != null) 'username': username,
      if (role != null) 'role': role?.toJson(),
      if (sessionKey != null) 'sessionKey': sessionKey,
      if (lockoutSeconds != null) 'lockoutSeconds': lockoutSeconds,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AuthResponseImpl extends AuthResponse {
  _AuthResponseImpl({
    required bool success,
    String? errorMessage,
    int? userId,
    String? username,
    _i2.UserRole? role,
    String? sessionKey,
    int? lockoutSeconds,
  }) : super._(
          success: success,
          errorMessage: errorMessage,
          userId: userId,
          username: username,
          role: role,
          sessionKey: sessionKey,
          lockoutSeconds: lockoutSeconds,
        );

  /// Returns a shallow copy of this [AuthResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AuthResponse copyWith({
    bool? success,
    Object? errorMessage = _Undefined,
    Object? userId = _Undefined,
    Object? username = _Undefined,
    Object? role = _Undefined,
    Object? sessionKey = _Undefined,
    Object? lockoutSeconds = _Undefined,
  }) {
    return AuthResponse(
      success: success ?? this.success,
      errorMessage: errorMessage is String? ? errorMessage : this.errorMessage,
      userId: userId is int? ? userId : this.userId,
      username: username is String? ? username : this.username,
      role: role is _i2.UserRole? ? role : this.role,
      sessionKey: sessionKey is String? ? sessionKey : this.sessionKey,
      lockoutSeconds:
          lockoutSeconds is int? ? lockoutSeconds : this.lockoutSeconds,
    );
  }
}
