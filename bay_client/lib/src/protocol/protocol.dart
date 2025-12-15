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
import 'favorite.dart' as _i5;
import 'listing.dart' as _i6;
import 'listing_image.dart' as _i7;
import 'login_request.dart' as _i8;
import 'news.dart' as _i9;
import 'order_status.dart' as _i10;
import 'payment_method.dart' as _i11;
import 'quantity_unit.dart' as _i12;
import 'registration_request.dart' as _i13;
import 'search_result.dart' as _i14;
import 'settings.dart' as _i15;
import 'slot_order.dart' as _i16;
import 'slot_variant.dart' as _i17;
import 'user.dart' as _i18;
import 'user_role.dart' as _i19;
import 'user_slot.dart' as _i20;
import 'package:bay_client/src/protocol/category.dart' as _i21;
import 'package:bay_client/src/protocol/listing.dart' as _i22;
import 'package:bay_client/src/protocol/listing_image.dart' as _i23;
import 'package:bay_client/src/protocol/news.dart' as _i24;
import 'package:bay_client/src/protocol/slot_order.dart' as _i25;
import 'package:bay_client/src/protocol/slot_variant.dart' as _i26;
import 'package:bay_client/src/protocol/user_slot.dart' as _i27;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i28;
export 'greeting.dart';
export 'auth_response.dart';
export 'category.dart';
export 'favorite.dart';
export 'listing.dart';
export 'listing_image.dart';
export 'login_request.dart';
export 'news.dart';
export 'order_status.dart';
export 'payment_method.dart';
export 'quantity_unit.dart';
export 'registration_request.dart';
export 'search_result.dart';
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
    if (t == _i5.Favorite) {
      return _i5.Favorite.fromJson(data) as T;
    }
    if (t == _i6.Listing) {
      return _i6.Listing.fromJson(data) as T;
    }
    if (t == _i7.ListingImage) {
      return _i7.ListingImage.fromJson(data) as T;
    }
    if (t == _i8.LoginRequest) {
      return _i8.LoginRequest.fromJson(data) as T;
    }
    if (t == _i9.News) {
      return _i9.News.fromJson(data) as T;
    }
    if (t == _i10.OrderStatus) {
      return _i10.OrderStatus.fromJson(data) as T;
    }
    if (t == _i11.PaymentMethod) {
      return _i11.PaymentMethod.fromJson(data) as T;
    }
    if (t == _i12.QuantityUnit) {
      return _i12.QuantityUnit.fromJson(data) as T;
    }
    if (t == _i13.RegistrationRequest) {
      return _i13.RegistrationRequest.fromJson(data) as T;
    }
    if (t == _i14.SearchResult) {
      return _i14.SearchResult.fromJson(data) as T;
    }
    if (t == _i15.Settings) {
      return _i15.Settings.fromJson(data) as T;
    }
    if (t == _i16.SlotOrder) {
      return _i16.SlotOrder.fromJson(data) as T;
    }
    if (t == _i17.SlotVariant) {
      return _i17.SlotVariant.fromJson(data) as T;
    }
    if (t == _i18.User) {
      return _i18.User.fromJson(data) as T;
    }
    if (t == _i19.UserRole) {
      return _i19.UserRole.fromJson(data) as T;
    }
    if (t == _i20.UserSlot) {
      return _i20.UserSlot.fromJson(data) as T;
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
    if (t == _i1.getType<_i5.Favorite?>()) {
      return (data != null ? _i5.Favorite.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.Listing?>()) {
      return (data != null ? _i6.Listing.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.ListingImage?>()) {
      return (data != null ? _i7.ListingImage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.LoginRequest?>()) {
      return (data != null ? _i8.LoginRequest.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.News?>()) {
      return (data != null ? _i9.News.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.OrderStatus?>()) {
      return (data != null ? _i10.OrderStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.PaymentMethod?>()) {
      return (data != null ? _i11.PaymentMethod.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.QuantityUnit?>()) {
      return (data != null ? _i12.QuantityUnit.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.RegistrationRequest?>()) {
      return (data != null ? _i13.RegistrationRequest.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i14.SearchResult?>()) {
      return (data != null ? _i14.SearchResult.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.Settings?>()) {
      return (data != null ? _i15.Settings.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.SlotOrder?>()) {
      return (data != null ? _i16.SlotOrder.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.SlotVariant?>()) {
      return (data != null ? _i17.SlotVariant.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.User?>()) {
      return (data != null ? _i18.User.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i19.UserRole?>()) {
      return (data != null ? _i19.UserRole.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i20.UserSlot?>()) {
      return (data != null ? _i20.UserSlot.fromJson(data) : null) as T;
    }
    if (t == List<_i6.Listing>) {
      return (data as List).map((e) => deserialize<_i6.Listing>(e)).toList()
          as T;
    }
    if (t == List<_i21.Category>) {
      return (data as List).map((e) => deserialize<_i21.Category>(e)).toList()
          as T;
    }
    if (t == List<_i22.Listing>) {
      return (data as List).map((e) => deserialize<_i22.Listing>(e)).toList()
          as T;
    }
    if (t == Map<int, bool>) {
      return Map.fromEntries((data as List).map((e) =>
          MapEntry(deserialize<int>(e['k']), deserialize<bool>(e['v'])))) as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == List<_i23.ListingImage>) {
      return (data as List)
          .map((e) => deserialize<_i23.ListingImage>(e))
          .toList() as T;
    }
    if (t == List<_i24.News>) {
      return (data as List).map((e) => deserialize<_i24.News>(e)).toList() as T;
    }
    if (t == Map<String, String>) {
      return (data as Map).map((k, v) =>
          MapEntry(deserialize<String>(k), deserialize<String>(v))) as T;
    }
    if (t == Map<String, dynamic>) {
      return (data as Map).map((k, v) =>
          MapEntry(deserialize<String>(k), deserialize<dynamic>(v))) as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i25.SlotOrder>) {
      return (data as List).map((e) => deserialize<_i25.SlotOrder>(e)).toList()
          as T;
    }
    if (t == List<_i26.SlotVariant>) {
      return (data as List)
          .map((e) => deserialize<_i26.SlotVariant>(e))
          .toList() as T;
    }
    if (t == List<_i27.UserSlot>) {
      return (data as List).map((e) => deserialize<_i27.UserSlot>(e)).toList()
          as T;
    }
    if (t == Map<String, int>) {
      return (data as Map).map(
          (k, v) => MapEntry(deserialize<String>(k), deserialize<int>(v))) as T;
    }
    try {
      return _i28.Protocol().deserialize<T>(data, t);
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
    if (data is _i5.Favorite) {
      return 'Favorite';
    }
    if (data is _i6.Listing) {
      return 'Listing';
    }
    if (data is _i7.ListingImage) {
      return 'ListingImage';
    }
    if (data is _i8.LoginRequest) {
      return 'LoginRequest';
    }
    if (data is _i9.News) {
      return 'News';
    }
    if (data is _i10.OrderStatus) {
      return 'OrderStatus';
    }
    if (data is _i11.PaymentMethod) {
      return 'PaymentMethod';
    }
    if (data is _i12.QuantityUnit) {
      return 'QuantityUnit';
    }
    if (data is _i13.RegistrationRequest) {
      return 'RegistrationRequest';
    }
    if (data is _i14.SearchResult) {
      return 'SearchResult';
    }
    if (data is _i15.Settings) {
      return 'Settings';
    }
    if (data is _i16.SlotOrder) {
      return 'SlotOrder';
    }
    if (data is _i17.SlotVariant) {
      return 'SlotVariant';
    }
    if (data is _i18.User) {
      return 'User';
    }
    if (data is _i19.UserRole) {
      return 'UserRole';
    }
    if (data is _i20.UserSlot) {
      return 'UserSlot';
    }
    className = _i28.Protocol().getClassNameForObject(data);
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
    if (dataClassName == 'Favorite') {
      return deserialize<_i5.Favorite>(data['data']);
    }
    if (dataClassName == 'Listing') {
      return deserialize<_i6.Listing>(data['data']);
    }
    if (dataClassName == 'ListingImage') {
      return deserialize<_i7.ListingImage>(data['data']);
    }
    if (dataClassName == 'LoginRequest') {
      return deserialize<_i8.LoginRequest>(data['data']);
    }
    if (dataClassName == 'News') {
      return deserialize<_i9.News>(data['data']);
    }
    if (dataClassName == 'OrderStatus') {
      return deserialize<_i10.OrderStatus>(data['data']);
    }
    if (dataClassName == 'PaymentMethod') {
      return deserialize<_i11.PaymentMethod>(data['data']);
    }
    if (dataClassName == 'QuantityUnit') {
      return deserialize<_i12.QuantityUnit>(data['data']);
    }
    if (dataClassName == 'RegistrationRequest') {
      return deserialize<_i13.RegistrationRequest>(data['data']);
    }
    if (dataClassName == 'SearchResult') {
      return deserialize<_i14.SearchResult>(data['data']);
    }
    if (dataClassName == 'Settings') {
      return deserialize<_i15.Settings>(data['data']);
    }
    if (dataClassName == 'SlotOrder') {
      return deserialize<_i16.SlotOrder>(data['data']);
    }
    if (dataClassName == 'SlotVariant') {
      return deserialize<_i17.SlotVariant>(data['data']);
    }
    if (dataClassName == 'User') {
      return deserialize<_i18.User>(data['data']);
    }
    if (dataClassName == 'UserRole') {
      return deserialize<_i19.UserRole>(data['data']);
    }
    if (dataClassName == 'UserSlot') {
      return deserialize<_i20.UserSlot>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth.')) {
      data['className'] = dataClassName.substring(15);
      return _i28.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }
}
