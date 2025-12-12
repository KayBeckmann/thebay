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
import 'category.dart' as _i4;
import 'login_request.dart' as _i5;
import 'news.dart' as _i6;
import 'payment_method.dart' as _i7;
import 'registration_request.dart' as _i8;
import 'settings.dart' as _i9;
import 'slot_variant.dart' as _i10;
import 'user.dart' as _i11;
import 'user_role.dart' as _i12;
import 'package:bay_client/src/protocol/category.dart' as _i13;
import 'package:bay_client/src/protocol/news.dart' as _i14;
import 'package:bay_client/src/protocol/slot_variant.dart' as _i15;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i16;
export 'greeting.dart';
export 'auth_response.dart';
export 'category.dart';
export 'login_request.dart';
export 'news.dart';
export 'payment_method.dart';
export 'registration_request.dart';
export 'settings.dart';
export 'slot_variant.dart';
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
    if (t == _i4.Category) {
      return _i4.Category.fromJson(data) as T;
    }
    if (t == _i5.LoginRequest) {
      return _i5.LoginRequest.fromJson(data) as T;
    }
    if (t == _i6.News) {
      return _i6.News.fromJson(data) as T;
    }
    if (t == _i7.PaymentMethod) {
      return _i7.PaymentMethod.fromJson(data) as T;
    }
    if (t == _i8.RegistrationRequest) {
      return _i8.RegistrationRequest.fromJson(data) as T;
    }
    if (t == _i9.Settings) {
      return _i9.Settings.fromJson(data) as T;
    }
    if (t == _i10.SlotVariant) {
      return _i10.SlotVariant.fromJson(data) as T;
    }
    if (t == _i11.User) {
      return _i11.User.fromJson(data) as T;
    }
    if (t == _i12.UserRole) {
      return _i12.UserRole.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.Greeting?>()) {
      return (data != null ? _i2.Greeting.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.AuthResponse?>()) {
      return (data != null ? _i3.AuthResponse.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.Category?>()) {
      return (data != null ? _i4.Category.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.LoginRequest?>()) {
      return (data != null ? _i5.LoginRequest.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.News?>()) {
      return (data != null ? _i6.News.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.PaymentMethod?>()) {
      return (data != null ? _i7.PaymentMethod.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.RegistrationRequest?>()) {
      return (data != null ? _i8.RegistrationRequest.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i9.Settings?>()) {
      return (data != null ? _i9.Settings.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.SlotVariant?>()) {
      return (data != null ? _i10.SlotVariant.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.User?>()) {
      return (data != null ? _i11.User.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.UserRole?>()) {
      return (data != null ? _i12.UserRole.fromJson(data) : null) as T;
    }
    if (t == List<_i13.Category>) {
      return (data as List).map((e) => deserialize<_i13.Category>(e)).toList()
          as T;
    }
    if (t == List<_i14.News>) {
      return (data as List).map((e) => deserialize<_i14.News>(e)).toList() as T;
    }
    if (t == Map<String, String>) {
      return (data as Map).map((k, v) =>
          MapEntry(deserialize<String>(k), deserialize<String>(v))) as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == Map<String, dynamic>) {
      return (data as Map).map((k, v) =>
          MapEntry(deserialize<String>(k), deserialize<dynamic>(v))) as T;
    }
    if (t == List<_i15.SlotVariant>) {
      return (data as List)
          .map((e) => deserialize<_i15.SlotVariant>(e))
          .toList() as T;
    }
    try {
      return _i16.Protocol().deserialize<T>(data, t);
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
    if (data is _i4.Category) {
      return 'Category';
    }
    if (data is _i5.LoginRequest) {
      return 'LoginRequest';
    }
    if (data is _i6.News) {
      return 'News';
    }
    if (data is _i7.PaymentMethod) {
      return 'PaymentMethod';
    }
    if (data is _i8.RegistrationRequest) {
      return 'RegistrationRequest';
    }
    if (data is _i9.Settings) {
      return 'Settings';
    }
    if (data is _i10.SlotVariant) {
      return 'SlotVariant';
    }
    if (data is _i11.User) {
      return 'User';
    }
    if (data is _i12.UserRole) {
      return 'UserRole';
    }
    className = _i16.Protocol().getClassNameForObject(data);
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
    if (dataClassName == 'Category') {
      return deserialize<_i4.Category>(data['data']);
    }
    if (dataClassName == 'LoginRequest') {
      return deserialize<_i5.LoginRequest>(data['data']);
    }
    if (dataClassName == 'News') {
      return deserialize<_i6.News>(data['data']);
    }
    if (dataClassName == 'PaymentMethod') {
      return deserialize<_i7.PaymentMethod>(data['data']);
    }
    if (dataClassName == 'RegistrationRequest') {
      return deserialize<_i8.RegistrationRequest>(data['data']);
    }
    if (dataClassName == 'Settings') {
      return deserialize<_i9.Settings>(data['data']);
    }
    if (dataClassName == 'SlotVariant') {
      return deserialize<_i10.SlotVariant>(data['data']);
    }
    if (dataClassName == 'User') {
      return deserialize<_i11.User>(data['data']);
    }
    if (dataClassName == 'UserRole') {
      return deserialize<_i12.UserRole>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth.')) {
      data['className'] = dataClassName.substring(15);
      return _i16.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }
}
