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
import 'dart:async' as _i2;
import 'package:bay_client/src/protocol/auth_response.dart' as _i3;
import 'package:bay_client/src/protocol/registration_request.dart' as _i4;
import 'package:bay_client/src/protocol/login_request.dart' as _i5;
import 'package:bay_client/src/protocol/category.dart' as _i6;
import 'package:bay_client/src/protocol/currency_rate.dart' as _i7;
import 'package:bay_client/src/protocol/dispute.dart' as _i8;
import 'package:bay_client/src/protocol/dispute_status.dart' as _i9;
import 'package:bay_client/src/protocol/message_draft.dart' as _i10;
import 'package:bay_client/src/protocol/favorite.dart' as _i11;
import 'package:bay_client/src/protocol/listing.dart' as _i12;
import 'package:bay_client/src/protocol/quantity_unit.dart' as _i13;
import 'package:bay_client/src/protocol/listing_image.dart' as _i14;
import 'dart:typed_data' as _i15;
import 'package:bay_client/src/protocol/message.dart' as _i16;
import 'package:bay_client/src/protocol/news.dart' as _i17;
import 'package:bay_client/src/protocol/user_public_key.dart' as _i18;
import 'package:bay_client/src/protocol/encrypted_key_backup.dart' as _i19;
import 'package:bay_client/src/protocol/rating.dart' as _i20;
import 'package:bay_client/src/protocol/rating_value.dart' as _i21;
import 'package:bay_client/src/protocol/rating_stats.dart' as _i22;
import 'package:bay_client/src/protocol/transaction.dart' as _i23;
import 'package:bay_client/src/protocol/report.dart' as _i24;
import 'package:bay_client/src/protocol/report_reason.dart' as _i25;
import 'package:bay_client/src/protocol/report_target_type.dart' as _i26;
import 'package:bay_client/src/protocol/report_status.dart' as _i27;
import 'package:bay_client/src/protocol/user.dart' as _i28;
import 'package:bay_client/src/protocol/search_result.dart' as _i29;
import 'package:bay_client/src/protocol/slot_order.dart' as _i30;
import 'package:bay_client/src/protocol/payment_method.dart' as _i31;
import 'package:bay_client/src/protocol/slot_variant.dart' as _i32;
import 'package:bay_client/src/protocol/transaction_status.dart' as _i33;
import 'package:bay_client/src/protocol/user_payment_info.dart' as _i34;
import 'package:bay_client/src/protocol/user_role.dart' as _i35;
import 'package:bay_client/src/protocol/user_ban_log.dart' as _i36;
import 'package:bay_client/src/protocol/user_profile.dart' as _i37;
import 'package:bay_client/src/protocol/user_slot.dart' as _i38;
import 'package:bay_client/src/protocol/greeting.dart' as _i39;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i40;
import 'protocol.dart' as _i41;

/// Authentication endpoint for user registration, login, and logout.
/// {@category Endpoint}
class EndpointAuth extends _i1.EndpointRef {
  EndpointAuth(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'auth';

  /// Register a new user account.
  _i2.Future<_i3.AuthResponse> register(_i4.RegistrationRequest request) =>
      caller.callServerEndpoint<_i3.AuthResponse>(
        'auth',
        'register',
        {'request': request},
      );

  /// Log in with username and password.
  _i2.Future<_i3.AuthResponse> login(_i5.LoginRequest request) =>
      caller.callServerEndpoint<_i3.AuthResponse>(
        'auth',
        'login',
        {'request': request},
      );

  /// Log out the current user.
  _i2.Future<bool> logout() => caller.callServerEndpoint<bool>(
        'auth',
        'logout',
        {},
      );

  /// Get the currently authenticated user's info.
  _i2.Future<_i3.AuthResponse> getCurrentUser() =>
      caller.callServerEndpoint<_i3.AuthResponse>(
        'auth',
        'getCurrentUser',
        {},
      );

  /// Change the current user's password.
  _i2.Future<_i3.AuthResponse> changePassword(
    String currentPassword,
    String newPassword,
  ) =>
      caller.callServerEndpoint<_i3.AuthResponse>(
        'auth',
        'changePassword',
        {
          'currentPassword': currentPassword,
          'newPassword': newPassword,
        },
      );

  /// Delete the current user's account.
  _i2.Future<_i3.AuthResponse> deleteAccount(String password) =>
      caller.callServerEndpoint<_i3.AuthResponse>(
        'auth',
        'deleteAccount',
        {'password': password},
      );
}

/// Endpoint for managing categories.
/// Most operations require admin privileges.
/// {@category Endpoint}
class EndpointCategory extends _i1.EndpointRef {
  EndpointCategory(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'category';

  /// Get all categories (public).
  _i2.Future<List<_i6.Category>> getAll() =>
      caller.callServerEndpoint<List<_i6.Category>>(
        'category',
        'getAll',
        {},
      );

  /// Get only active categories (public).
  _i2.Future<List<_i6.Category>> getActive() =>
      caller.callServerEndpoint<List<_i6.Category>>(
        'category',
        'getActive',
        {},
      );

  /// Get root categories (no parent).
  _i2.Future<List<_i6.Category>> getRootCategories() =>
      caller.callServerEndpoint<List<_i6.Category>>(
        'category',
        'getRootCategories',
        {},
      );

  /// Get subcategories for a parent category.
  _i2.Future<List<_i6.Category>> getSubcategories(int parentId) =>
      caller.callServerEndpoint<List<_i6.Category>>(
        'category',
        'getSubcategories',
        {'parentId': parentId},
      );

  /// Create a new category (admin only).
  _i2.Future<_i6.Category?> create(
    String name,
    int? parentId,
    int sortOrder,
  ) =>
      caller.callServerEndpoint<_i6.Category?>(
        'category',
        'create',
        {
          'name': name,
          'parentId': parentId,
          'sortOrder': sortOrder,
        },
      );

  /// Update a category (admin only).
  _i2.Future<_i6.Category?> update(
    int id,
    String name,
    int? parentId,
    int sortOrder,
    bool isActive,
  ) =>
      caller.callServerEndpoint<_i6.Category?>(
        'category',
        'update',
        {
          'id': id,
          'name': name,
          'parentId': parentId,
          'sortOrder': sortOrder,
          'isActive': isActive,
        },
      );

  /// Delete a category (admin only).
  /// Also deletes all subcategories.
  _i2.Future<bool> delete(int id) => caller.callServerEndpoint<bool>(
        'category',
        'delete',
        {'id': id},
      );
}

/// Endpoint for currency exchange operations
/// {@category Endpoint}
class EndpointCurrency extends _i1.EndpointRef {
  EndpointCurrency(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'currency';

  /// Get exchange rate between two currencies
  ///
  /// Returns the rate where 1 unit of [baseCurrency] equals [rate] units of [targetCurrency]
  /// Example: getExchangeRate('BTC', 'USD') might return 95000.0
  ///          meaning 1 BTC = 95000 USD
  _i2.Future<double> getExchangeRate(
    String baseCurrency,
    String targetCurrency,
  ) =>
      caller.callServerEndpoint<double>(
        'currency',
        'getExchangeRate',
        {
          'baseCurrency': baseCurrency,
          'targetCurrency': targetCurrency,
        },
      );

  /// Convert amount from one currency to another
  ///
  /// Example: convert(1.0, 'BTC', 'USD') might return 95000.0
  _i2.Future<double> convert(
    double amount,
    String fromCurrency,
    String toCurrency,
  ) =>
      caller.callServerEndpoint<double>(
        'currency',
        'convert',
        {
          'amount': amount,
          'fromCurrency': fromCurrency,
          'toCurrency': toCurrency,
        },
      );

  /// Get multiple exchange rates at once
  ///
  /// Returns a map of target currency to exchange rate
  /// Example: getMultipleRates('USD', ['EUR', 'BTC']) might return
  ///          {'EUR': 0.92, 'BTC': 0.000011}
  _i2.Future<Map<String, double>> getMultipleRates(
    String baseCurrency,
    List<String> targetCurrencies,
  ) =>
      caller.callServerEndpoint<Map<String, double>>(
        'currency',
        'getMultipleRates',
        {
          'baseCurrency': baseCurrency,
          'targetCurrencies': targetCurrencies,
        },
      );

  /// Get the latest rate from cache (without updating)
  /// Returns null if not cached or cache is old
  _i2.Future<_i7.CurrencyRate?> getCachedRate(
    String baseCurrency,
    String targetCurrency,
  ) =>
      caller.callServerEndpoint<_i7.CurrencyRate?>(
        'currency',
        'getCachedRate',
        {
          'baseCurrency': baseCurrency,
          'targetCurrency': targetCurrency,
        },
      );
}

/// Endpoint für Reklamationen (Disputes).
/// {@category Endpoint}
class EndpointDispute extends _i1.EndpointRef {
  EndpointDispute(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'dispute';

  /// Ruft eine Reklamation per ID ab.
  _i2.Future<_i8.Dispute?> getById(int disputeId) =>
      caller.callServerEndpoint<_i8.Dispute?>(
        'dispute',
        'getById',
        {'disputeId': disputeId},
      );

  /// Ruft alle Reklamationen für eine Transaktion ab.
  _i2.Future<List<_i8.Dispute>> getByTransaction(int transactionId) =>
      caller.callServerEndpoint<List<_i8.Dispute>>(
        'dispute',
        'getByTransaction',
        {'transactionId': transactionId},
      );

  /// Ruft alle offenen Reklamationen ab (nur Moderatoren).
  _i2.Future<List<_i8.Dispute>> getOpenDisputes({
    required int limit,
    required int offset,
  }) =>
      caller.callServerEndpoint<List<_i8.Dispute>>(
        'dispute',
        'getOpenDisputes',
        {
          'limit': limit,
          'offset': offset,
        },
      );

  /// Zählt offene Reklamationen (für Moderatoren).
  _i2.Future<int> getOpenCount() => caller.callServerEndpoint<int>(
        'dispute',
        'getOpenCount',
        {},
      );

  /// Übernimmt eine Reklamation (Moderator weist sich selbst zu).
  _i2.Future<_i8.Dispute> assignToMe(int disputeId) =>
      caller.callServerEndpoint<_i8.Dispute>(
        'dispute',
        'assignToMe',
        {'disputeId': disputeId},
      );

  /// Löst eine Reklamation (nur Moderatoren).
  _i2.Future<_i8.Dispute> resolve(
    int disputeId, {
    required String resolution,
    required bool completTransaction,
  }) =>
      caller.callServerEndpoint<_i8.Dispute>(
        'dispute',
        'resolve',
        {
          'disputeId': disputeId,
          'resolution': resolution,
          'completTransaction': completTransaction,
        },
      );

  /// Schließt eine Reklamation ohne Lösung (nur Moderatoren).
  _i2.Future<_i8.Dispute> close(
    int disputeId, {
    String? resolution,
  }) =>
      caller.callServerEndpoint<_i8.Dispute>(
        'dispute',
        'close',
        {
          'disputeId': disputeId,
          'resolution': resolution,
        },
      );

  /// Ruft meine Reklamationen ab (als Käufer/Verkäufer).
  _i2.Future<List<_i8.Dispute>> getMyDisputes({
    _i9.DisputeStatus? status,
    required int limit,
    required int offset,
  }) =>
      caller.callServerEndpoint<List<_i8.Dispute>>(
        'dispute',
        'getMyDisputes',
        {
          'status': status,
          'limit': limit,
          'offset': offset,
        },
      );
}

/// Endpoint für Nachrichten-Entwürfe.
/// Entwürfe werden mit dem eigenen Public Key verschlüsselt gespeichert
/// und nach 7 Tagen automatisch gelöscht.
/// {@category Endpoint}
class EndpointDraft extends _i1.EndpointRef {
  EndpointDraft(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'draft';

  /// Speichert einen neuen Entwurf.
  /// Der Inhalt sollte client-seitig mit dem eigenen Public Key verschlüsselt sein.
  _i2.Future<_i10.MessageDraft?> save({
    int? recipientId,
    String? recipientUsername,
    String? encryptedSubject,
    String? encryptedContent,
    int? listingId,
  }) =>
      caller.callServerEndpoint<_i10.MessageDraft?>(
        'draft',
        'save',
        {
          'recipientId': recipientId,
          'recipientUsername': recipientUsername,
          'encryptedSubject': encryptedSubject,
          'encryptedContent': encryptedContent,
          'listingId': listingId,
        },
      );

  /// Aktualisiert einen vorhandenen Entwurf.
  _i2.Future<_i10.MessageDraft?> update(
    int draftId, {
    int? recipientId,
    String? recipientUsername,
    String? encryptedSubject,
    String? encryptedContent,
    int? listingId,
  }) =>
      caller.callServerEndpoint<_i10.MessageDraft?>(
        'draft',
        'update',
        {
          'draftId': draftId,
          'recipientId': recipientId,
          'recipientUsername': recipientUsername,
          'encryptedSubject': encryptedSubject,
          'encryptedContent': encryptedContent,
          'listingId': listingId,
        },
      );

  /// Ruft alle Entwürfe des Benutzers ab.
  _i2.Future<List<_i10.MessageDraft>> getAll({
    required int limit,
    required int offset,
  }) =>
      caller.callServerEndpoint<List<_i10.MessageDraft>>(
        'draft',
        'getAll',
        {
          'limit': limit,
          'offset': offset,
        },
      );

  /// Ruft einen einzelnen Entwurf ab.
  _i2.Future<_i10.MessageDraft?> getById(int draftId) =>
      caller.callServerEndpoint<_i10.MessageDraft?>(
        'draft',
        'getById',
        {'draftId': draftId},
      );

  /// Löscht einen Entwurf.
  _i2.Future<bool> delete(int draftId) => caller.callServerEndpoint<bool>(
        'draft',
        'delete',
        {'draftId': draftId},
      );

  /// Zählt die Anzahl der Entwürfe des Benutzers.
  _i2.Future<int> getCount() => caller.callServerEndpoint<int>(
        'draft',
        'getCount',
        {},
      );

  /// Ruft den Entwurf für ein bestimmtes Listing ab (falls vorhanden).
  _i2.Future<_i10.MessageDraft?> getByListing(int listingId) =>
      caller.callServerEndpoint<_i10.MessageDraft?>(
        'draft',
        'getByListing',
        {'listingId': listingId},
      );

  /// Ruft den Entwurf für einen bestimmten Empfänger ab (falls vorhanden).
  _i2.Future<_i10.MessageDraft?> getByRecipient(int recipientId) =>
      caller.callServerEndpoint<_i10.MessageDraft?>(
        'draft',
        'getByRecipient',
        {'recipientId': recipientId},
      );
}

/// Endpoint für Favoriten-Verwaltung.
/// {@category Endpoint}
class EndpointFavorite extends _i1.EndpointRef {
  EndpointFavorite(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'favorite';

  /// Fügt ein Angebot zu den Favoriten hinzu.
  _i2.Future<_i11.Favorite?> add(int listingId) =>
      caller.callServerEndpoint<_i11.Favorite?>(
        'favorite',
        'add',
        {'listingId': listingId},
      );

  /// Entfernt ein Angebot aus den Favoriten.
  _i2.Future<bool> remove(int listingId) => caller.callServerEndpoint<bool>(
        'favorite',
        'remove',
        {'listingId': listingId},
      );

  /// Prüft ob ein Angebot favorisiert ist.
  _i2.Future<bool> isFavorite(int listingId) => caller.callServerEndpoint<bool>(
        'favorite',
        'isFavorite',
        {'listingId': listingId},
      );

  /// Ruft alle Favoriten des Benutzers ab.
  _i2.Future<List<_i12.Listing>> getMyFavorites() =>
      caller.callServerEndpoint<List<_i12.Listing>>(
        'favorite',
        'getMyFavorites',
        {},
      );

  /// Zählt die Anzahl der Favoriten eines Benutzers.
  _i2.Future<int> getCount() => caller.callServerEndpoint<int>(
        'favorite',
        'getCount',
        {},
      );

  /// Prüft mehrere Listings auf Favoriten-Status (für Listen-Ansichten).
  _i2.Future<Map<int, bool>> checkMultiple(List<int> listingIds) =>
      caller.callServerEndpoint<Map<int, bool>>(
        'favorite',
        'checkMultiple',
        {'listingIds': listingIds},
      );
}

/// Endpoint für Angebote (Listings).
/// {@category Endpoint}
class EndpointListing extends _i1.EndpointRef {
  EndpointListing(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'listing';

  /// Erstellt ein neues Angebot.
  /// Verbraucht automatisch einen verfügbaren Slot.
  _i2.Future<_i12.Listing?> create({
    required int categoryId,
    required String title,
    required String description,
    required double quantity,
    required _i13.QuantityUnit quantityUnit,
    required int pricePerUnit,
    required bool acceptsPaypal,
    required bool acceptsBitcoin,
    required bool hasShipping,
    String? shippingMethod,
    int? shippingCostCents,
  }) =>
      caller.callServerEndpoint<_i12.Listing?>(
        'listing',
        'create',
        {
          'categoryId': categoryId,
          'title': title,
          'description': description,
          'quantity': quantity,
          'quantityUnit': quantityUnit,
          'pricePerUnit': pricePerUnit,
          'acceptsPaypal': acceptsPaypal,
          'acceptsBitcoin': acceptsBitcoin,
          'hasShipping': hasShipping,
          'shippingMethod': shippingMethod,
          'shippingCostCents': shippingCostCents,
        },
      );

  /// Aktualisiert ein bestehendes Angebot.
  _i2.Future<_i12.Listing?> update({
    required int id,
    int? categoryId,
    String? title,
    String? description,
    double? quantity,
    _i13.QuantityUnit? quantityUnit,
    int? pricePerUnit,
    bool? acceptsPaypal,
    bool? acceptsBitcoin,
    bool? hasShipping,
    String? shippingMethod,
    int? shippingCostCents,
  }) =>
      caller.callServerEndpoint<_i12.Listing?>(
        'listing',
        'update',
        {
          'id': id,
          'categoryId': categoryId,
          'title': title,
          'description': description,
          'quantity': quantity,
          'quantityUnit': quantityUnit,
          'pricePerUnit': pricePerUnit,
          'acceptsPaypal': acceptsPaypal,
          'acceptsBitcoin': acceptsBitcoin,
          'hasShipping': hasShipping,
          'shippingMethod': shippingMethod,
          'shippingCostCents': shippingCostCents,
        },
      );

  /// Löscht ein Angebot vollständig.
  _i2.Future<bool> delete(int id) => caller.callServerEndpoint<bool>(
        'listing',
        'delete',
        {'id': id},
      );

  /// Ruft ein einzelnes Angebot ab.
  _i2.Future<_i12.Listing?> getById(int id) =>
      caller.callServerEndpoint<_i12.Listing?>(
        'listing',
        'getById',
        {'id': id},
      );

  /// Ruft aktive Angebote ab (mit Pagination).
  _i2.Future<List<_i12.Listing>> getActive({
    int? categoryId,
    required int limit,
    required int offset,
  }) =>
      caller.callServerEndpoint<List<_i12.Listing>>(
        'listing',
        'getActive',
        {
          'categoryId': categoryId,
          'limit': limit,
          'offset': offset,
        },
      );

  /// Ruft die eigenen Angebote des Benutzers ab.
  _i2.Future<List<_i12.Listing>> getMyListings() =>
      caller.callServerEndpoint<List<_i12.Listing>>(
        'listing',
        'getMyListings',
        {},
      );

  /// Ruft Angebote eines bestimmten Benutzers ab (nur aktive).
  _i2.Future<List<_i12.Listing>> getByUser(int userId) =>
      caller.callServerEndpoint<List<_i12.Listing>>(
        'listing',
        'getByUser',
        {'userId': userId},
      );

  /// Zählt verfügbare Slots eines Benutzers.
  _i2.Future<int> getAvailableSlotCount() => caller.callServerEndpoint<int>(
        'listing',
        'getAvailableSlotCount',
        {},
      );
}

/// Endpoint für Listing-Bilder.
/// {@category Endpoint}
class EndpointListingImage extends _i1.EndpointRef {
  EndpointListingImage(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'listingImage';

  /// Lädt ein Bild für ein Listing hoch.
  /// Gibt das erstellte ListingImage-Objekt zurück.
  _i2.Future<_i14.ListingImage?> upload({
    required int listingId,
    required String originalFileName,
    required _i15.ByteData imageData,
  }) =>
      caller.callServerEndpoint<_i14.ListingImage?>(
        'listingImage',
        'upload',
        {
          'listingId': listingId,
          'originalFileName': originalFileName,
          'imageData': imageData,
        },
      );

  /// Ruft alle Bilder eines Listings ab.
  _i2.Future<List<_i14.ListingImage>> getByListing(int listingId) =>
      caller.callServerEndpoint<List<_i14.ListingImage>>(
        'listingImage',
        'getByListing',
        {'listingId': listingId},
      );

  /// Ruft die Bild-Daten ab (für Anzeige).
  _i2.Future<_i15.ByteData?> getImageData(int imageId) =>
      caller.callServerEndpoint<_i15.ByteData?>(
        'listingImage',
        'getImageData',
        {'imageId': imageId},
      );

  /// Ruft die Bild-Daten über den Dateinamen ab.
  _i2.Future<_i15.ByteData?> getImageDataByPath(String relativePath) =>
      caller.callServerEndpoint<_i15.ByteData?>(
        'listingImage',
        'getImageDataByPath',
        {'relativePath': relativePath},
      );

  /// Löscht ein Bild.
  _i2.Future<bool> delete(int imageId) => caller.callServerEndpoint<bool>(
        'listingImage',
        'delete',
        {'imageId': imageId},
      );

  /// Ändert die Reihenfolge der Bilder.
  _i2.Future<bool> reorder({
    required int listingId,
    required List<int> imageIds,
  }) =>
      caller.callServerEndpoint<bool>(
        'listingImage',
        'reorder',
        {
          'listingId': listingId,
          'imageIds': imageIds,
        },
      );

  /// Setzt das Hauptbild (sortOrder = 0).
  _i2.Future<bool> setMainImage(int imageId) => caller.callServerEndpoint<bool>(
        'listingImage',
        'setMainImage',
        {'imageId': imageId},
      );

  /// Löscht alle Bilder eines Listings.
  _i2.Future<int> deleteAllForListing(int listingId) =>
      caller.callServerEndpoint<int>(
        'listingImage',
        'deleteAllForListing',
        {'listingId': listingId},
      );
}

/// Endpoint für verschlüsselte Nachrichten.
/// {@category Endpoint}
class EndpointMessage extends _i1.EndpointRef {
  EndpointMessage(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'message';

  /// Sendet eine verschlüsselte Nachricht.
  /// Die Nachricht muss bereits client-seitig verschlüsselt sein.
  _i2.Future<_i16.Message?> send({
    required int recipientId,
    required String encryptedSubject,
    required String encryptedContent,
    int? listingId,
    int? parentMessageId,
  }) =>
      caller.callServerEndpoint<_i16.Message?>(
        'message',
        'send',
        {
          'recipientId': recipientId,
          'encryptedSubject': encryptedSubject,
          'encryptedContent': encryptedContent,
          'listingId': listingId,
          'parentMessageId': parentMessageId,
        },
      );

  /// Ruft den Posteingang des Benutzers ab (empfangene Nachrichten).
  _i2.Future<List<_i16.Message>> getInbox({
    required int limit,
    required int offset,
    required bool includeDeleted,
  }) =>
      caller.callServerEndpoint<List<_i16.Message>>(
        'message',
        'getInbox',
        {
          'limit': limit,
          'offset': offset,
          'includeDeleted': includeDeleted,
        },
      );

  /// Ruft gesendete Nachrichten des Benutzers ab.
  _i2.Future<List<_i16.Message>> getSent({
    required int limit,
    required int offset,
    required bool includeDeleted,
  }) =>
      caller.callServerEndpoint<List<_i16.Message>>(
        'message',
        'getSent',
        {
          'limit': limit,
          'offset': offset,
          'includeDeleted': includeDeleted,
        },
      );

  /// Ruft eine einzelne Nachricht ab.
  _i2.Future<_i16.Message?> getById(int messageId) =>
      caller.callServerEndpoint<_i16.Message?>(
        'message',
        'getById',
        {'messageId': messageId},
      );

  /// Markiert eine Nachricht als gelesen.
  _i2.Future<bool> markAsRead(int messageId) => caller.callServerEndpoint<bool>(
        'message',
        'markAsRead',
        {'messageId': messageId},
      );

  /// Markiert mehrere Nachrichten als gelesen.
  _i2.Future<int> markMultipleAsRead(List<int> messageIds) =>
      caller.callServerEndpoint<int>(
        'message',
        'markMultipleAsRead',
        {'messageIds': messageIds},
      );

  /// Löscht eine Nachricht (Soft-Delete).
  /// Die Nachricht wird nur für den jeweiligen Benutzer als gelöscht markiert.
  _i2.Future<bool> delete(int messageId) => caller.callServerEndpoint<bool>(
        'message',
        'delete',
        {'messageId': messageId},
      );

  /// Zählt ungelesene Nachrichten im Posteingang.
  _i2.Future<int> getUnreadCount() => caller.callServerEndpoint<int>(
        'message',
        'getUnreadCount',
        {},
      );

  /// Ruft die Konversation zwischen zwei Benutzern ab.
  _i2.Future<List<_i16.Message>> getConversation(
    int otherUserId, {
    required int limit,
    required int offset,
  }) =>
      caller.callServerEndpoint<List<_i16.Message>>(
        'message',
        'getConversation',
        {
          'otherUserId': otherUserId,
          'limit': limit,
          'offset': offset,
        },
      );

  /// Ruft den Thread einer Nachricht ab (Antworten).
  _i2.Future<List<_i16.Message>> getThread(
    int messageId, {
    required int limit,
  }) =>
      caller.callServerEndpoint<List<_i16.Message>>(
        'message',
        'getThread',
        {
          'messageId': messageId,
          'limit': limit,
        },
      );

  /// Ruft eine Liste der Konversationspartner mit der letzten Nachricht ab.
  _i2.Future<List<Map<String, dynamic>>> getConversationList(
          {required int limit}) =>
      caller.callServerEndpoint<List<Map<String, dynamic>>>(
        'message',
        'getConversationList',
        {'limit': limit},
      );

  /// Holt den Benutzernamen für eine Nachricht (für Anzeige).
  _i2.Future<String?> getSenderUsername(int messageId) =>
      caller.callServerEndpoint<String?>(
        'message',
        'getSenderUsername',
        {'messageId': messageId},
      );
}

/// Endpoint for managing news articles.
/// Admin can create/edit/delete, users can read published news.
/// {@category Endpoint}
class EndpointNews extends _i1.EndpointRef {
  EndpointNews(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'news';

  /// Get all published and non-expired news (public).
  _i2.Future<List<_i17.News>> getPublished() =>
      caller.callServerEndpoint<List<_i17.News>>(
        'news',
        'getPublished',
        {},
      );

  /// Get all news including unpublished (admin only).
  _i2.Future<List<_i17.News>> getAll() =>
      caller.callServerEndpoint<List<_i17.News>>(
        'news',
        'getAll',
        {},
      );

  /// Get a single news article by ID.
  _i2.Future<_i17.News?> getById(int id) =>
      caller.callServerEndpoint<_i17.News?>(
        'news',
        'getById',
        {'id': id},
      );

  /// Create a new news article (admin only).
  _i2.Future<_i17.News?> create({
    required String title,
    required String content,
    required bool publish,
    int? lifetimeDays,
  }) =>
      caller.callServerEndpoint<_i17.News?>(
        'news',
        'create',
        {
          'title': title,
          'content': content,
          'publish': publish,
          'lifetimeDays': lifetimeDays,
        },
      );

  /// Update a news article (admin only).
  _i2.Future<_i17.News?> update({
    required int id,
    required String title,
    required String content,
    required bool isPublished,
    DateTime? expiresAt,
  }) =>
      caller.callServerEndpoint<_i17.News?>(
        'news',
        'update',
        {
          'id': id,
          'title': title,
          'content': content,
          'isPublished': isPublished,
          'expiresAt': expiresAt,
        },
      );

  /// Delete a news article (admin only).
  _i2.Future<bool> delete(int id) => caller.callServerEndpoint<bool>(
        'news',
        'delete',
        {'id': id},
      );

  /// Delete all expired news (called by cron job).
  /// Returns the number of deleted articles.
  _i2.Future<int> deleteExpired() => caller.callServerEndpoint<int>(
        'news',
        'deleteExpired',
        {},
      );
}

/// Endpoint für Zahlungsverarbeitung.
/// {@category Endpoint}
class EndpointPayment extends _i1.EndpointRef {
  EndpointPayment(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'payment';

  /// Verarbeitet eine PayPal IPN-Nachricht.
  /// Diese Methode wird von PayPal aufgerufen (kein Auth erforderlich).
  _i2.Future<String> handlePayPalIpn(Map<String, String> ipnData) =>
      caller.callServerEndpoint<String>(
        'payment',
        'handlePayPalIpn',
        {'ipnData': ipnData},
      );

  /// Aktualisiert die Bitcoin-Transaktions-ID für eine Bestellung.
  /// Der Benutzer gibt die TX-Hash nach der Zahlung ein.
  _i2.Future<bool> setBitcoinTransactionId({
    required int orderId,
    required String transactionId,
  }) =>
      caller.callServerEndpoint<bool>(
        'payment',
        'setBitcoinTransactionId',
        {
          'orderId': orderId,
          'transactionId': transactionId,
        },
      );

  /// Prüft ausstehende Bitcoin-Zahlungen (Admin-Funktion).
  _i2.Future<int> checkPendingBitcoinPayments() =>
      caller.callServerEndpoint<int>(
        'payment',
        'checkPendingBitcoinPayments',
        {},
      );

  /// Holt Zahlungsinformationen für eine Bestellung.
  _i2.Future<Map<String, String>> getPaymentInfo(int orderId) =>
      caller.callServerEndpoint<Map<String, String>>(
        'payment',
        'getPaymentInfo',
        {'orderId': orderId},
      );

  /// Manuelle Zahlungsbestätigung (Admin-Funktion).
  /// Für Fälle, in denen die automatische Verarbeitung fehlschlägt.
  _i2.Future<bool> confirmPaymentManually({
    required int orderId,
    String? transactionId,
  }) =>
      caller.callServerEndpoint<bool>(
        'payment',
        'confirmPaymentManually',
        {
          'orderId': orderId,
          'transactionId': transactionId,
        },
      );

  /// Holt den aktuellen BTC/USD-Kurs.
  _i2.Future<double?> getBtcUsdRate() => caller.callServerEndpoint<double?>(
        'payment',
        'getBtcUsdRate',
        {},
      );
}

/// Endpoint für PGP Key Management.
/// {@category Endpoint}
class EndpointPgpKey extends _i1.EndpointRef {
  EndpointPgpKey(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'pgpKey';

  /// Lädt den Public Key eines Benutzers zum Server hoch.
  /// Validiert das Key-Format und extrahiert Metadaten.
  _i2.Future<_i18.UserPublicKey?> uploadPublicKey(
    String publicKeyArmored,
    String keyIdentity,
    String fingerprint,
    String algorithm,
    int keySize,
  ) =>
      caller.callServerEndpoint<_i18.UserPublicKey?>(
        'pgpKey',
        'uploadPublicKey',
        {
          'publicKeyArmored': publicKeyArmored,
          'keyIdentity': keyIdentity,
          'fingerprint': fingerprint,
          'algorithm': algorithm,
          'keySize': keySize,
        },
      );

  /// Ruft den aktiven Public Key des eingeloggten Benutzers ab.
  _i2.Future<_i18.UserPublicKey?> getMyPublicKey() =>
      caller.callServerEndpoint<_i18.UserPublicKey?>(
        'pgpKey',
        'getMyPublicKey',
        {},
      );

  /// Ruft den Public Key eines Benutzers per User-ID ab.
  _i2.Future<_i18.UserPublicKey?> getPublicKey(int userId) =>
      caller.callServerEndpoint<_i18.UserPublicKey?>(
        'pgpKey',
        'getPublicKey',
        {'userId': userId},
      );

  /// Ruft den Public Key eines Benutzers per Username ab.
  _i2.Future<_i18.UserPublicKey?> getPublicKeyByUsername(String username) =>
      caller.callServerEndpoint<_i18.UserPublicKey?>(
        'pgpKey',
        'getPublicKeyByUsername',
        {'username': username},
      );

  /// Prüft ob ein Benutzer einen aktiven Public Key hat.
  _i2.Future<bool> hasPublicKey(int? userId) => caller.callServerEndpoint<bool>(
        'pgpKey',
        'hasPublicKey',
        {'userId': userId},
      );

  /// Deaktiviert den aktuellen Key des Benutzers.
  _i2.Future<bool> deactivateKey() => caller.callServerEndpoint<bool>(
        'pgpKey',
        'deactivateKey',
        {},
      );

  /// Ruft Key-Metadaten ab (ohne den eigentlichen Key).
  _i2.Future<Map<String, dynamic>?> getKeyMetadata() =>
      caller.callServerEndpoint<Map<String, dynamic>?>(
        'pgpKey',
        'getKeyMetadata',
        {},
      );

  /// Lädt ein verschlüsseltes Private Key Backup hoch.
  /// WARNUNG: Der Server speichert nur den verschlüsselten Key.
  /// Die Entschlüsselung erfolgt ausschließlich auf dem Client.
  _i2.Future<_i19.EncryptedKeyBackup?> uploadEncryptedBackup(
    String encryptedPrivateKey,
    String fingerprint,
    String encryptionSalt,
    String kdfParams,
  ) =>
      caller.callServerEndpoint<_i19.EncryptedKeyBackup?>(
        'pgpKey',
        'uploadEncryptedBackup',
        {
          'encryptedPrivateKey': encryptedPrivateKey,
          'fingerprint': fingerprint,
          'encryptionSalt': encryptionSalt,
          'kdfParams': kdfParams,
        },
      );

  /// Lädt ein verschlüsseltes Private Key Backup herunter.
  _i2.Future<_i19.EncryptedKeyBackup?> downloadEncryptedBackup(
          String fingerprint) =>
      caller.callServerEndpoint<_i19.EncryptedKeyBackup?>(
        'pgpKey',
        'downloadEncryptedBackup',
        {'fingerprint': fingerprint},
      );

  /// Listet alle aktiven Backups des Benutzers auf.
  _i2.Future<List<_i19.EncryptedKeyBackup>> listBackups() =>
      caller.callServerEndpoint<List<_i19.EncryptedKeyBackup>>(
        'pgpKey',
        'listBackups',
        {},
      );

  /// Löscht ein Backup.
  _i2.Future<bool> deleteBackup(int backupId) =>
      caller.callServerEndpoint<bool>(
        'pgpKey',
        'deleteBackup',
        {'backupId': backupId},
      );
}

/// Endpoint für Bewertungen nach abgeschlossenen Transaktionen.
/// {@category Endpoint}
class EndpointRating extends _i1.EndpointRef {
  EndpointRating(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'rating';

  /// Gibt eine Bewertung ab (nur nach abgeschlossener Transaktion).
  /// Jeder Benutzer kann nur einmal pro Transaktion bewerten.
  /// Bewertung nur innerhalb von 14 Tagen nach Abschluss möglich.
  _i2.Future<_i20.Rating> submitRating({
    required int transactionId,
    required _i21.RatingValue rating,
    String? comment,
  }) =>
      caller.callServerEndpoint<_i20.Rating>(
        'rating',
        'submitRating',
        {
          'transactionId': transactionId,
          'rating': rating,
          'comment': comment,
        },
      );

  /// Ruft eine Bewertung per ID ab.
  _i2.Future<_i20.Rating?> getById(int ratingId) =>
      caller.callServerEndpoint<_i20.Rating?>(
        'rating',
        'getById',
        {'ratingId': ratingId},
      );

  /// Ruft alle Bewertungen für eine Transaktion ab.
  _i2.Future<List<_i20.Rating>> getByTransaction(int transactionId) =>
      caller.callServerEndpoint<List<_i20.Rating>>(
        'rating',
        'getByTransaction',
        {'transactionId': transactionId},
      );

  /// Ruft alle Bewertungen für einen Benutzer ab (empfangen).
  _i2.Future<List<_i20.Rating>> getByUser(
    int userId, {
    required int limit,
    required int offset,
  }) =>
      caller.callServerEndpoint<List<_i20.Rating>>(
        'rating',
        'getByUser',
        {
          'userId': userId,
          'limit': limit,
          'offset': offset,
        },
      );

  /// Ruft alle eigenen abgegebenen Bewertungen ab.
  _i2.Future<List<_i20.Rating>> getMyGivenRatings({
    required int limit,
    required int offset,
  }) =>
      caller.callServerEndpoint<List<_i20.Rating>>(
        'rating',
        'getMyGivenRatings',
        {
          'limit': limit,
          'offset': offset,
        },
      );

  /// Ruft alle eigenen erhaltenen Bewertungen ab.
  _i2.Future<List<_i20.Rating>> getMyReceivedRatings({
    required int limit,
    required int offset,
  }) =>
      caller.callServerEndpoint<List<_i20.Rating>>(
        'rating',
        'getMyReceivedRatings',
        {
          'limit': limit,
          'offset': offset,
        },
      );

  /// Prüft ob der Benutzer eine Bewertung für eine Transaktion abgeben kann.
  _i2.Future<bool> canRateTransaction(int transactionId) =>
      caller.callServerEndpoint<bool>(
        'rating',
        'canRateTransaction',
        {'transactionId': transactionId},
      );

  /// Gibt die Bewertungsstatistiken für einen Benutzer zurück.
  _i2.Future<_i22.RatingStats> getUserStats(int userId) =>
      caller.callServerEndpoint<_i22.RatingStats>(
        'rating',
        'getUserStats',
        {'userId': userId},
      );

  /// Erstellt automatische positive Bewertungen für abgelaufene Transaktionen.
  /// Wird vom Cron-Job aufgerufen (nur für Admins).
  _i2.Future<int> createAutomaticRatings() => caller.callServerEndpoint<int>(
        'rating',
        'createAutomaticRatings',
        {},
      );

  /// Gibt die Transaktionen zurück, für die noch eine Bewertung aussteht.
  _i2.Future<List<_i23.Transaction>> getPendingRatingTransactions() =>
      caller.callServerEndpoint<List<_i23.Transaction>>(
        'rating',
        'getPendingRatingTransactions',
        {},
      );

  /// Zählt die ausstehenden Bewertungen für den Benutzer.
  _i2.Future<int> getPendingRatingCount() => caller.callServerEndpoint<int>(
        'rating',
        'getPendingRatingCount',
        {},
      );
}

/// Endpoint for reporting listings and users
/// {@category Endpoint}
class EndpointReport extends _i1.EndpointRef {
  EndpointReport(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'report';

  /// Create a report for a listing
  _i2.Future<_i24.Report> createListingReport(
    int listingId,
    _i25.ReportReason reason,
    String? details,
  ) =>
      caller.callServerEndpoint<_i24.Report>(
        'report',
        'createListingReport',
        {
          'listingId': listingId,
          'reason': reason,
          'details': details,
        },
      );

  /// Create a report for a user
  _i2.Future<_i24.Report> createUserReport(
    int userId,
    _i25.ReportReason reason,
    String? details,
  ) =>
      caller.callServerEndpoint<_i24.Report>(
        'report',
        'createUserReport',
        {
          'userId': userId,
          'reason': reason,
          'details': details,
        },
      );

  /// Get reports created by the current user
  _i2.Future<List<_i24.Report>> getMyReports() =>
      caller.callServerEndpoint<List<_i24.Report>>(
        'report',
        'getMyReports',
        {},
      );

  /// Get a report by ID
  /// Only accessible by the reporter, assigned moderator, or admins
  _i2.Future<_i24.Report?> getById(int reportId) =>
      caller.callServerEndpoint<_i24.Report?>(
        'report',
        'getById',
        {'reportId': reportId},
      );

  /// Get count of reports created by current user
  _i2.Future<int> getMyReportCount() => caller.callServerEndpoint<int>(
        'report',
        'getMyReportCount',
        {},
      );

  /// Delete a report (only by the reporter if status is still 'open')
  _i2.Future<bool> deleteReport(int reportId) =>
      caller.callServerEndpoint<bool>(
        'report',
        'deleteReport',
        {'reportId': reportId},
      );

  /// Get all open reports (for moderators/admins)
  _i2.Future<List<_i24.Report>> getOpenReports({
    _i26.ReportTargetType? targetType,
    int? limit,
    int? offset,
  }) =>
      caller.callServerEndpoint<List<_i24.Report>>(
        'report',
        'getOpenReports',
        {
          'targetType': targetType,
          'limit': limit,
          'offset': offset,
        },
      );

  /// Get all reports with any status (for moderators/admins)
  _i2.Future<List<_i24.Report>> getAllReports({
    _i26.ReportTargetType? targetType,
    _i27.ReportStatus? status,
    int? limit,
    int? offset,
  }) =>
      caller.callServerEndpoint<List<_i24.Report>>(
        'report',
        'getAllReports',
        {
          'targetType': targetType,
          'status': status,
          'limit': limit,
          'offset': offset,
        },
      );

  /// Get count of open reports
  _i2.Future<int> getOpenCount({_i26.ReportTargetType? targetType}) =>
      caller.callServerEndpoint<int>(
        'report',
        'getOpenCount',
        {'targetType': targetType},
      );

  /// Assign report to current moderator
  _i2.Future<_i24.Report> assignToMe(int reportId) =>
      caller.callServerEndpoint<_i24.Report>(
        'report',
        'assignToMe',
        {'reportId': reportId},
      );

  /// Update report status
  _i2.Future<_i24.Report> updateStatus(
    int reportId,
    _i27.ReportStatus newStatus,
  ) =>
      caller.callServerEndpoint<_i24.Report>(
        'report',
        'updateStatus',
        {
          'reportId': reportId,
          'newStatus': newStatus,
        },
      );

  /// Add or update moderator note
  _i2.Future<_i24.Report> addModeratorNote(
    int reportId,
    String note,
  ) =>
      caller.callServerEndpoint<_i24.Report>(
        'report',
        'addModeratorNote',
        {
          'reportId': reportId,
          'note': note,
        },
      );

  /// Deactivate a reported listing (moderator action)
  _i2.Future<bool> deactivateReportedListing(int reportId) =>
      caller.callServerEndpoint<bool>(
        'report',
        'deactivateReportedListing',
        {'reportId': reportId},
      );

  /// Gets the current authenticated user from the database.
  _i2.Future<_i28.User?> getAuthenticatedUser() =>
      caller.callServerEndpoint<_i28.User?>(
        'report',
        'getAuthenticatedUser',
        {},
      );

  /// Throws an exception if the user is not authenticated.
  _i2.Future<_i28.User> requireUser() => caller.callServerEndpoint<_i28.User>(
        'report',
        'requireUser',
        {},
      );

  /// Throws an exception if the user is not an admin.
  _i2.Future<_i28.User> requireAdmin() => caller.callServerEndpoint<_i28.User>(
        'report',
        'requireAdmin',
        {},
      );

  /// Throws an exception if the user is not a moderator or admin.
  _i2.Future<_i28.User> requireModerator() =>
      caller.callServerEndpoint<_i28.User>(
        'report',
        'requireModerator',
        {},
      );

  /// Checks if the current user has admin role.
  _i2.Future<bool> isAdmin() => caller.callServerEndpoint<bool>(
        'report',
        'isAdmin',
        {},
      );

  /// Checks if the current user has moderator or admin role.
  _i2.Future<bool> isModerator() => caller.callServerEndpoint<bool>(
        'report',
        'isModerator',
        {},
      );
}

/// Endpoint für die Suche nach Angeboten.
/// {@category Endpoint}
class EndpointSearch extends _i1.EndpointRef {
  EndpointSearch(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'search';

  /// Sucht nach Angeboten mit optionalen Filtern.
  ///
  /// [query] - Suchbegriff (durchsucht Titel und Beschreibung)
  /// [categoryId] - Optional: Filtert nach Hauptkategorie (inkl. Subkategorien)
  /// [subcategoryId] - Optional: Filtert nach spezifischer Subkategorie
  /// [acceptsPaypal] - Optional: Nur PayPal-Angebote
  /// [acceptsBitcoin] - Optional: Nur Bitcoin-Angebote
  /// [page] - Seitennummer (0-basiert)
  /// [pageSize] - Anzahl pro Seite (Standard: 25)
  _i2.Future<_i29.SearchResult> search({
    String? query,
    int? categoryId,
    int? subcategoryId,
    bool? acceptsPaypal,
    bool? acceptsBitcoin,
    required int page,
    required int pageSize,
  }) =>
      caller.callServerEndpoint<_i29.SearchResult>(
        'search',
        'search',
        {
          'query': query,
          'categoryId': categoryId,
          'subcategoryId': subcategoryId,
          'acceptsPaypal': acceptsPaypal,
          'acceptsBitcoin': acceptsBitcoin,
          'page': page,
          'pageSize': pageSize,
        },
      );

  /// Schnellsuche - nur Titel, optimiert für Autocomplete.
  _i2.Future<List<_i12.Listing>> quickSearch(
    String query, {
    required int limit,
  }) =>
      caller.callServerEndpoint<List<_i12.Listing>>(
        'search',
        'quickSearch',
        {
          'query': query,
          'limit': limit,
        },
      );

  /// Zählt die Gesamtanzahl aktiver Listings.
  _i2.Future<int> countActive() => caller.callServerEndpoint<int>(
        'search',
        'countActive',
        {},
      );
}

/// Endpoint for managing application settings.
/// Most operations require admin privileges.
/// {@category Endpoint}
class EndpointSettings extends _i1.EndpointRef {
  EndpointSettings(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'settings';

  /// Get a setting value by key (admin only for sensitive settings).
  _i2.Future<String?> get(String key) => caller.callServerEndpoint<String?>(
        'settings',
        'get',
        {'key': key},
      );

  /// Get multiple settings by keys.
  _i2.Future<Map<String, String>> getMultiple(List<String> keys) =>
      caller.callServerEndpoint<Map<String, String>>(
        'settings',
        'getMultiple',
        {'keys': keys},
      );

  /// Set a setting value (admin only).
  _i2.Future<bool> set(
    String key,
    String value, {
    String? description,
  }) =>
      caller.callServerEndpoint<bool>(
        'settings',
        'set',
        {
          'key': key,
          'value': value,
          'description': description,
        },
      );

  /// Delete a setting (admin only).
  _i2.Future<bool> delete(String key) => caller.callServerEndpoint<bool>(
        'settings',
        'delete',
        {'key': key},
      );

  /// Get all payment settings (admin only).
  _i2.Future<Map<String, String>> getPaymentSettings() =>
      caller.callServerEndpoint<Map<String, String>>(
        'settings',
        'getPaymentSettings',
        {},
      );

  /// Update payment settings (admin only).
  _i2.Future<bool> updatePaymentSettings({
    String? paypalEmail,
    String? bitcoinWallet,
    bool? paypalEnabled,
    bool? bitcoinEnabled,
  }) =>
      caller.callServerEndpoint<bool>(
        'settings',
        'updatePaymentSettings',
        {
          'paypalEmail': paypalEmail,
          'bitcoinWallet': bitcoinWallet,
          'paypalEnabled': paypalEnabled,
          'bitcoinEnabled': bitcoinEnabled,
        },
      );
}

/// Endpoint für Slot-Bestellungen (Kaufvorgänge).
/// {@category Endpoint}
class EndpointSlotOrder extends _i1.EndpointRef {
  EndpointSlotOrder(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'slotOrder';

  /// Erstellt eine neue Bestellung für einen Slot.
  _i2.Future<_i30.SlotOrder?> create({
    required int slotVariantId,
    required _i31.PaymentMethod paymentMethod,
  }) =>
      caller.callServerEndpoint<_i30.SlotOrder?>(
        'slotOrder',
        'create',
        {
          'slotVariantId': slotVariantId,
          'paymentMethod': paymentMethod,
        },
      );

  /// Ruft alle Bestellungen des aktuellen Benutzers ab.
  _i2.Future<List<_i30.SlotOrder>> getMyOrders() =>
      caller.callServerEndpoint<List<_i30.SlotOrder>>(
        'slotOrder',
        'getMyOrders',
        {},
      );

  /// Ruft ausstehende Bestellungen des Benutzers ab.
  _i2.Future<List<_i30.SlotOrder>> getPendingOrders() =>
      caller.callServerEndpoint<List<_i30.SlotOrder>>(
        'slotOrder',
        'getPendingOrders',
        {},
      );

  /// Ruft eine einzelne Bestellung ab.
  _i2.Future<_i30.SlotOrder?> getById(int id) =>
      caller.callServerEndpoint<_i30.SlotOrder?>(
        'slotOrder',
        'getById',
        {'id': id},
      );

  /// Storniert eine Bestellung (nur wenn noch pending).
  _i2.Future<bool> cancel(int id) => caller.callServerEndpoint<bool>(
        'slotOrder',
        'cancel',
        {'id': id},
      );

  /// Markiert eine Bestellung als bezahlt und aktiviert den Slot.
  /// Diese Methode kann nur von Admins aufgerufen werden.
  /// In der Produktion wird dies automatisch durch Zahlungs-Webhooks aufgerufen.
  _i2.Future<_i30.SlotOrder?> markAsPaid({
    required int orderId,
    String? transactionId,
  }) =>
      caller.callServerEndpoint<_i30.SlotOrder?>(
        'slotOrder',
        'markAsPaid',
        {
          'orderId': orderId,
          'transactionId': transactionId,
        },
      );

  /// Admin: Ruft alle Bestellungen ab.
  _i2.Future<List<_i30.SlotOrder>> getAllOrders() =>
      caller.callServerEndpoint<List<_i30.SlotOrder>>(
        'slotOrder',
        'getAllOrders',
        {},
      );

  /// Admin: Ruft alle ausstehenden Bestellungen ab.
  _i2.Future<List<_i30.SlotOrder>> getAllPendingOrders() =>
      caller.callServerEndpoint<List<_i30.SlotOrder>>(
        'slotOrder',
        'getAllPendingOrders',
        {},
      );

  /// Admin: Ruft einen Benutzer zu einer Bestellung ab.
  _i2.Future<_i28.User?> getOrderUser(int orderId) =>
      caller.callServerEndpoint<_i28.User?>(
        'slotOrder',
        'getOrderUser',
        {'orderId': orderId},
      );

  /// Admin: Ruft die Slot-Variante zu einer Bestellung ab.
  _i2.Future<_i32.SlotVariant?> getOrderVariant(int orderId) =>
      caller.callServerEndpoint<_i32.SlotVariant?>(
        'slotOrder',
        'getOrderVariant',
        {'orderId': orderId},
      );

  /// Läuft abgelaufene ausstehende Bestellungen ab (älter als 24 Stunden).
  _i2.Future<int> expireOldOrders() => caller.callServerEndpoint<int>(
        'slotOrder',
        'expireOldOrders',
        {},
      );
}

/// Endpoint for managing slot variants.
/// Most operations require admin privileges.
/// {@category Endpoint}
class EndpointSlotVariant extends _i1.EndpointRef {
  EndpointSlotVariant(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'slotVariant';

  /// Get all slot variants (admin only).
  _i2.Future<List<_i32.SlotVariant>> getAll() =>
      caller.callServerEndpoint<List<_i32.SlotVariant>>(
        'slotVariant',
        'getAll',
        {},
      );

  /// Get only active slot variants (public).
  /// Free promotional slots are excluded from this list.
  _i2.Future<List<_i32.SlotVariant>> getActive() =>
      caller.callServerEndpoint<List<_i32.SlotVariant>>(
        'slotVariant',
        'getActive',
        {},
      );

  /// Get all free slot variants (admin only).
  /// These are used for promotional purposes.
  _i2.Future<List<_i32.SlotVariant>> getFreeVariants() =>
      caller.callServerEndpoint<List<_i32.SlotVariant>>(
        'slotVariant',
        'getFreeVariants',
        {},
      );

  /// Get a single slot variant by ID (public).
  _i2.Future<_i32.SlotVariant?> getById(int id) =>
      caller.callServerEndpoint<_i32.SlotVariant?>(
        'slotVariant',
        'getById',
        {'id': id},
      );

  /// Create a new slot variant (admin only).
  _i2.Future<_i32.SlotVariant?> create({
    required String name,
    String? description,
    required int priceUsdCents,
    required int durationDays,
    required bool allowPaypal,
    required bool allowBitcoin,
    required int sortOrder,
    required bool isFree,
  }) =>
      caller.callServerEndpoint<_i32.SlotVariant?>(
        'slotVariant',
        'create',
        {
          'name': name,
          'description': description,
          'priceUsdCents': priceUsdCents,
          'durationDays': durationDays,
          'allowPaypal': allowPaypal,
          'allowBitcoin': allowBitcoin,
          'sortOrder': sortOrder,
          'isFree': isFree,
        },
      );

  /// Update a slot variant (admin only).
  _i2.Future<_i32.SlotVariant?> update({
    required int id,
    required String name,
    String? description,
    required int priceUsdCents,
    required int durationDays,
    required bool allowPaypal,
    required bool allowBitcoin,
    required bool isActive,
    required bool isFree,
    required int sortOrder,
  }) =>
      caller.callServerEndpoint<_i32.SlotVariant?>(
        'slotVariant',
        'update',
        {
          'id': id,
          'name': name,
          'description': description,
          'priceUsdCents': priceUsdCents,
          'durationDays': durationDays,
          'allowPaypal': allowPaypal,
          'allowBitcoin': allowBitcoin,
          'isActive': isActive,
          'isFree': isFree,
          'sortOrder': sortOrder,
        },
      );

  /// Delete a slot variant (admin only).
  _i2.Future<bool> delete(int id) => caller.callServerEndpoint<bool>(
        'slotVariant',
        'delete',
        {'id': id},
      );
}

/// Endpoint für Transaktionen (Handelsablauf).
/// {@category Endpoint}
class EndpointTransaction extends _i1.EndpointRef {
  EndpointTransaction(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'transaction';

  /// Startet eine neue Transaktion (Käufer initiiert).
  _i2.Future<_i23.Transaction> create({
    required int listingId,
    required double quantity,
    String? buyerNote,
  }) =>
      caller.callServerEndpoint<_i23.Transaction>(
        'transaction',
        'create',
        {
          'listingId': listingId,
          'quantity': quantity,
          'buyerNote': buyerNote,
        },
      );

  /// Ruft eine Transaktion per ID ab.
  _i2.Future<_i23.Transaction?> getById(int transactionId) =>
      caller.callServerEndpoint<_i23.Transaction?>(
        'transaction',
        'getById',
        {'transactionId': transactionId},
      );

  /// Ruft alle Transaktionen des Benutzers ab.
  _i2.Future<List<_i23.Transaction>> getMyTransactions({
    _i33.TransactionStatus? status,
    required bool asBuyer,
    required bool asSeller,
    required int limit,
    required int offset,
  }) =>
      caller.callServerEndpoint<List<_i23.Transaction>>(
        'transaction',
        'getMyTransactions',
        {
          'status': status,
          'asBuyer': asBuyer,
          'asSeller': asSeller,
          'limit': limit,
          'offset': offset,
        },
      );

  /// Markiert eine Transaktion als versendet (nur Verkäufer).
  _i2.Future<_i23.Transaction> markAsShipped(int transactionId) =>
      caller.callServerEndpoint<_i23.Transaction>(
        'transaction',
        'markAsShipped',
        {'transactionId': transactionId},
      );

  /// Markiert eine Transaktion als bezahlt (nur Käufer).
  _i2.Future<_i23.Transaction> markAsPaid(int transactionId) =>
      caller.callServerEndpoint<_i23.Transaction>(
        'transaction',
        'markAsPaid',
        {'transactionId': transactionId},
      );

  /// Markiert eine Transaktion als erhalten (nur Käufer).
  /// Schließt die Transaktion ab.
  _i2.Future<_i23.Transaction> markAsReceived(int transactionId) =>
      caller.callServerEndpoint<_i23.Transaction>(
        'transaction',
        'markAsReceived',
        {'transactionId': transactionId},
      );

  /// Bricht eine Transaktion ab (nur wenn Status = open).
  _i2.Future<_i23.Transaction> cancel(int transactionId) =>
      caller.callServerEndpoint<_i23.Transaction>(
        'transaction',
        'cancel',
        {'transactionId': transactionId},
      );

  /// Öffnet eine Reklamation für eine Transaktion.
  _i2.Future<_i8.Dispute> openDispute(
    int transactionId, {
    required String reason,
  }) =>
      caller.callServerEndpoint<_i8.Dispute>(
        'transaction',
        'openDispute',
        {
          'transactionId': transactionId,
          'reason': reason,
        },
      );

  /// Zählt offene Transaktionen des Benutzers.
  _i2.Future<int> getOpenCount() => caller.callServerEndpoint<int>(
        'transaction',
        'getOpenCount',
        {},
      );

  /// Zählt abgeschlossene Transaktionen eines Benutzers.
  _i2.Future<int> getCompletedCount(int userId) =>
      caller.callServerEndpoint<int>(
        'transaction',
        'getCompletedCount',
        {'userId': userId},
      );

  /// Automatischer Abschluss von Transaktionen (für Cron-Job).
  /// Gibt die Anzahl der abgeschlossenen Transaktionen zurück.
  /// Nur für Admins zugänglich.
  _i2.Future<int> autoCompleteExpired() => caller.callServerEndpoint<int>(
        'transaction',
        'autoCompleteExpired',
        {},
      );

  /// Ruft Transaktionen ab, die bald automatisch abgeschlossen werden.
  /// Für Benachrichtigungen (3 Tage vor Abschluss).
  _i2.Future<List<_i23.Transaction>> getUpcomingAutoComplete(
          {required int daysAhead}) =>
      caller.callServerEndpoint<List<_i23.Transaction>>(
        'transaction',
        'getUpcomingAutoComplete',
        {'daysAhead': daysAhead},
      );

  /// Ruft die Zahlungsinformationen des Verkäufers für eine Transaktion ab.
  /// Nur für den Käufer zugänglich.
  _i2.Future<_i34.UserPaymentInfo?> getSellerPaymentInfo(int transactionId) =>
      caller.callServerEndpoint<_i34.UserPaymentInfo?>(
        'transaction',
        'getSellerPaymentInfo',
        {'transactionId': transactionId},
      );
}

/// Endpoint for user management (admin only)
/// {@category Endpoint}
class EndpointUserManagement extends _i1.EndpointRef {
  EndpointUserManagement(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'userManagement';

  /// Get all users with optional filters
  _i2.Future<List<_i28.User>> getAllUsers({
    String? searchQuery,
    _i35.UserRole? role,
    bool? isBanned,
    int? limit,
    int? offset,
  }) =>
      caller.callServerEndpoint<List<_i28.User>>(
        'userManagement',
        'getAllUsers',
        {
          'searchQuery': searchQuery,
          'role': role,
          'isBanned': isBanned,
          'limit': limit,
          'offset': offset,
        },
      );

  /// Get a user by ID
  _i2.Future<_i28.User?> getUserById(int userId) =>
      caller.callServerEndpoint<_i28.User?>(
        'userManagement',
        'getUserById',
        {'userId': userId},
      );

  /// Update user role
  _i2.Future<_i28.User> updateUserRole(
    int userId,
    _i35.UserRole newRole,
  ) =>
      caller.callServerEndpoint<_i28.User>(
        'userManagement',
        'updateUserRole',
        {
          'userId': userId,
          'newRole': newRole,
        },
      );

  /// Ban a user
  _i2.Future<_i28.User> banUser(
    int userId,
    String reason,
  ) =>
      caller.callServerEndpoint<_i28.User>(
        'userManagement',
        'banUser',
        {
          'userId': userId,
          'reason': reason,
        },
      );

  /// Unban a user
  _i2.Future<_i28.User> unbanUser(
    int userId,
    String? reason,
  ) =>
      caller.callServerEndpoint<_i28.User>(
        'userManagement',
        'unbanUser',
        {
          'userId': userId,
          'reason': reason,
        },
      );

  /// Get all banned users
  _i2.Future<List<_i28.User>> getBannedUsers() =>
      caller.callServerEndpoint<List<_i28.User>>(
        'userManagement',
        'getBannedUsers',
        {},
      );

  /// Get ban history for a user
  _i2.Future<List<_i36.UserBanLog>> getBanHistory(int userId) =>
      caller.callServerEndpoint<List<_i36.UserBanLog>>(
        'userManagement',
        'getBanHistory',
        {'userId': userId},
      );

  /// Get count of users by role
  _i2.Future<Map<String, int>> getUserCountByRole() =>
      caller.callServerEndpoint<Map<String, int>>(
        'userManagement',
        'getUserCountByRole',
        {},
      );

  /// Get count of total users
  _i2.Future<int> getTotalUserCount() => caller.callServerEndpoint<int>(
        'userManagement',
        'getTotalUserCount',
        {},
      );

  /// Gets the current authenticated user from the database.
  _i2.Future<_i28.User?> getAuthenticatedUser() =>
      caller.callServerEndpoint<_i28.User?>(
        'userManagement',
        'getAuthenticatedUser',
        {},
      );

  /// Throws an exception if the user is not authenticated.
  _i2.Future<_i28.User> requireUser() => caller.callServerEndpoint<_i28.User>(
        'userManagement',
        'requireUser',
        {},
      );

  /// Throws an exception if the user is not an admin.
  _i2.Future<_i28.User> requireAdmin() => caller.callServerEndpoint<_i28.User>(
        'userManagement',
        'requireAdmin',
        {},
      );

  /// Throws an exception if the user is not a moderator or admin.
  _i2.Future<_i28.User> requireModerator() =>
      caller.callServerEndpoint<_i28.User>(
        'userManagement',
        'requireModerator',
        {},
      );

  /// Checks if the current user has admin role.
  _i2.Future<bool> isAdmin() => caller.callServerEndpoint<bool>(
        'userManagement',
        'isAdmin',
        {},
      );

  /// Checks if the current user has moderator or admin role.
  _i2.Future<bool> isModerator() => caller.callServerEndpoint<bool>(
        'userManagement',
        'isModerator',
        {},
      );
}

/// Endpoint für öffentliche Benutzerprofile und Zahlungsinformationen.
/// {@category Endpoint}
class EndpointUserProfile extends _i1.EndpointRef {
  EndpointUserProfile(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'userProfile';

  /// Ruft das öffentliche Profil eines Benutzers ab.
  _i2.Future<_i37.UserProfile?> getProfile(int userId) =>
      caller.callServerEndpoint<_i37.UserProfile?>(
        'userProfile',
        'getProfile',
        {'userId': userId},
      );

  /// Ruft die aktiven Angebote eines Benutzers ab.
  _i2.Future<List<_i12.Listing>> getUserListings(
    int userId, {
    required int limit,
    required int offset,
  }) =>
      caller.callServerEndpoint<List<_i12.Listing>>(
        'userProfile',
        'getUserListings',
        {
          'userId': userId,
          'limit': limit,
          'offset': offset,
        },
      );

  /// Ruft die eigenen Zahlungsinformationen ab.
  _i2.Future<_i34.UserPaymentInfo?> getMyPaymentInfo() =>
      caller.callServerEndpoint<_i34.UserPaymentInfo?>(
        'userProfile',
        'getMyPaymentInfo',
        {},
      );

  /// Speichert die eigenen Zahlungsinformationen.
  _i2.Future<_i34.UserPaymentInfo> updateMyPaymentInfo({
    String? paypalAddress,
    String? bitcoinWallet,
  }) =>
      caller.callServerEndpoint<_i34.UserPaymentInfo>(
        'userProfile',
        'updateMyPaymentInfo',
        {
          'paypalAddress': paypalAddress,
          'bitcoinWallet': bitcoinWallet,
        },
      );

  /// Holt den Benutzernamen für eine User-ID.
  _i2.Future<String?> getUsername(int userId) =>
      caller.callServerEndpoint<String?>(
        'userProfile',
        'getUsername',
        {'userId': userId},
      );

  /// Prüft ob zwischen dem eingeloggten Benutzer und einem anderen Kontakt besteht.
  _i2.Future<bool> hasContact(int otherUserId) =>
      caller.callServerEndpoint<bool>(
        'userProfile',
        'hasContact',
        {'otherUserId': otherUserId},
      );
}

/// Endpoint für User-Slots (gekaufte Anzeigen-Slots).
/// {@category Endpoint}
class EndpointUserSlot extends _i1.EndpointRef {
  EndpointUserSlot(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'userSlot';

  /// Ruft alle Slots des aktuellen Benutzers ab.
  _i2.Future<List<_i38.UserSlot>> getMySlots() =>
      caller.callServerEndpoint<List<_i38.UserSlot>>(
        'userSlot',
        'getMySlots',
        {},
      );

  /// Ruft nur verfügbare (ungenutzte, aktive) Slots ab.
  _i2.Future<List<_i38.UserSlot>> getAvailableSlots() =>
      caller.callServerEndpoint<List<_i38.UserSlot>>(
        'userSlot',
        'getAvailableSlots',
        {},
      );

  /// Ruft Slots ab, die in den nächsten X Tagen ablaufen (für Warnungen).
  _i2.Future<List<_i38.UserSlot>> getExpiringSoon({required int days}) =>
      caller.callServerEndpoint<List<_i38.UserSlot>>(
        'userSlot',
        'getExpiringSoon',
        {'days': days},
      );

  /// Erstellt einen Slot für einen Benutzer (Admin-Funktion oder nach Zahlung).
  /// Diese Methode wird intern nach erfolgreicher Zahlung aufgerufen.
  _i2.Future<_i38.UserSlot?> createSlot({
    required int userId,
    required int slotVariantId,
  }) =>
      caller.callServerEndpoint<_i38.UserSlot?>(
        'userSlot',
        'createSlot',
        {
          'userId': userId,
          'slotVariantId': slotVariantId,
        },
      );

  /// Verlängert einen bestehenden Slot.
  _i2.Future<_i38.UserSlot?> extendSlot({
    required int slotId,
    required int additionalDays,
  }) =>
      caller.callServerEndpoint<_i38.UserSlot?>(
        'userSlot',
        'extendSlot',
        {
          'slotId': slotId,
          'additionalDays': additionalDays,
        },
      );

  /// Deaktiviert abgelaufene Slots und deren Angebote.
  /// Sollte regelmäßig als Cron-Job ausgeführt werden.
  _i2.Future<int> deactivateExpired() => caller.callServerEndpoint<int>(
        'userSlot',
        'deactivateExpired',
        {},
      );

  /// Gibt Statistiken über Slots zurück.
  _i2.Future<Map<String, int>> getSlotStats() =>
      caller.callServerEndpoint<Map<String, int>>(
        'userSlot',
        'getSlotStats',
        {},
      );

  /// Admin: Grant a free promotional slot to a user.
  /// This method allows admins to directly grant free slots without payment.
  _i2.Future<_i38.UserSlot?> grantFreeSlot({
    required int userId,
    required int slotVariantId,
  }) =>
      caller.callServerEndpoint<_i38.UserSlot?>(
        'userSlot',
        'grantFreeSlot',
        {
          'userId': userId,
          'slotVariantId': slotVariantId,
        },
      );
}

/// This is an example endpoint that returns a greeting message through
/// its [hello] method.
/// {@category Endpoint}
class EndpointGreeting extends _i1.EndpointRef {
  EndpointGreeting(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'greeting';

  /// Returns a personalized greeting message: "Hello {name}".
  _i2.Future<_i39.Greeting> hello(String name) =>
      caller.callServerEndpoint<_i39.Greeting>(
        'greeting',
        'hello',
        {'name': name},
      );
}

class Modules {
  Modules(Client client) {
    auth = _i40.Caller(client);
  }

  late final _i40.Caller auth;
}

class Client extends _i1.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    _i1.AuthenticationKeyManager? authenticationKeyManager,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _i1.MethodCallContext,
      Object,
      StackTrace,
    )? onFailedCall,
    Function(_i1.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
  }) : super(
          host,
          _i41.Protocol(),
          securityContext: securityContext,
          authenticationKeyManager: authenticationKeyManager,
          streamingConnectionTimeout: streamingConnectionTimeout,
          connectionTimeout: connectionTimeout,
          onFailedCall: onFailedCall,
          onSucceededCall: onSucceededCall,
          disconnectStreamsOnLostInternetConnection:
              disconnectStreamsOnLostInternetConnection,
        ) {
    auth = EndpointAuth(this);
    category = EndpointCategory(this);
    currency = EndpointCurrency(this);
    dispute = EndpointDispute(this);
    draft = EndpointDraft(this);
    favorite = EndpointFavorite(this);
    listing = EndpointListing(this);
    listingImage = EndpointListingImage(this);
    message = EndpointMessage(this);
    news = EndpointNews(this);
    payment = EndpointPayment(this);
    pgpKey = EndpointPgpKey(this);
    rating = EndpointRating(this);
    report = EndpointReport(this);
    search = EndpointSearch(this);
    settings = EndpointSettings(this);
    slotOrder = EndpointSlotOrder(this);
    slotVariant = EndpointSlotVariant(this);
    transaction = EndpointTransaction(this);
    userManagement = EndpointUserManagement(this);
    userProfile = EndpointUserProfile(this);
    userSlot = EndpointUserSlot(this);
    greeting = EndpointGreeting(this);
    modules = Modules(this);
  }

  late final EndpointAuth auth;

  late final EndpointCategory category;

  late final EndpointCurrency currency;

  late final EndpointDispute dispute;

  late final EndpointDraft draft;

  late final EndpointFavorite favorite;

  late final EndpointListing listing;

  late final EndpointListingImage listingImage;

  late final EndpointMessage message;

  late final EndpointNews news;

  late final EndpointPayment payment;

  late final EndpointPgpKey pgpKey;

  late final EndpointRating rating;

  late final EndpointReport report;

  late final EndpointSearch search;

  late final EndpointSettings settings;

  late final EndpointSlotOrder slotOrder;

  late final EndpointSlotVariant slotVariant;

  late final EndpointTransaction transaction;

  late final EndpointUserManagement userManagement;

  late final EndpointUserProfile userProfile;

  late final EndpointUserSlot userSlot;

  late final EndpointGreeting greeting;

  late final Modules modules;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
        'auth': auth,
        'category': category,
        'currency': currency,
        'dispute': dispute,
        'draft': draft,
        'favorite': favorite,
        'listing': listing,
        'listingImage': listingImage,
        'message': message,
        'news': news,
        'payment': payment,
        'pgpKey': pgpKey,
        'rating': rating,
        'report': report,
        'search': search,
        'settings': settings,
        'slotOrder': slotOrder,
        'slotVariant': slotVariant,
        'transaction': transaction,
        'userManagement': userManagement,
        'userProfile': userProfile,
        'userSlot': userSlot,
        'greeting': greeting,
      };

  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup =>
      {'auth': modules.auth};
}
