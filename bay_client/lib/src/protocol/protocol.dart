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
import 'message_draft.dart' as _i2;
import 'auth_response.dart' as _i3;
import 'category.dart' as _i4;
import 'currency_rate.dart' as _i5;
import 'dispute.dart' as _i6;
import 'dispute_status.dart' as _i7;
import 'encrypted_key_backup.dart' as _i8;
import 'favorite.dart' as _i9;
import 'listing.dart' as _i10;
import 'listing_image.dart' as _i11;
import 'login_request.dart' as _i12;
import 'message.dart' as _i13;
import 'greeting.dart' as _i14;
import 'news.dart' as _i15;
import 'order_status.dart' as _i16;
import 'payment_method.dart' as _i17;
import 'quantity_unit.dart' as _i18;
import 'rating.dart' as _i19;
import 'rating_stats.dart' as _i20;
import 'rating_value.dart' as _i21;
import 'registration_request.dart' as _i22;
import 'report.dart' as _i23;
import 'report_reason.dart' as _i24;
import 'report_status.dart' as _i25;
import 'user_slot.dart' as _i26;
import 'search_result.dart' as _i27;
import 'settings.dart' as _i28;
import 'slot_order.dart' as _i29;
import 'slot_variant.dart' as _i30;
import 'transaction.dart' as _i31;
import 'transaction_status.dart' as _i32;
import 'user.dart' as _i33;
import 'user_ban_log.dart' as _i34;
import 'user_payment_info.dart' as _i35;
import 'user_profile.dart' as _i36;
import 'user_public_key.dart' as _i37;
import 'user_role.dart' as _i38;
import 'report_target_type.dart' as _i39;
import 'package:bay_client/src/protocol/category.dart' as _i40;
import 'package:bay_client/src/protocol/dispute.dart' as _i41;
import 'package:bay_client/src/protocol/message_draft.dart' as _i42;
import 'package:bay_client/src/protocol/listing.dart' as _i43;
import 'package:bay_client/src/protocol/listing_image.dart' as _i44;
import 'package:bay_client/src/protocol/message.dart' as _i45;
import 'package:bay_client/src/protocol/news.dart' as _i46;
import 'package:bay_client/src/protocol/encrypted_key_backup.dart' as _i47;
import 'package:bay_client/src/protocol/rating.dart' as _i48;
import 'package:bay_client/src/protocol/transaction.dart' as _i49;
import 'package:bay_client/src/protocol/report.dart' as _i50;
import 'package:bay_client/src/protocol/slot_order.dart' as _i51;
import 'package:bay_client/src/protocol/slot_variant.dart' as _i52;
import 'package:bay_client/src/protocol/user.dart' as _i53;
import 'package:bay_client/src/protocol/user_ban_log.dart' as _i54;
import 'package:bay_client/src/protocol/user_slot.dart' as _i55;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i56;
export 'greeting.dart';
export 'auth_response.dart';
export 'category.dart';
export 'currency_rate.dart';
export 'dispute.dart';
export 'dispute_status.dart';
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
export 'rating.dart';
export 'rating_stats.dart';
export 'rating_value.dart';
export 'registration_request.dart';
export 'report.dart';
export 'report_reason.dart';
export 'report_status.dart';
export 'report_target_type.dart';
export 'search_result.dart';
export 'settings.dart';
export 'slot_order.dart';
export 'slot_variant.dart';
export 'transaction.dart';
export 'transaction_status.dart';
export 'user.dart';
export 'user_ban_log.dart';
export 'user_payment_info.dart';
export 'user_profile.dart';
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
    if (t == _i2.MessageDraft) {
      return _i2.MessageDraft.fromJson(data) as T;
    }
    if (t == _i3.AuthResponse) {
      return _i3.AuthResponse.fromJson(data) as T;
    }
    if (t == _i4.Category) {
      return _i4.Category.fromJson(data) as T;
    }
    if (t == _i5.CurrencyRate) {
      return _i5.CurrencyRate.fromJson(data) as T;
    }
    if (t == _i6.Dispute) {
      return _i6.Dispute.fromJson(data) as T;
    }
    if (t == _i7.DisputeStatus) {
      return _i7.DisputeStatus.fromJson(data) as T;
    }
    if (t == _i8.EncryptedKeyBackup) {
      return _i8.EncryptedKeyBackup.fromJson(data) as T;
    }
    if (t == _i9.Favorite) {
      return _i9.Favorite.fromJson(data) as T;
    }
    if (t == _i10.Listing) {
      return _i10.Listing.fromJson(data) as T;
    }
    if (t == _i11.ListingImage) {
      return _i11.ListingImage.fromJson(data) as T;
    }
    if (t == _i12.LoginRequest) {
      return _i12.LoginRequest.fromJson(data) as T;
    }
    if (t == _i13.Message) {
      return _i13.Message.fromJson(data) as T;
    }
    if (t == _i14.Greeting) {
      return _i14.Greeting.fromJson(data) as T;
    }
    if (t == _i15.News) {
      return _i15.News.fromJson(data) as T;
    }
    if (t == _i16.OrderStatus) {
      return _i16.OrderStatus.fromJson(data) as T;
    }
    if (t == _i17.PaymentMethod) {
      return _i17.PaymentMethod.fromJson(data) as T;
    }
    if (t == _i18.QuantityUnit) {
      return _i18.QuantityUnit.fromJson(data) as T;
    }
    if (t == _i19.Rating) {
      return _i19.Rating.fromJson(data) as T;
    }
    if (t == _i20.RatingStats) {
      return _i20.RatingStats.fromJson(data) as T;
    }
    if (t == _i21.RatingValue) {
      return _i21.RatingValue.fromJson(data) as T;
    }
    if (t == _i22.RegistrationRequest) {
      return _i22.RegistrationRequest.fromJson(data) as T;
    }
    if (t == _i23.Report) {
      return _i23.Report.fromJson(data) as T;
    }
    if (t == _i24.ReportReason) {
      return _i24.ReportReason.fromJson(data) as T;
    }
    if (t == _i25.ReportStatus) {
      return _i25.ReportStatus.fromJson(data) as T;
    }
    if (t == _i26.UserSlot) {
      return _i26.UserSlot.fromJson(data) as T;
    }
    if (t == _i27.SearchResult) {
      return _i27.SearchResult.fromJson(data) as T;
    }
    if (t == _i28.Settings) {
      return _i28.Settings.fromJson(data) as T;
    }
    if (t == _i29.SlotOrder) {
      return _i29.SlotOrder.fromJson(data) as T;
    }
    if (t == _i30.SlotVariant) {
      return _i30.SlotVariant.fromJson(data) as T;
    }
    if (t == _i31.Transaction) {
      return _i31.Transaction.fromJson(data) as T;
    }
    if (t == _i32.TransactionStatus) {
      return _i32.TransactionStatus.fromJson(data) as T;
    }
    if (t == _i33.User) {
      return _i33.User.fromJson(data) as T;
    }
    if (t == _i34.UserBanLog) {
      return _i34.UserBanLog.fromJson(data) as T;
    }
    if (t == _i35.UserPaymentInfo) {
      return _i35.UserPaymentInfo.fromJson(data) as T;
    }
    if (t == _i36.UserProfile) {
      return _i36.UserProfile.fromJson(data) as T;
    }
    if (t == _i37.UserPublicKey) {
      return _i37.UserPublicKey.fromJson(data) as T;
    }
    if (t == _i38.UserRole) {
      return _i38.UserRole.fromJson(data) as T;
    }
    if (t == _i39.ReportTargetType) {
      return _i39.ReportTargetType.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.MessageDraft?>()) {
      return (data != null ? _i2.MessageDraft.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.AuthResponse?>()) {
      return (data != null ? _i3.AuthResponse.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.Category?>()) {
      return (data != null ? _i4.Category.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.CurrencyRate?>()) {
      return (data != null ? _i5.CurrencyRate.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.Dispute?>()) {
      return (data != null ? _i6.Dispute.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.DisputeStatus?>()) {
      return (data != null ? _i7.DisputeStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.EncryptedKeyBackup?>()) {
      return (data != null ? _i8.EncryptedKeyBackup.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.Favorite?>()) {
      return (data != null ? _i9.Favorite.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.Listing?>()) {
      return (data != null ? _i10.Listing.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.ListingImage?>()) {
      return (data != null ? _i11.ListingImage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.LoginRequest?>()) {
      return (data != null ? _i12.LoginRequest.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.Message?>()) {
      return (data != null ? _i13.Message.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.Greeting?>()) {
      return (data != null ? _i14.Greeting.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.News?>()) {
      return (data != null ? _i15.News.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.OrderStatus?>()) {
      return (data != null ? _i16.OrderStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.PaymentMethod?>()) {
      return (data != null ? _i17.PaymentMethod.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.QuantityUnit?>()) {
      return (data != null ? _i18.QuantityUnit.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i19.Rating?>()) {
      return (data != null ? _i19.Rating.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i20.RatingStats?>()) {
      return (data != null ? _i20.RatingStats.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i21.RatingValue?>()) {
      return (data != null ? _i21.RatingValue.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i22.RegistrationRequest?>()) {
      return (data != null ? _i22.RegistrationRequest.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i23.Report?>()) {
      return (data != null ? _i23.Report.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i24.ReportReason?>()) {
      return (data != null ? _i24.ReportReason.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i25.ReportStatus?>()) {
      return (data != null ? _i25.ReportStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i26.UserSlot?>()) {
      return (data != null ? _i26.UserSlot.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i27.SearchResult?>()) {
      return (data != null ? _i27.SearchResult.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i28.Settings?>()) {
      return (data != null ? _i28.Settings.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i29.SlotOrder?>()) {
      return (data != null ? _i29.SlotOrder.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i30.SlotVariant?>()) {
      return (data != null ? _i30.SlotVariant.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i31.Transaction?>()) {
      return (data != null ? _i31.Transaction.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i32.TransactionStatus?>()) {
      return (data != null ? _i32.TransactionStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i33.User?>()) {
      return (data != null ? _i33.User.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i34.UserBanLog?>()) {
      return (data != null ? _i34.UserBanLog.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i35.UserPaymentInfo?>()) {
      return (data != null ? _i35.UserPaymentInfo.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i36.UserProfile?>()) {
      return (data != null ? _i36.UserProfile.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i37.UserPublicKey?>()) {
      return (data != null ? _i37.UserPublicKey.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i38.UserRole?>()) {
      return (data != null ? _i38.UserRole.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i39.ReportTargetType?>()) {
      return (data != null ? _i39.ReportTargetType.fromJson(data) : null) as T;
    }
    if (t == List<_i10.Listing>) {
      return (data as List).map((e) => deserialize<_i10.Listing>(e)).toList()
          as T;
    }
    if (t == List<_i40.Category>) {
      return (data as List).map((e) => deserialize<_i40.Category>(e)).toList()
          as T;
    }
    if (t == Map<String, double>) {
      return (data as Map).map((k, v) =>
          MapEntry(deserialize<String>(k), deserialize<double>(v))) as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i41.Dispute>) {
      return (data as List).map((e) => deserialize<_i41.Dispute>(e)).toList()
          as T;
    }
    if (t == List<_i42.MessageDraft>) {
      return (data as List)
          .map((e) => deserialize<_i42.MessageDraft>(e))
          .toList() as T;
    }
    if (t == List<_i43.Listing>) {
      return (data as List).map((e) => deserialize<_i43.Listing>(e)).toList()
          as T;
    }
    if (t == Map<int, bool>) {
      return Map.fromEntries((data as List).map((e) =>
          MapEntry(deserialize<int>(e['k']), deserialize<bool>(e['v'])))) as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == List<_i44.ListingImage>) {
      return (data as List)
          .map((e) => deserialize<_i44.ListingImage>(e))
          .toList() as T;
    }
    if (t == List<_i45.Message>) {
      return (data as List).map((e) => deserialize<_i45.Message>(e)).toList()
          as T;
    }
    if (t == List<Map<String, dynamic>>) {
      return (data as List)
          .map((e) => deserialize<Map<String, dynamic>>(e))
          .toList() as T;
    }
    if (t == Map<String, dynamic>) {
      return (data as Map).map((k, v) =>
          MapEntry(deserialize<String>(k), deserialize<dynamic>(v))) as T;
    }
    if (t == List<_i46.News>) {
      return (data as List).map((e) => deserialize<_i46.News>(e)).toList() as T;
    }
    if (t == Map<String, String>) {
      return (data as Map).map((k, v) =>
          MapEntry(deserialize<String>(k), deserialize<String>(v))) as T;
    }
    if (t == _i1.getType<Map<String, dynamic>?>()) {
      return (data != null
          ? (data as Map).map((k, v) =>
              MapEntry(deserialize<String>(k), deserialize<dynamic>(v)))
          : null) as T;
    }
    if (t == List<_i47.EncryptedKeyBackup>) {
      return (data as List)
          .map((e) => deserialize<_i47.EncryptedKeyBackup>(e))
          .toList() as T;
    }
    if (t == List<_i48.Rating>) {
      return (data as List).map((e) => deserialize<_i48.Rating>(e)).toList()
          as T;
    }
    if (t == List<_i49.Transaction>) {
      return (data as List)
          .map((e) => deserialize<_i49.Transaction>(e))
          .toList() as T;
    }
    if (t == List<_i50.Report>) {
      return (data as List).map((e) => deserialize<_i50.Report>(e)).toList()
          as T;
    }
    if (t == List<_i51.SlotOrder>) {
      return (data as List).map((e) => deserialize<_i51.SlotOrder>(e)).toList()
          as T;
    }
    if (t == List<_i52.SlotVariant>) {
      return (data as List)
          .map((e) => deserialize<_i52.SlotVariant>(e))
          .toList() as T;
    }
    if (t == List<_i53.User>) {
      return (data as List).map((e) => deserialize<_i53.User>(e)).toList() as T;
    }
    if (t == List<_i54.UserBanLog>) {
      return (data as List).map((e) => deserialize<_i54.UserBanLog>(e)).toList()
          as T;
    }
    if (t == Map<String, int>) {
      return (data as Map).map(
          (k, v) => MapEntry(deserialize<String>(k), deserialize<int>(v))) as T;
    }
    if (t == List<_i55.UserSlot>) {
      return (data as List).map((e) => deserialize<_i55.UserSlot>(e)).toList()
          as T;
    }
    try {
      return _i56.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;
    if (data is _i2.MessageDraft) {
      return 'MessageDraft';
    }
    if (data is _i3.AuthResponse) {
      return 'AuthResponse';
    }
    if (data is _i4.Category) {
      return 'Category';
    }
    if (data is _i5.CurrencyRate) {
      return 'CurrencyRate';
    }
    if (data is _i6.Dispute) {
      return 'Dispute';
    }
    if (data is _i7.DisputeStatus) {
      return 'DisputeStatus';
    }
    if (data is _i8.EncryptedKeyBackup) {
      return 'EncryptedKeyBackup';
    }
    if (data is _i9.Favorite) {
      return 'Favorite';
    }
    if (data is _i10.Listing) {
      return 'Listing';
    }
    if (data is _i11.ListingImage) {
      return 'ListingImage';
    }
    if (data is _i12.LoginRequest) {
      return 'LoginRequest';
    }
    if (data is _i13.Message) {
      return 'Message';
    }
    if (data is _i14.Greeting) {
      return 'Greeting';
    }
    if (data is _i15.News) {
      return 'News';
    }
    if (data is _i16.OrderStatus) {
      return 'OrderStatus';
    }
    if (data is _i17.PaymentMethod) {
      return 'PaymentMethod';
    }
    if (data is _i18.QuantityUnit) {
      return 'QuantityUnit';
    }
    if (data is _i19.Rating) {
      return 'Rating';
    }
    if (data is _i20.RatingStats) {
      return 'RatingStats';
    }
    if (data is _i21.RatingValue) {
      return 'RatingValue';
    }
    if (data is _i22.RegistrationRequest) {
      return 'RegistrationRequest';
    }
    if (data is _i23.Report) {
      return 'Report';
    }
    if (data is _i24.ReportReason) {
      return 'ReportReason';
    }
    if (data is _i25.ReportStatus) {
      return 'ReportStatus';
    }
    if (data is _i26.UserSlot) {
      return 'UserSlot';
    }
    if (data is _i27.SearchResult) {
      return 'SearchResult';
    }
    if (data is _i28.Settings) {
      return 'Settings';
    }
    if (data is _i29.SlotOrder) {
      return 'SlotOrder';
    }
    if (data is _i30.SlotVariant) {
      return 'SlotVariant';
    }
    if (data is _i31.Transaction) {
      return 'Transaction';
    }
    if (data is _i32.TransactionStatus) {
      return 'TransactionStatus';
    }
    if (data is _i33.User) {
      return 'User';
    }
    if (data is _i34.UserBanLog) {
      return 'UserBanLog';
    }
    if (data is _i35.UserPaymentInfo) {
      return 'UserPaymentInfo';
    }
    if (data is _i36.UserProfile) {
      return 'UserProfile';
    }
    if (data is _i37.UserPublicKey) {
      return 'UserPublicKey';
    }
    if (data is _i38.UserRole) {
      return 'UserRole';
    }
    if (data is _i39.ReportTargetType) {
      return 'ReportTargetType';
    }
    className = _i56.Protocol().getClassNameForObject(data);
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
    if (dataClassName == 'MessageDraft') {
      return deserialize<_i2.MessageDraft>(data['data']);
    }
    if (dataClassName == 'AuthResponse') {
      return deserialize<_i3.AuthResponse>(data['data']);
    }
    if (dataClassName == 'Category') {
      return deserialize<_i4.Category>(data['data']);
    }
    if (dataClassName == 'CurrencyRate') {
      return deserialize<_i5.CurrencyRate>(data['data']);
    }
    if (dataClassName == 'Dispute') {
      return deserialize<_i6.Dispute>(data['data']);
    }
    if (dataClassName == 'DisputeStatus') {
      return deserialize<_i7.DisputeStatus>(data['data']);
    }
    if (dataClassName == 'EncryptedKeyBackup') {
      return deserialize<_i8.EncryptedKeyBackup>(data['data']);
    }
    if (dataClassName == 'Favorite') {
      return deserialize<_i9.Favorite>(data['data']);
    }
    if (dataClassName == 'Listing') {
      return deserialize<_i10.Listing>(data['data']);
    }
    if (dataClassName == 'ListingImage') {
      return deserialize<_i11.ListingImage>(data['data']);
    }
    if (dataClassName == 'LoginRequest') {
      return deserialize<_i12.LoginRequest>(data['data']);
    }
    if (dataClassName == 'Message') {
      return deserialize<_i13.Message>(data['data']);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_i14.Greeting>(data['data']);
    }
    if (dataClassName == 'News') {
      return deserialize<_i15.News>(data['data']);
    }
    if (dataClassName == 'OrderStatus') {
      return deserialize<_i16.OrderStatus>(data['data']);
    }
    if (dataClassName == 'PaymentMethod') {
      return deserialize<_i17.PaymentMethod>(data['data']);
    }
    if (dataClassName == 'QuantityUnit') {
      return deserialize<_i18.QuantityUnit>(data['data']);
    }
    if (dataClassName == 'Rating') {
      return deserialize<_i19.Rating>(data['data']);
    }
    if (dataClassName == 'RatingStats') {
      return deserialize<_i20.RatingStats>(data['data']);
    }
    if (dataClassName == 'RatingValue') {
      return deserialize<_i21.RatingValue>(data['data']);
    }
    if (dataClassName == 'RegistrationRequest') {
      return deserialize<_i22.RegistrationRequest>(data['data']);
    }
    if (dataClassName == 'Report') {
      return deserialize<_i23.Report>(data['data']);
    }
    if (dataClassName == 'ReportReason') {
      return deserialize<_i24.ReportReason>(data['data']);
    }
    if (dataClassName == 'ReportStatus') {
      return deserialize<_i25.ReportStatus>(data['data']);
    }
    if (dataClassName == 'UserSlot') {
      return deserialize<_i26.UserSlot>(data['data']);
    }
    if (dataClassName == 'SearchResult') {
      return deserialize<_i27.SearchResult>(data['data']);
    }
    if (dataClassName == 'Settings') {
      return deserialize<_i28.Settings>(data['data']);
    }
    if (dataClassName == 'SlotOrder') {
      return deserialize<_i29.SlotOrder>(data['data']);
    }
    if (dataClassName == 'SlotVariant') {
      return deserialize<_i30.SlotVariant>(data['data']);
    }
    if (dataClassName == 'Transaction') {
      return deserialize<_i31.Transaction>(data['data']);
    }
    if (dataClassName == 'TransactionStatus') {
      return deserialize<_i32.TransactionStatus>(data['data']);
    }
    if (dataClassName == 'User') {
      return deserialize<_i33.User>(data['data']);
    }
    if (dataClassName == 'UserBanLog') {
      return deserialize<_i34.UserBanLog>(data['data']);
    }
    if (dataClassName == 'UserPaymentInfo') {
      return deserialize<_i35.UserPaymentInfo>(data['data']);
    }
    if (dataClassName == 'UserProfile') {
      return deserialize<_i36.UserProfile>(data['data']);
    }
    if (dataClassName == 'UserPublicKey') {
      return deserialize<_i37.UserPublicKey>(data['data']);
    }
    if (dataClassName == 'UserRole') {
      return deserialize<_i38.UserRole>(data['data']);
    }
    if (dataClassName == 'ReportTargetType') {
      return deserialize<_i39.ReportTargetType>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth.')) {
      data['className'] = dataClassName.substring(15);
      return _i56.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }
}
