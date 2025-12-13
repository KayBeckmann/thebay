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
import 'package:bay_client/src/protocol/listing.dart' as _i7;
import 'package:bay_client/src/protocol/quantity_unit.dart' as _i8;
import 'package:bay_client/src/protocol/listing_image.dart' as _i9;
import 'dart:typed_data' as _i10;
import 'package:bay_client/src/protocol/news.dart' as _i11;
import 'package:bay_client/src/protocol/slot_variant.dart' as _i12;
import 'package:bay_client/src/protocol/user_slot.dart' as _i13;
import 'package:bay_client/src/protocol/greeting.dart' as _i14;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i15;
import 'protocol.dart' as _i16;

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

/// Endpoint für Angebote (Listings).
/// {@category Endpoint}
class EndpointListing extends _i1.EndpointRef {
  EndpointListing(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'listing';

  /// Erstellt ein neues Angebot.
  /// Verbraucht automatisch einen verfügbaren Slot.
  _i2.Future<_i7.Listing?> create({
    required int categoryId,
    required String title,
    required String description,
    required double quantity,
    required _i8.QuantityUnit quantityUnit,
    required int pricePerUnit,
    required bool acceptsPaypal,
    required bool acceptsBitcoin,
    required bool hasShipping,
    String? shippingMethod,
    int? shippingCostCents,
  }) =>
      caller.callServerEndpoint<_i7.Listing?>(
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
  _i2.Future<_i7.Listing?> update({
    required int id,
    int? categoryId,
    String? title,
    String? description,
    double? quantity,
    _i8.QuantityUnit? quantityUnit,
    int? pricePerUnit,
    bool? acceptsPaypal,
    bool? acceptsBitcoin,
    bool? hasShipping,
    String? shippingMethod,
    int? shippingCostCents,
  }) =>
      caller.callServerEndpoint<_i7.Listing?>(
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

  /// Löscht ein Angebot (deaktiviert es).
  _i2.Future<bool> delete(int id) => caller.callServerEndpoint<bool>(
        'listing',
        'delete',
        {'id': id},
      );

  /// Ruft ein einzelnes Angebot ab.
  _i2.Future<_i7.Listing?> getById(int id) =>
      caller.callServerEndpoint<_i7.Listing?>(
        'listing',
        'getById',
        {'id': id},
      );

  /// Ruft aktive Angebote ab (mit Pagination).
  _i2.Future<List<_i7.Listing>> getActive({
    int? categoryId,
    required int limit,
    required int offset,
  }) =>
      caller.callServerEndpoint<List<_i7.Listing>>(
        'listing',
        'getActive',
        {
          'categoryId': categoryId,
          'limit': limit,
          'offset': offset,
        },
      );

  /// Ruft die eigenen Angebote des Benutzers ab.
  _i2.Future<List<_i7.Listing>> getMyListings() =>
      caller.callServerEndpoint<List<_i7.Listing>>(
        'listing',
        'getMyListings',
        {},
      );

  /// Ruft Angebote eines bestimmten Benutzers ab (nur aktive).
  _i2.Future<List<_i7.Listing>> getByUser(int userId) =>
      caller.callServerEndpoint<List<_i7.Listing>>(
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
  _i2.Future<_i9.ListingImage?> upload({
    required int listingId,
    required String originalFileName,
    required _i10.Uint8List imageData,
  }) =>
      caller.callServerEndpoint<_i9.ListingImage?>(
        'listingImage',
        'upload',
        {
          'listingId': listingId,
          'originalFileName': originalFileName,
          'imageData': imageData,
        },
      );

  /// Ruft alle Bilder eines Listings ab.
  _i2.Future<List<_i9.ListingImage>> getByListing(int listingId) =>
      caller.callServerEndpoint<List<_i9.ListingImage>>(
        'listingImage',
        'getByListing',
        {'listingId': listingId},
      );

  /// Ruft die Bild-Daten ab (für Anzeige).
  _i2.Future<_i10.Uint8List?> getImageData(int imageId) =>
      caller.callServerEndpoint<_i10.Uint8List?>(
        'listingImage',
        'getImageData',
        {'imageId': imageId},
      );

  /// Ruft die Bild-Daten über den Dateinamen ab.
  _i2.Future<_i10.Uint8List?> getImageDataByPath(String relativePath) =>
      caller.callServerEndpoint<_i10.Uint8List?>(
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

/// Endpoint for managing news articles.
/// Admin can create/edit/delete, users can read published news.
/// {@category Endpoint}
class EndpointNews extends _i1.EndpointRef {
  EndpointNews(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'news';

  /// Get all published and non-expired news (public).
  _i2.Future<List<_i11.News>> getPublished() =>
      caller.callServerEndpoint<List<_i11.News>>(
        'news',
        'getPublished',
        {},
      );

  /// Get all news including unpublished (admin only).
  _i2.Future<List<_i11.News>> getAll() =>
      caller.callServerEndpoint<List<_i11.News>>(
        'news',
        'getAll',
        {},
      );

  /// Get a single news article by ID.
  _i2.Future<_i11.News?> getById(int id) =>
      caller.callServerEndpoint<_i11.News?>(
        'news',
        'getById',
        {'id': id},
      );

  /// Create a new news article (admin only).
  _i2.Future<_i11.News?> create({
    required String title,
    required String content,
    required bool publish,
    int? lifetimeDays,
  }) =>
      caller.callServerEndpoint<_i11.News?>(
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
  _i2.Future<_i11.News?> update({
    required int id,
    required String title,
    required String content,
    required bool isPublished,
    DateTime? expiresAt,
  }) =>
      caller.callServerEndpoint<_i11.News?>(
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
  _i2.Future<Map<String, dynamic>> getPaymentSettings() =>
      caller.callServerEndpoint<Map<String, dynamic>>(
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

/// Endpoint for managing slot variants.
/// Most operations require admin privileges.
/// {@category Endpoint}
class EndpointSlotVariant extends _i1.EndpointRef {
  EndpointSlotVariant(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'slotVariant';

  /// Get all slot variants (admin only).
  _i2.Future<List<_i12.SlotVariant>> getAll() =>
      caller.callServerEndpoint<List<_i12.SlotVariant>>(
        'slotVariant',
        'getAll',
        {},
      );

  /// Get only active slot variants (public).
  _i2.Future<List<_i12.SlotVariant>> getActive() =>
      caller.callServerEndpoint<List<_i12.SlotVariant>>(
        'slotVariant',
        'getActive',
        {},
      );

  /// Get a single slot variant by ID (public).
  _i2.Future<_i12.SlotVariant?> getById(int id) =>
      caller.callServerEndpoint<_i12.SlotVariant?>(
        'slotVariant',
        'getById',
        {'id': id},
      );

  /// Create a new slot variant (admin only).
  _i2.Future<_i12.SlotVariant?> create({
    required String name,
    String? description,
    required int priceUsdCents,
    required int durationDays,
    required bool allowPaypal,
    required bool allowBitcoin,
    required int sortOrder,
  }) =>
      caller.callServerEndpoint<_i12.SlotVariant?>(
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
        },
      );

  /// Update a slot variant (admin only).
  _i2.Future<_i12.SlotVariant?> update({
    required int id,
    required String name,
    String? description,
    required int priceUsdCents,
    required int durationDays,
    required bool allowPaypal,
    required bool allowBitcoin,
    required bool isActive,
    required int sortOrder,
  }) =>
      caller.callServerEndpoint<_i12.SlotVariant?>(
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

/// Endpoint für User-Slots (gekaufte Anzeigen-Slots).
/// {@category Endpoint}
class EndpointUserSlot extends _i1.EndpointRef {
  EndpointUserSlot(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'userSlot';

  /// Ruft alle Slots des aktuellen Benutzers ab.
  _i2.Future<List<_i13.UserSlot>> getMySlots() =>
      caller.callServerEndpoint<List<_i13.UserSlot>>(
        'userSlot',
        'getMySlots',
        {},
      );

  /// Ruft nur verfügbare (ungenutzte, aktive) Slots ab.
  _i2.Future<List<_i13.UserSlot>> getAvailableSlots() =>
      caller.callServerEndpoint<List<_i13.UserSlot>>(
        'userSlot',
        'getAvailableSlots',
        {},
      );

  /// Ruft Slots ab, die in den nächsten X Tagen ablaufen (für Warnungen).
  _i2.Future<List<_i13.UserSlot>> getExpiringSoon({required int days}) =>
      caller.callServerEndpoint<List<_i13.UserSlot>>(
        'userSlot',
        'getExpiringSoon',
        {'days': days},
      );

  /// Erstellt einen Slot für einen Benutzer (Admin-Funktion oder nach Zahlung).
  /// Diese Methode wird intern nach erfolgreicher Zahlung aufgerufen.
  _i2.Future<_i13.UserSlot?> createSlot({
    required int userId,
    required int slotVariantId,
  }) =>
      caller.callServerEndpoint<_i13.UserSlot?>(
        'userSlot',
        'createSlot',
        {
          'userId': userId,
          'slotVariantId': slotVariantId,
        },
      );

  /// Verlängert einen bestehenden Slot.
  _i2.Future<_i13.UserSlot?> extendSlot({
    required int slotId,
    required int additionalDays,
  }) =>
      caller.callServerEndpoint<_i13.UserSlot?>(
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
}

/// This is an example endpoint that returns a greeting message through
/// its [hello] method.
/// {@category Endpoint}
class EndpointGreeting extends _i1.EndpointRef {
  EndpointGreeting(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'greeting';

  /// Returns a personalized greeting message: "Hello {name}".
  _i2.Future<_i14.Greeting> hello(String name) =>
      caller.callServerEndpoint<_i14.Greeting>(
        'greeting',
        'hello',
        {'name': name},
      );
}

class Modules {
  Modules(Client client) {
    auth = _i15.Caller(client);
  }

  late final _i15.Caller auth;
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
          _i16.Protocol(),
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
    listing = EndpointListing(this);
    listingImage = EndpointListingImage(this);
    news = EndpointNews(this);
    settings = EndpointSettings(this);
    slotVariant = EndpointSlotVariant(this);
    userSlot = EndpointUserSlot(this);
    greeting = EndpointGreeting(this);
    modules = Modules(this);
  }

  late final EndpointAuth auth;

  late final EndpointCategory category;

  late final EndpointListing listing;

  late final EndpointListingImage listingImage;

  late final EndpointNews news;

  late final EndpointSettings settings;

  late final EndpointSlotVariant slotVariant;

  late final EndpointUserSlot userSlot;

  late final EndpointGreeting greeting;

  late final Modules modules;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
        'auth': auth,
        'category': category,
        'listing': listing,
        'listingImage': listingImage,
        'news': news,
        'settings': settings,
        'slotVariant': slotVariant,
        'userSlot': userSlot,
        'greeting': greeting,
      };

  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup =>
      {'auth': modules.auth};
}
