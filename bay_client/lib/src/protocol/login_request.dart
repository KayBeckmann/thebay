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

/// Login request data
abstract class LoginRequest implements _i1.SerializableModel {
  LoginRequest._({
    required this.username,
    required this.password,
    bool? stayLoggedIn,
  }) : stayLoggedIn = stayLoggedIn ?? false;

  factory LoginRequest({
    required String username,
    required String password,
    bool? stayLoggedIn,
  }) = _LoginRequestImpl;

  factory LoginRequest.fromJson(Map<String, dynamic> jsonSerialization) {
    return LoginRequest(
      username: jsonSerialization['username'] as String,
      password: jsonSerialization['password'] as String,
      stayLoggedIn: jsonSerialization['stayLoggedIn'] as bool,
    );
  }

  /// Username
  String username;

  /// Password
  String password;

  /// Whether to extend session duration ("stay logged in")
  bool stayLoggedIn;

  /// Returns a shallow copy of this [LoginRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  LoginRequest copyWith({
    String? username,
    String? password,
    bool? stayLoggedIn,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      'stayLoggedIn': stayLoggedIn,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _LoginRequestImpl extends LoginRequest {
  _LoginRequestImpl({
    required String username,
    required String password,
    bool? stayLoggedIn,
  }) : super._(
          username: username,
          password: password,
          stayLoggedIn: stayLoggedIn,
        );

  /// Returns a shallow copy of this [LoginRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  LoginRequest copyWith({
    String? username,
    String? password,
    bool? stayLoggedIn,
  }) {
    return LoginRequest(
      username: username ?? this.username,
      password: password ?? this.password,
      stayLoggedIn: stayLoggedIn ?? this.stayLoggedIn,
    );
  }
}
