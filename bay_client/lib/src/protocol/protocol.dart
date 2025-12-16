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
import 'encrypted_key_backup.dart' as _i5;
import 'favorite.dart' as _i6;
import 'listing.dart' as _i7;
import 'listing_image.dart' as _i8;
import 'login_request.dart' as _i9;
import 'message.dart' as _i10;
import 'message_draft.dart' as _i11;
import 'news.dart' as _i12;
import 'order_status.dart' as _i13;
import 'payment_method.dart' as _i14;
import 'quantity_unit.dart' as _i15;
import 'registration_request.dart' as _i16;
import 'search_result.dart' as _i17;
import 'settings.dart' as _i18;
import 'slot_order.dart' as _i19;
import 'slot_variant.dart' as _i20;
import 'user.dart' as _i21;
import 'user_public_key.dart' as _i22;
import 'user_role.dart' as _i23;
import 'user_slot.dart' as _i24;
import 'package:bay_client/src/protocol/category.dart' as _i25;
import 'package:bay_client/src/protocol/listing.dart' as _i26;
import 'package:bay_client/src/protocol/listing_image.dart' as _i27;
import 'package:bay_client/src/protocol/news.dart' as _i28;
import 'package:bay_client/src/protocol/encrypted_key_backup.dart' as _i29;
import 'package:bay_client/src/protocol/slot_order.dart' as _i30;
import 'package:bay_client/src/protocol/slot_variant.dart' as _i31;
import 'package:bay_client/src/protocol/user_slot.dart' as _i32;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i33;
export 'greeting.dart';
export 'auth_response.dart';
export 'category.dart';
export 'encrypted_key_backup.dart';
export 'favorite.dart';
export 'listing.dart';
export 'listing_image.dart';
export 'login_request.dart';
export 'message.dart';
export 'message_draft.dart';
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
export 'user_public_key.dart';
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
    if (t == _i5.EncryptedKeyBackup) {
      return _i5.EncryptedKeyBackup.fromJson(data) as T;
    }
    if (t == _i6.Favorite) {
      return _i6.Favorite.fromJson(data) as T;
    }
    if (t == _i7.Listing) {
      return _i7.Listing.fromJson(data) as T;
    }
    if (t == _i8.ListingImage) {
      return _i8.ListingImage.fromJson(data) as T;
    }
    if (t == _i9.LoginRequest) {
      return _i9.LoginRequest.fromJson(data) as T;
    }
    if (t == _i10.Message) {
      return _i10.Message.fromJson(data) as T;
    }
    if (t == _i11.MessageDraft) {
      return _i11.MessageDraft.fromJson(data) as T;
    }
    if (t == _i12.News) {
      return _i12.News.fromJson(data) as T;
    }
    if (t == _i13.OrderStatus) {
      return _i13.OrderStatus.fromJson(data) as T;
    }
    if (t == _i14.PaymentMethod) {
      return _i14.PaymentMethod.fromJson(data) as T;
    }
    if (t == _i15.QuantityUnit) {
      return _i15.QuantityUnit.fromJson(data) as T;
    }
    if (t == _i16.RegistrationRequest) {
      return _i16.RegistrationRequest.fromJson(data) as T;
    }
    if (t == _i17.SearchResult) {
      return _i17.SearchResult.fromJson(data) as T;
    }
    if (t == _i18.Settings) {
      return _i18.Settings.fromJson(data) as T;
    }
    if (t == _i19.SlotOrder) {
      return _i19.SlotOrder.fromJson(data) as T;
    }
    if (t == _i20.SlotVariant) {
      return _i20.SlotVariant.fromJson(data) as T;
    }
    if (t == _i21.User) {
      return _i21.User.fromJson(data) as T;
    }
    if (t == _i22.UserPublicKey) {
      return _i22.UserPublicKey.fromJson(data) as T;
    }
    if (t == _i23.UserRole) {
      return _i23.UserRole.fromJson(data) as T;
    }
    if (t == _i24.UserSlot) {
      return _i24.UserSlot.fromJson(data) as T;
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
    if (t == _i1.getType<_i5.EncryptedKeyBackup?>()) {
      return (data != null ? _i5.EncryptedKeyBackup.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.Favorite?>()) {
      return (data != null ? _i6.Favorite.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.Listing?>()) {
      return (data != null ? _i7.Listing.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.ListingImage?>()) {
      return (data != null ? _i8.ListingImage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.LoginRequest?>()) {
      return (data != null ? _i9.LoginRequest.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.Message?>()) {
      return (data != null ? _i10.Message.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.MessageDraft?>()) {
      return (data != null ? _i11.MessageDraft.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.News?>()) {
      return (data != null ? _i12.News.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.OrderStatus?>()) {
      return (data != null ? _i13.OrderStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.PaymentMethod?>()) {
      return (data != null ? _i14.PaymentMethod.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.QuantityUnit?>()) {
      return (data != null ? _i15.QuantityUnit.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.RegistrationRequest?>()) {
      return (data != null ? _i16.RegistrationRequest.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i17.SearchResult?>()) {
      return (data != null ? _i17.SearchResult.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.Settings?>()) {
      return (data != null ? _i18.Settings.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i19.SlotOrder?>()) {
      return (data != null ? _i19.SlotOrder.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i20.SlotVariant?>()) {
      return (data != null ? _i20.SlotVariant.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i21.User?>()) {
      return (data != null ? _i21.User.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i22.UserPublicKey?>()) {
      return (data != null ? _i22.UserPublicKey.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i23.UserRole?>()) {
      return (data != null ? _i23.UserRole.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i24.UserSlot?>()) {
      return (data != null ? _i24.UserSlot.fromJson(data) : null) as T;
    }
    if (t == List<_i7.Listing>) {
      return (data as List).map((e) => deserialize<_i7.Listing>(e)).toList()
          as T;
    }
    if (t == List<_i25.Category>) {
      return (data as List).map((e) => deserialize<_i25.Category>(e)).toList()
          as T;
    }
    if (t == List<_i26.Listing>) {
      return (data as List).map((e) => deserialize<_i26.Listing>(e)).toList()
          as T;
    }
    if (t == Map<int, bool>) {
      return Map.fromEntries((data as List).map((e) =>
          MapEntry(deserialize<int>(e['k']), deserialize<bool>(e['v'])))) as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == List<_i27.ListingImage>) {
      return (data as List)
          .map((e) => deserialize<_i27.ListingImage>(e))
          .toList() as T;
    }
    if (t == List<_i28.News>) {
      return (data as List).map((e) => deserialize<_i28.News>(e)).toList() as T;
    }
    if (t == Map<String, String>) {
      return (data as Map).map((k, v) =>
          MapEntry(deserialize<String>(k), deserialize<String>(v))) as T;
    }
    if (t == Map<String, dynamic>) {
      return (data as Map).map((k, v) =>
          MapEntry(deserialize<String>(k), deserialize<dynamic>(v))) as T;
    }
    if (t == _i1.getType<Map<String, dynamic>?>()) {
      return (data != null
          ? (data as Map).map((k, v) =>
              MapEntry(deserialize<String>(k), deserialize<dynamic>(v)))
          : null) as T;
    }
    if (t == List<_i29.EncryptedKeyBackup>) {
      return (data as List)
          .map((e) => deserialize<_i29.EncryptedKeyBackup>(e))
          .toList() as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i30.SlotOrder>) {
      return (data as List).map((e) => deserialize<_i30.SlotOrder>(e)).toList()
          as T;
    }
    if (t == List<_i31.SlotVariant>) {
      return (data as List)
          .map((e) => deserialize<_i31.SlotVariant>(e))
          .toList() as T;
    }
    if (t == List<_i32.UserSlot>) {
      return (data as List).map((e) => deserialize<_i32.UserSlot>(e)).toList()
          as T;
    }
    if (t == Map<String, int>) {
      return (data as Map).map(
          (k, v) => MapEntry(deserialize<String>(k), deserialize<int>(v))) as T;
    }
    try {
      return _i33.Protocol().deserialize<T>(data, t);
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
    if (data is _i5.EncryptedKeyBackup) {
      return 'EncryptedKeyBackup';
    }
    if (data is _i6.Favorite) {
      return 'Favorite';
    }
    if (data is _i7.Listing) {
      return 'Listing';
    }
    if (data is _i8.ListingImage) {
      return 'ListingImage';
    }
    if (data is _i9.LoginRequest) {
      return 'LoginRequest';
    }
    if (data is _i10.Message) {
      return 'Message';
    }
    if (data is _i11.MessageDraft) {
      return 'MessageDraft';
    }
    if (data is _i12.News) {
      return 'News';
    }
    if (data is _i13.OrderStatus) {
      return 'OrderStatus';
    }
    if (data is _i14.PaymentMethod) {
      return 'PaymentMethod';
    }
    if (data is _i15.QuantityUnit) {
      return 'QuantityUnit';
    }
    if (data is _i16.RegistrationRequest) {
      return 'RegistrationRequest';
    }
    if (data is _i17.SearchResult) {
      return 'SearchResult';
    }
    if (data is _i18.Settings) {
      return 'Settings';
    }
    if (data is _i19.SlotOrder) {
      return 'SlotOrder';
    }
    if (data is _i20.SlotVariant) {
      return 'SlotVariant';
    }
    if (data is _i21.User) {
      return 'User';
    }
    if (data is _i22.UserPublicKey) {
      return 'UserPublicKey';
    }
    if (data is _i23.UserRole) {
      return 'UserRole';
    }
    if (data is _i24.UserSlot) {
      return 'UserSlot';
    }
    className = _i33.Protocol().getClassNameForObject(data);
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
    if (dataClassName == 'EncryptedKeyBackup') {
      return deserialize<_i5.EncryptedKeyBackup>(data['data']);
    }
    if (dataClassName == 'Favorite') {
      return deserialize<_i6.Favorite>(data['data']);
    }
    if (dataClassName == 'Listing') {
      return deserialize<_i7.Listing>(data['data']);
    }
    if (dataClassName == 'ListingImage') {
      return deserialize<_i8.ListingImage>(data['data']);
    }
    if (dataClassName == 'LoginRequest') {
      return deserialize<_i9.LoginRequest>(data['data']);
    }
    if (dataClassName == 'Message') {
      return deserialize<_i10.Message>(data['data']);
    }
    if (dataClassName == 'MessageDraft') {
      return deserialize<_i11.MessageDraft>(data['data']);
    }
    if (dataClassName == 'News') {
      return deserialize<_i12.News>(data['data']);
    }
    if (dataClassName == 'OrderStatus') {
      return deserialize<_i13.OrderStatus>(data['data']);
    }
    if (dataClassName == 'PaymentMethod') {
      return deserialize<_i14.PaymentMethod>(data['data']);
    }
    if (dataClassName == 'QuantityUnit') {
      return deserialize<_i15.QuantityUnit>(data['data']);
    }
    if (dataClassName == 'RegistrationRequest') {
      return deserialize<_i16.RegistrationRequest>(data['data']);
    }
    if (dataClassName == 'SearchResult') {
      return deserialize<_i17.SearchResult>(data['data']);
    }
    if (dataClassName == 'Settings') {
      return deserialize<_i18.Settings>(data['data']);
    }
    if (dataClassName == 'SlotOrder') {
      return deserialize<_i19.SlotOrder>(data['data']);
    }
    if (dataClassName == 'SlotVariant') {
      return deserialize<_i20.SlotVariant>(data['data']);
    }
    if (dataClassName == 'User') {
      return deserialize<_i21.User>(data['data']);
    }
    if (dataClassName == 'UserPublicKey') {
      return deserialize<_i22.UserPublicKey>(data['data']);
    }
    if (dataClassName == 'UserRole') {
      return deserialize<_i23.UserRole>(data['data']);
    }
    if (dataClassName == 'UserSlot') {
      return deserialize<_i24.UserSlot>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth.')) {
      data['className'] = dataClassName.substring(15);
      return _i33.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }
}
