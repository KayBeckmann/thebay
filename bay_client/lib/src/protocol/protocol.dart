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
import 'greeting.dart' as _i2;
import 'auth_response.dart' as _i3;
import 'login_request.dart' as _i4;
import 'registration_request.dart' as _i5;
import 'settings.dart' as _i6;
import 'user.dart' as _i7;
import 'user_role.dart' as _i8;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i9;
export 'greeting.dart';
export 'auth_response.dart';
export 'login_request.dart';
export 'registration_request.dart';
export 'settings.dart';
export 'user.dart';
export 'user_role.dart';
export 'client.dart';

class Protocol extends _i1.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;
    if (t == _i2.Greeting) {
      return _i2.Greeting.fromJson(data) as T;
    }
    if (t == _i3.AuthResponse) {
      return _i3.AuthResponse.fromJson(data) as T;
    }
    if (t == _i4.LoginRequest) {
      return _i4.LoginRequest.fromJson(data) as T;
    }
    if (t == _i5.RegistrationRequest) {
      return _i5.RegistrationRequest.fromJson(data) as T;
    }
    if (t == _i6.Settings) {
      return _i6.Settings.fromJson(data) as T;
    }
    if (t == _i7.User) {
      return _i7.User.fromJson(data) as T;
    }
    if (t == _i8.UserRole) {
      return _i8.UserRole.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.Greeting?>()) {
      return (data != null ? _i2.Greeting.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.AuthResponse?>()) {
      return (data != null ? _i3.AuthResponse.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.LoginRequest?>()) {
      return (data != null ? _i4.LoginRequest.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.RegistrationRequest?>()) {
      return (data != null ? _i5.RegistrationRequest.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i6.Settings?>()) {
      return (data != null ? _i6.Settings.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.User?>()) {
      return (data != null ? _i7.User.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.UserRole?>()) {
      return (data != null ? _i8.UserRole.fromJson(data) : null) as T;
    }
    try {
      return _i9.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;
    if (data is _i2.Greeting) {
      return 'Greeting';
    }
    if (data is _i3.AuthResponse) {
      return 'AuthResponse';
    }
    if (data is _i4.LoginRequest) {
      return 'LoginRequest';
    }
    if (data is _i5.RegistrationRequest) {
      return 'RegistrationRequest';
    }
    if (data is _i6.Settings) {
      return 'Settings';
    }
    if (data is _i7.User) {
      return 'User';
    }
    if (data is _i8.UserRole) {
      return 'UserRole';
    }
    className = _i9.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_i2.Greeting>(data['data']);
    }
    if (dataClassName == 'AuthResponse') {
      return deserialize<_i3.AuthResponse>(data['data']);
    }
    if (dataClassName == 'LoginRequest') {
      return deserialize<_i4.LoginRequest>(data['data']);
    }
    if (dataClassName == 'RegistrationRequest') {
      return deserialize<_i5.RegistrationRequest>(data['data']);
    }
    if (dataClassName == 'Settings') {
      return deserialize<_i6.Settings>(data['data']);
    }
    if (dataClassName == 'User') {
      return deserialize<_i7.User>(data['data']);
    }
    if (dataClassName == 'UserRole') {
      return deserialize<_i8.UserRole>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth.')) {
      data['className'] = dataClassName.substring(15);
      return _i9.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }
}
