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

/// Registration request data
abstract class RegistrationRequest implements _i1.SerializableModel {
  RegistrationRequest._({
    required this.username,
    required this.password,
    required this.acceptedTerms,
  });

  factory RegistrationRequest({
    required String username,
    required String password,
    required bool acceptedTerms,
  }) = _RegistrationRequestImpl;

  factory RegistrationRequest.fromJson(Map<String, dynamic> jsonSerialization) {
    return RegistrationRequest(
      username: jsonSerialization['username'] as String,
      password: jsonSerialization['password'] as String,
      acceptedTerms: jsonSerialization['acceptedTerms'] as bool,
    );
  }

  /// Desired username
  String username;

  /// Password (will be hashed server-side)
  String password;

  /// Whether user accepted terms of service
  bool acceptedTerms;

  /// Returns a shallow copy of this [RegistrationRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  RegistrationRequest copyWith({
    String? username,
    String? password,
    bool? acceptedTerms,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      'acceptedTerms': acceptedTerms,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _RegistrationRequestImpl extends RegistrationRequest {
  _RegistrationRequestImpl({
    required String username,
    required String password,
    required bool acceptedTerms,
  }) : super._(
          username: username,
          password: password,
          acceptedTerms: acceptedTerms,
        );

  /// Returns a shallow copy of this [RegistrationRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  RegistrationRequest copyWith({
    String? username,
    String? password,
    bool? acceptedTerms,
  }) {
    return RegistrationRequest(
      username: username ?? this.username,
      password: password ?? this.password,
      acceptedTerms: acceptedTerms ?? this.acceptedTerms,
    );
  }
}
