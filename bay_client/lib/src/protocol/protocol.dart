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
import 'listing.dart' as _i5;
import 'listing_image.dart' as _i6;
import 'login_request.dart' as _i7;
import 'news.dart' as _i8;
import 'order_status.dart' as _i9;
import 'payment_method.dart' as _i10;
import 'quantity_unit.dart' as _i11;
import 'registration_request.dart' as _i12;
import 'settings.dart' as _i13;
import 'slot_order.dart' as _i14;
import 'slot_variant.dart' as _i15;
import 'user.dart' as _i16;
import 'user_role.dart' as _i17;
import 'user_slot.dart' as _i18;
import 'package:bay_client/src/protocol/category.dart' as _i19;
import 'package:bay_client/src/protocol/listing.dart' as _i20;
import 'package:bay_client/src/protocol/listing_image.dart' as _i21;
import 'package:bay_client/src/protocol/news.dart' as _i22;
import 'package:bay_client/src/protocol/slot_order.dart' as _i23;
import 'package:bay_client/src/protocol/slot_variant.dart' as _i24;
import 'package:bay_client/src/protocol/user_slot.dart' as _i25;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i26;
export 'greeting.dart';
export 'auth_response.dart';
export 'category.dart';
export 'listing.dart';
export 'listing_image.dart';
export 'login_request.dart';
export 'news.dart';
export 'order_status.dart';
export 'payment_method.dart';
export 'quantity_unit.dart';
export 'registration_request.dart';
export 'settings.dart';
export 'slot_order.dart';
export 'slot_variant.dart';
export 'user.dart';
export 'user_role.dart';
export 'user_slot.dart';
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
    if (t == _i5.Listing) {
      return _i5.Listing.fromJson(data) as T;
    }
    if (t == _i6.ListingImage) {
      return _i6.ListingImage.fromJson(data) as T;
    }
    if (t == _i7.LoginRequest) {
      return _i7.LoginRequest.fromJson(data) as T;
    }
    if (t == _i8.News) {
      return _i8.News.fromJson(data) as T;
    }
    if (t == _i9.OrderStatus) {
      return _i9.OrderStatus.fromJson(data) as T;
    }
    if (t == _i10.PaymentMethod) {
      return _i10.PaymentMethod.fromJson(data) as T;
    }
    if (t == _i11.QuantityUnit) {
      return _i11.QuantityUnit.fromJson(data) as T;
    }
    if (t == _i12.RegistrationRequest) {
      return _i12.RegistrationRequest.fromJson(data) as T;
    }
    if (t == _i13.Settings) {
      return _i13.Settings.fromJson(data) as T;
    }
    if (t == _i14.SlotOrder) {
      return _i14.SlotOrder.fromJson(data) as T;
    }
    if (t == _i15.SlotVariant) {
      return _i15.SlotVariant.fromJson(data) as T;
    }
    if (t == _i16.User) {
      return _i16.User.fromJson(data) as T;
    }
    if (t == _i17.UserRole) {
      return _i17.UserRole.fromJson(data) as T;
    }
    if (t == _i18.UserSlot) {
      return _i18.UserSlot.fromJson(data) as T;
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
    if (t == _i1.getType<_i5.Listing?>()) {
      return (data != null ? _i5.Listing.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.ListingImage?>()) {
      return (data != null ? _i6.ListingImage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.LoginRequest?>()) {
      return (data != null ? _i7.LoginRequest.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.News?>()) {
      return (data != null ? _i8.News.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.OrderStatus?>()) {
      return (data != null ? _i9.OrderStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.PaymentMethod?>()) {
      return (data != null ? _i10.PaymentMethod.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.QuantityUnit?>()) {
      return (data != null ? _i11.QuantityUnit.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.RegistrationRequest?>()) {
      return (data != null ? _i12.RegistrationRequest.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i13.Settings?>()) {
      return (data != null ? _i13.Settings.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.SlotOrder?>()) {
      return (data != null ? _i14.SlotOrder.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.SlotVariant?>()) {
      return (data != null ? _i15.SlotVariant.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.User?>()) {
      return (data != null ? _i16.User.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.UserRole?>()) {
      return (data != null ? _i17.UserRole.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.UserSlot?>()) {
      return (data != null ? _i18.UserSlot.fromJson(data) : null) as T;
    }
    if (t == List<_i19.Category>) {
      return (data as List).map((e) => deserialize<_i19.Category>(e)).toList()
          as T;
    }
    if (t == List<_i20.Listing>) {
      return (data as List).map((e) => deserialize<_i20.Listing>(e)).toList()
          as T;
    }
    if (t == List<_i21.ListingImage>) {
      return (data as List)
          .map((e) => deserialize<_i21.ListingImage>(e))
          .toList() as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == List<_i22.News>) {
      return (data as List).map((e) => deserialize<_i22.News>(e)).toList() as T;
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
    if (t == List<_i23.SlotOrder>) {
      return (data as List).map((e) => deserialize<_i23.SlotOrder>(e)).toList()
          as T;
    }
    if (t == List<_i24.SlotVariant>) {
      return (data as List)
          .map((e) => deserialize<_i24.SlotVariant>(e))
          .toList() as T;
    }
    if (t == List<_i25.UserSlot>) {
      return (data as List).map((e) => deserialize<_i25.UserSlot>(e)).toList()
          as T;
    }
    if (t == Map<String, int>) {
      return (data as Map).map(
          (k, v) => MapEntry(deserialize<String>(k), deserialize<int>(v))) as T;
    }
    try {
      return _i26.Protocol().deserialize<T>(data, t);
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
    if (data is _i5.Listing) {
      return 'Listing';
    }
    if (data is _i6.ListingImage) {
      return 'ListingImage';
    }
    if (data is _i7.LoginRequest) {
      return 'LoginRequest';
    }
    if (data is _i8.News) {
      return 'News';
    }
    if (data is _i9.OrderStatus) {
      return 'OrderStatus';
    }
    if (data is _i10.PaymentMethod) {
      return 'PaymentMethod';
    }
    if (data is _i11.QuantityUnit) {
      return 'QuantityUnit';
    }
    if (data is _i12.RegistrationRequest) {
      return 'RegistrationRequest';
    }
    if (data is _i13.Settings) {
      return 'Settings';
    }
    if (data is _i14.SlotOrder) {
      return 'SlotOrder';
    }
    if (data is _i15.SlotVariant) {
      return 'SlotVariant';
    }
    if (data is _i16.User) {
      return 'User';
    }
    if (data is _i17.UserRole) {
      return 'UserRole';
    }
    if (data is _i18.UserSlot) {
      return 'UserSlot';
    }
    className = _i26.Protocol().getClassNameForObject(data);
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
    if (dataClassName == 'Listing') {
      return deserialize<_i5.Listing>(data['data']);
    }
    if (dataClassName == 'ListingImage') {
      return deserialize<_i6.ListingImage>(data['data']);
    }
    if (dataClassName == 'LoginRequest') {
      return deserialize<_i7.LoginRequest>(data['data']);
    }
    if (dataClassName == 'News') {
      return deserialize<_i8.News>(data['data']);
    }
    if (dataClassName == 'OrderStatus') {
      return deserialize<_i9.OrderStatus>(data['data']);
    }
    if (dataClassName == 'PaymentMethod') {
      return deserialize<_i10.PaymentMethod>(data['data']);
    }
    if (dataClassName == 'QuantityUnit') {
      return deserialize<_i11.QuantityUnit>(data['data']);
    }
    if (dataClassName == 'RegistrationRequest') {
      return deserialize<_i12.RegistrationRequest>(data['data']);
    }
    if (dataClassName == 'Settings') {
      return deserialize<_i13.Settings>(data['data']);
    }
    if (dataClassName == 'SlotOrder') {
      return deserialize<_i14.SlotOrder>(data['data']);
    }
    if (dataClassName == 'SlotVariant') {
      return deserialize<_i15.SlotVariant>(data['data']);
    }
    if (dataClassName == 'User') {
      return deserialize<_i16.User>(data['data']);
    }
    if (dataClassName == 'UserRole') {
      return deserialize<_i17.UserRole>(data['data']);
    }
    if (dataClassName == 'UserSlot') {
      return deserialize<_i18.UserSlot>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth.')) {
      data['className'] = dataClassName.substring(15);
      return _i26.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }
}
