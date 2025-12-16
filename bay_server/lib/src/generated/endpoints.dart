/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import '../endpoints/auth_endpoint.dart' as _i2;
import '../endpoints/category_endpoint.dart' as _i3;
import '../endpoints/favorite_endpoint.dart' as _i4;
import '../endpoints/listing_endpoint.dart' as _i5;
import '../endpoints/listing_image_endpoint.dart' as _i6;
import '../endpoints/news_endpoint.dart' as _i7;
import '../endpoints/payment_endpoint.dart' as _i8;
import '../endpoints/pgp_key_endpoint.dart' as _i9;
import '../endpoints/search_endpoint.dart' as _i10;
import '../endpoints/settings_endpoint.dart' as _i11;
import '../endpoints/slot_order_endpoint.dart' as _i12;
import '../endpoints/slot_variant_endpoint.dart' as _i13;
import '../endpoints/user_slot_endpoint.dart' as _i14;
import '../greeting_endpoint.dart' as _i15;
import 'package:bay_server/src/generated/registration_request.dart' as _i16;
import 'package:bay_server/src/generated/login_request.dart' as _i17;
import 'package:bay_server/src/generated/quantity_unit.dart' as _i18;
import 'dart:typed_data' as _i19;
import 'package:bay_server/src/generated/payment_method.dart' as _i20;
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as _i21;

class Endpoints extends _i1.EndpointDispatch {
  @override
  void initializeEndpoints(_i1.Server server) {
    var endpoints = <String, _i1.Endpoint>{
      'auth': _i2.AuthEndpoint()
        ..initialize(
          server,
          'auth',
          null,
        ),
      'category': _i3.CategoryEndpoint()
        ..initialize(
          server,
          'category',
          null,
        ),
      'favorite': _i4.FavoriteEndpoint()
        ..initialize(
          server,
          'favorite',
          null,
        ),
      'listing': _i5.ListingEndpoint()
        ..initialize(
          server,
          'listing',
          null,
        ),
      'listingImage': _i6.ListingImageEndpoint()
        ..initialize(
          server,
          'listingImage',
          null,
        ),
      'news': _i7.NewsEndpoint()
        ..initialize(
          server,
          'news',
          null,
        ),
      'payment': _i8.PaymentEndpoint()
        ..initialize(
          server,
          'payment',
          null,
        ),
      'pgpKey': _i9.PgpKeyEndpoint()
        ..initialize(
          server,
          'pgpKey',
          null,
        ),
      'search': _i10.SearchEndpoint()
        ..initialize(
          server,
          'search',
          null,
        ),
      'settings': _i11.SettingsEndpoint()
        ..initialize(
          server,
          'settings',
          null,
        ),
      'slotOrder': _i12.SlotOrderEndpoint()
        ..initialize(
          server,
          'slotOrder',
          null,
        ),
      'slotVariant': _i13.SlotVariantEndpoint()
        ..initialize(
          server,
          'slotVariant',
          null,
        ),
      'userSlot': _i14.UserSlotEndpoint()
        ..initialize(
          server,
          'userSlot',
          null,
        ),
      'greeting': _i15.GreetingEndpoint()
        ..initialize(
          server,
          'greeting',
          null,
        ),
    };
    connectors['auth'] = _i1.EndpointConnector(
      name: 'auth',
      endpoint: endpoints['auth']!,
      methodConnectors: {
        'register': _i1.MethodConnector(
          name: 'register',
          params: {
            'request': _i1.ParameterDescription(
              name: 'request',
              type: _i1.getType<_i16.RegistrationRequest>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['auth'] as _i2.AuthEndpoint).register(
            session,
            params['request'],
          ),
        ),
        'login': _i1.MethodConnector(
          name: 'login',
          params: {
            'request': _i1.ParameterDescription(
              name: 'request',
              type: _i1.getType<_i17.LoginRequest>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['auth'] as _i2.AuthEndpoint).login(
            session,
            params['request'],
          ),
        ),
        'logout': _i1.MethodConnector(
          name: 'logout',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['auth'] as _i2.AuthEndpoint).logout(session),
        ),
        'getCurrentUser': _i1.MethodConnector(
          name: 'getCurrentUser',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['auth'] as _i2.AuthEndpoint).getCurrentUser(session),
        ),
        'changePassword': _i1.MethodConnector(
          name: 'changePassword',
          params: {
            'currentPassword': _i1.ParameterDescription(
              name: 'currentPassword',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'newPassword': _i1.ParameterDescription(
              name: 'newPassword',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['auth'] as _i2.AuthEndpoint).changePassword(
            session,
            params['currentPassword'],
            params['newPassword'],
          ),
        ),
        'deleteAccount': _i1.MethodConnector(
          name: 'deleteAccount',
          params: {
            'password': _i1.ParameterDescription(
              name: 'password',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['auth'] as _i2.AuthEndpoint).deleteAccount(
            session,
            params['password'],
          ),
        ),
      },
    );
    connectors['category'] = _i1.EndpointConnector(
      name: 'category',
      endpoint: endpoints['category']!,
      methodConnectors: {
        'getAll': _i1.MethodConnector(
          name: 'getAll',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['category'] as _i3.CategoryEndpoint).getAll(session),
        ),
        'getActive': _i1.MethodConnector(
          name: 'getActive',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['category'] as _i3.CategoryEndpoint)
                  .getActive(session),
        ),
        'getRootCategories': _i1.MethodConnector(
          name: 'getRootCategories',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['category'] as _i3.CategoryEndpoint)
                  .getRootCategories(session),
        ),
        'getSubcategories': _i1.MethodConnector(
          name: 'getSubcategories',
          params: {
            'parentId': _i1.ParameterDescription(
              name: 'parentId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['category'] as _i3.CategoryEndpoint).getSubcategories(
            session,
            params['parentId'],
          ),
        ),
        'create': _i1.MethodConnector(
          name: 'create',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'parentId': _i1.ParameterDescription(
              name: 'parentId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'sortOrder': _i1.ParameterDescription(
              name: 'sortOrder',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['category'] as _i3.CategoryEndpoint).create(
            session,
            params['name'],
            params['parentId'],
            params['sortOrder'],
          ),
        ),
        'update': _i1.MethodConnector(
          name: 'update',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'parentId': _i1.ParameterDescription(
              name: 'parentId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'sortOrder': _i1.ParameterDescription(
              name: 'sortOrder',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'isActive': _i1.ParameterDescription(
              name: 'isActive',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['category'] as _i3.CategoryEndpoint).update(
            session,
            params['id'],
            params['name'],
            params['parentId'],
            params['sortOrder'],
            params['isActive'],
          ),
        ),
        'delete': _i1.MethodConnector(
          name: 'delete',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['category'] as _i3.CategoryEndpoint).delete(
            session,
            params['id'],
          ),
        ),
      },
    );
    connectors['favorite'] = _i1.EndpointConnector(
      name: 'favorite',
      endpoint: endpoints['favorite']!,
      methodConnectors: {
        'add': _i1.MethodConnector(
          name: 'add',
          params: {
            'listingId': _i1.ParameterDescription(
              name: 'listingId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['favorite'] as _i4.FavoriteEndpoint).add(
            session,
            params['listingId'],
          ),
        ),
        'remove': _i1.MethodConnector(
          name: 'remove',
          params: {
            'listingId': _i1.ParameterDescription(
              name: 'listingId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['favorite'] as _i4.FavoriteEndpoint).remove(
            session,
            params['listingId'],
          ),
        ),
        'isFavorite': _i1.MethodConnector(
          name: 'isFavorite',
          params: {
            'listingId': _i1.ParameterDescription(
              name: 'listingId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['favorite'] as _i4.FavoriteEndpoint).isFavorite(
            session,
            params['listingId'],
          ),
        ),
        'getMyFavorites': _i1.MethodConnector(
          name: 'getMyFavorites',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['favorite'] as _i4.FavoriteEndpoint)
                  .getMyFavorites(session),
        ),
        'getCount': _i1.MethodConnector(
          name: 'getCount',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['favorite'] as _i4.FavoriteEndpoint).getCount(session),
        ),
        'checkMultiple': _i1.MethodConnector(
          name: 'checkMultiple',
          params: {
            'listingIds': _i1.ParameterDescription(
              name: 'listingIds',
              type: _i1.getType<List<int>>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['favorite'] as _i4.FavoriteEndpoint).checkMultiple(
            session,
            params['listingIds'],
          ),
        ),
      },
    );
    connectors['listing'] = _i1.EndpointConnector(
      name: 'listing',
      endpoint: endpoints['listing']!,
      methodConnectors: {
        'create': _i1.MethodConnector(
          name: 'create',
          params: {
            'categoryId': _i1.ParameterDescription(
              name: 'categoryId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'title': _i1.ParameterDescription(
              name: 'title',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'description': _i1.ParameterDescription(
              name: 'description',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'quantity': _i1.ParameterDescription(
              name: 'quantity',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'quantityUnit': _i1.ParameterDescription(
              name: 'quantityUnit',
              type: _i1.getType<_i18.QuantityUnit>(),
              nullable: false,
            ),
            'pricePerUnit': _i1.ParameterDescription(
              name: 'pricePerUnit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'acceptsPaypal': _i1.ParameterDescription(
              name: 'acceptsPaypal',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
            'acceptsBitcoin': _i1.ParameterDescription(
              name: 'acceptsBitcoin',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
            'hasShipping': _i1.ParameterDescription(
              name: 'hasShipping',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
            'shippingMethod': _i1.ParameterDescription(
              name: 'shippingMethod',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'shippingCostCents': _i1.ParameterDescription(
              name: 'shippingCostCents',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['listing'] as _i5.ListingEndpoint).create(
            session,
            categoryId: params['categoryId'],
            title: params['title'],
            description: params['description'],
            quantity: params['quantity'],
            quantityUnit: params['quantityUnit'],
            pricePerUnit: params['pricePerUnit'],
            acceptsPaypal: params['acceptsPaypal'],
            acceptsBitcoin: params['acceptsBitcoin'],
            hasShipping: params['hasShipping'],
            shippingMethod: params['shippingMethod'],
            shippingCostCents: params['shippingCostCents'],
          ),
        ),
        'update': _i1.MethodConnector(
          name: 'update',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'categoryId': _i1.ParameterDescription(
              name: 'categoryId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'title': _i1.ParameterDescription(
              name: 'title',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'description': _i1.ParameterDescription(
              name: 'description',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'quantity': _i1.ParameterDescription(
              name: 'quantity',
              type: _i1.getType<double?>(),
              nullable: true,
            ),
            'quantityUnit': _i1.ParameterDescription(
              name: 'quantityUnit',
              type: _i1.getType<_i18.QuantityUnit?>(),
              nullable: true,
            ),
            'pricePerUnit': _i1.ParameterDescription(
              name: 'pricePerUnit',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'acceptsPaypal': _i1.ParameterDescription(
              name: 'acceptsPaypal',
              type: _i1.getType<bool?>(),
              nullable: true,
            ),
            'acceptsBitcoin': _i1.ParameterDescription(
              name: 'acceptsBitcoin',
              type: _i1.getType<bool?>(),
              nullable: true,
            ),
            'hasShipping': _i1.ParameterDescription(
              name: 'hasShipping',
              type: _i1.getType<bool?>(),
              nullable: true,
            ),
            'shippingMethod': _i1.ParameterDescription(
              name: 'shippingMethod',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'shippingCostCents': _i1.ParameterDescription(
              name: 'shippingCostCents',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['listing'] as _i5.ListingEndpoint).update(
            session,
            id: params['id'],
            categoryId: params['categoryId'],
            title: params['title'],
            description: params['description'],
            quantity: params['quantity'],
            quantityUnit: params['quantityUnit'],
            pricePerUnit: params['pricePerUnit'],
            acceptsPaypal: params['acceptsPaypal'],
            acceptsBitcoin: params['acceptsBitcoin'],
            hasShipping: params['hasShipping'],
            shippingMethod: params['shippingMethod'],
            shippingCostCents: params['shippingCostCents'],
          ),
        ),
        'delete': _i1.MethodConnector(
          name: 'delete',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['listing'] as _i5.ListingEndpoint).delete(
            session,
            params['id'],
          ),
        ),
        'getById': _i1.MethodConnector(
          name: 'getById',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['listing'] as _i5.ListingEndpoint).getById(
            session,
            params['id'],
          ),
        ),
        'getActive': _i1.MethodConnector(
          name: 'getActive',
          params: {
            'categoryId': _i1.ParameterDescription(
              name: 'categoryId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'offset': _i1.ParameterDescription(
              name: 'offset',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['listing'] as _i5.ListingEndpoint).getActive(
            session,
            categoryId: params['categoryId'],
            limit: params['limit'],
            offset: params['offset'],
          ),
        ),
        'getMyListings': _i1.MethodConnector(
          name: 'getMyListings',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['listing'] as _i5.ListingEndpoint)
                  .getMyListings(session),
        ),
        'getByUser': _i1.MethodConnector(
          name: 'getByUser',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['listing'] as _i5.ListingEndpoint).getByUser(
            session,
            params['userId'],
          ),
        ),
        'getAvailableSlotCount': _i1.MethodConnector(
          name: 'getAvailableSlotCount',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['listing'] as _i5.ListingEndpoint)
                  .getAvailableSlotCount(session),
        ),
      },
    );
    connectors['listingImage'] = _i1.EndpointConnector(
      name: 'listingImage',
      endpoint: endpoints['listingImage']!,
      methodConnectors: {
        'upload': _i1.MethodConnector(
          name: 'upload',
          params: {
            'listingId': _i1.ParameterDescription(
              name: 'listingId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'originalFileName': _i1.ParameterDescription(
              name: 'originalFileName',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'imageData': _i1.ParameterDescription(
              name: 'imageData',
              type: _i1.getType<_i19.ByteData>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['listingImage'] as _i6.ListingImageEndpoint).upload(
            session,
            listingId: params['listingId'],
            originalFileName: params['originalFileName'],
            imageData: params['imageData'],
          ),
        ),
        'getByListing': _i1.MethodConnector(
          name: 'getByListing',
          params: {
            'listingId': _i1.ParameterDescription(
              name: 'listingId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['listingImage'] as _i6.ListingImageEndpoint)
                  .getByListing(
            session,
            params['listingId'],
          ),
        ),
        'getImageData': _i1.MethodConnector(
          name: 'getImageData',
          params: {
            'imageId': _i1.ParameterDescription(
              name: 'imageId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['listingImage'] as _i6.ListingImageEndpoint)
                  .getImageData(
            session,
            params['imageId'],
          ),
        ),
        'getImageDataByPath': _i1.MethodConnector(
          name: 'getImageDataByPath',
          params: {
            'relativePath': _i1.ParameterDescription(
              name: 'relativePath',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['listingImage'] as _i6.ListingImageEndpoint)
                  .getImageDataByPath(
            session,
            params['relativePath'],
          ),
        ),
        'delete': _i1.MethodConnector(
          name: 'delete',
          params: {
            'imageId': _i1.ParameterDescription(
              name: 'imageId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['listingImage'] as _i6.ListingImageEndpoint).delete(
            session,
            params['imageId'],
          ),
        ),
        'reorder': _i1.MethodConnector(
          name: 'reorder',
          params: {
            'listingId': _i1.ParameterDescription(
              name: 'listingId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'imageIds': _i1.ParameterDescription(
              name: 'imageIds',
              type: _i1.getType<List<int>>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['listingImage'] as _i6.ListingImageEndpoint).reorder(
            session,
            listingId: params['listingId'],
            imageIds: params['imageIds'],
          ),
        ),
        'setMainImage': _i1.MethodConnector(
          name: 'setMainImage',
          params: {
            'imageId': _i1.ParameterDescription(
              name: 'imageId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['listingImage'] as _i6.ListingImageEndpoint)
                  .setMainImage(
            session,
            params['imageId'],
          ),
        ),
        'deleteAllForListing': _i1.MethodConnector(
          name: 'deleteAllForListing',
          params: {
            'listingId': _i1.ParameterDescription(
              name: 'listingId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['listingImage'] as _i6.ListingImageEndpoint)
                  .deleteAllForListing(
            session,
            params['listingId'],
          ),
        ),
      },
    );
    connectors['news'] = _i1.EndpointConnector(
      name: 'news',
      endpoint: endpoints['news']!,
      methodConnectors: {
        'getPublished': _i1.MethodConnector(
          name: 'getPublished',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['news'] as _i7.NewsEndpoint).getPublished(session),
        ),
        'getAll': _i1.MethodConnector(
          name: 'getAll',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['news'] as _i7.NewsEndpoint).getAll(session),
        ),
        'getById': _i1.MethodConnector(
          name: 'getById',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['news'] as _i7.NewsEndpoint).getById(
            session,
            params['id'],
          ),
        ),
        'create': _i1.MethodConnector(
          name: 'create',
          params: {
            'title': _i1.ParameterDescription(
              name: 'title',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'content': _i1.ParameterDescription(
              name: 'content',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'publish': _i1.ParameterDescription(
              name: 'publish',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
            'lifetimeDays': _i1.ParameterDescription(
              name: 'lifetimeDays',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['news'] as _i7.NewsEndpoint).create(
            session,
            title: params['title'],
            content: params['content'],
            publish: params['publish'],
            lifetimeDays: params['lifetimeDays'],
          ),
        ),
        'update': _i1.MethodConnector(
          name: 'update',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'title': _i1.ParameterDescription(
              name: 'title',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'content': _i1.ParameterDescription(
              name: 'content',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'isPublished': _i1.ParameterDescription(
              name: 'isPublished',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
            'expiresAt': _i1.ParameterDescription(
              name: 'expiresAt',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['news'] as _i7.NewsEndpoint).update(
            session,
            id: params['id'],
            title: params['title'],
            content: params['content'],
            isPublished: params['isPublished'],
            expiresAt: params['expiresAt'],
          ),
        ),
        'delete': _i1.MethodConnector(
          name: 'delete',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['news'] as _i7.NewsEndpoint).delete(
            session,
            params['id'],
          ),
        ),
        'deleteExpired': _i1.MethodConnector(
          name: 'deleteExpired',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['news'] as _i7.NewsEndpoint).deleteExpired(session),
        ),
      },
    );
    connectors['payment'] = _i1.EndpointConnector(
      name: 'payment',
      endpoint: endpoints['payment']!,
      methodConnectors: {
        'handlePayPalIpn': _i1.MethodConnector(
          name: 'handlePayPalIpn',
          params: {
            'ipnData': _i1.ParameterDescription(
              name: 'ipnData',
              type: _i1.getType<Map<String, String>>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['payment'] as _i8.PaymentEndpoint).handlePayPalIpn(
            session,
            params['ipnData'],
          ),
        ),
        'setBitcoinTransactionId': _i1.MethodConnector(
          name: 'setBitcoinTransactionId',
          params: {
            'orderId': _i1.ParameterDescription(
              name: 'orderId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'transactionId': _i1.ParameterDescription(
              name: 'transactionId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['payment'] as _i8.PaymentEndpoint)
                  .setBitcoinTransactionId(
            session,
            orderId: params['orderId'],
            transactionId: params['transactionId'],
          ),
        ),
        'checkPendingBitcoinPayments': _i1.MethodConnector(
          name: 'checkPendingBitcoinPayments',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['payment'] as _i8.PaymentEndpoint)
                  .checkPendingBitcoinPayments(session),
        ),
        'getPaymentInfo': _i1.MethodConnector(
          name: 'getPaymentInfo',
          params: {
            'orderId': _i1.ParameterDescription(
              name: 'orderId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['payment'] as _i8.PaymentEndpoint).getPaymentInfo(
            session,
            params['orderId'],
          ),
        ),
        'confirmPaymentManually': _i1.MethodConnector(
          name: 'confirmPaymentManually',
          params: {
            'orderId': _i1.ParameterDescription(
              name: 'orderId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'transactionId': _i1.ParameterDescription(
              name: 'transactionId',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['payment'] as _i8.PaymentEndpoint)
                  .confirmPaymentManually(
            session,
            orderId: params['orderId'],
            transactionId: params['transactionId'],
          ),
        ),
        'getBtcUsdRate': _i1.MethodConnector(
          name: 'getBtcUsdRate',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['payment'] as _i8.PaymentEndpoint)
                  .getBtcUsdRate(session),
        ),
      },
    );
    connectors['pgpKey'] = _i1.EndpointConnector(
      name: 'pgpKey',
      endpoint: endpoints['pgpKey']!,
      methodConnectors: {
        'uploadPublicKey': _i1.MethodConnector(
          name: 'uploadPublicKey',
          params: {
            'publicKeyArmored': _i1.ParameterDescription(
              name: 'publicKeyArmored',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'keyIdentity': _i1.ParameterDescription(
              name: 'keyIdentity',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'fingerprint': _i1.ParameterDescription(
              name: 'fingerprint',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'algorithm': _i1.ParameterDescription(
              name: 'algorithm',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'keySize': _i1.ParameterDescription(
              name: 'keySize',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['pgpKey'] as _i9.PgpKeyEndpoint).uploadPublicKey(
            session,
            params['publicKeyArmored'],
            params['keyIdentity'],
            params['fingerprint'],
            params['algorithm'],
            params['keySize'],
          ),
        ),
        'getMyPublicKey': _i1.MethodConnector(
          name: 'getMyPublicKey',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['pgpKey'] as _i9.PgpKeyEndpoint)
                  .getMyPublicKey(session),
        ),
        'getPublicKey': _i1.MethodConnector(
          name: 'getPublicKey',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['pgpKey'] as _i9.PgpKeyEndpoint).getPublicKey(
            session,
            params['userId'],
          ),
        ),
        'getPublicKeyByUsername': _i1.MethodConnector(
          name: 'getPublicKeyByUsername',
          params: {
            'username': _i1.ParameterDescription(
              name: 'username',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['pgpKey'] as _i9.PgpKeyEndpoint)
                  .getPublicKeyByUsername(
            session,
            params['username'],
          ),
        ),
        'hasPublicKey': _i1.MethodConnector(
          name: 'hasPublicKey',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int?>(),
              nullable: true,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['pgpKey'] as _i9.PgpKeyEndpoint).hasPublicKey(
            session,
            params['userId'],
          ),
        ),
        'deactivateKey': _i1.MethodConnector(
          name: 'deactivateKey',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['pgpKey'] as _i9.PgpKeyEndpoint)
                  .deactivateKey(session),
        ),
        'getKeyMetadata': _i1.MethodConnector(
          name: 'getKeyMetadata',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['pgpKey'] as _i9.PgpKeyEndpoint)
                  .getKeyMetadata(session),
        ),
        'uploadEncryptedBackup': _i1.MethodConnector(
          name: 'uploadEncryptedBackup',
          params: {
            'encryptedPrivateKey': _i1.ParameterDescription(
              name: 'encryptedPrivateKey',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'fingerprint': _i1.ParameterDescription(
              name: 'fingerprint',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'encryptionSalt': _i1.ParameterDescription(
              name: 'encryptionSalt',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'kdfParams': _i1.ParameterDescription(
              name: 'kdfParams',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['pgpKey'] as _i9.PgpKeyEndpoint).uploadEncryptedBackup(
            session,
            params['encryptedPrivateKey'],
            params['fingerprint'],
            params['encryptionSalt'],
            params['kdfParams'],
          ),
        ),
        'downloadEncryptedBackup': _i1.MethodConnector(
          name: 'downloadEncryptedBackup',
          params: {
            'fingerprint': _i1.ParameterDescription(
              name: 'fingerprint',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['pgpKey'] as _i9.PgpKeyEndpoint)
                  .downloadEncryptedBackup(
            session,
            params['fingerprint'],
          ),
        ),
        'listBackups': _i1.MethodConnector(
          name: 'listBackups',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['pgpKey'] as _i9.PgpKeyEndpoint).listBackups(session),
        ),
        'deleteBackup': _i1.MethodConnector(
          name: 'deleteBackup',
          params: {
            'backupId': _i1.ParameterDescription(
              name: 'backupId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['pgpKey'] as _i9.PgpKeyEndpoint).deleteBackup(
            session,
            params['backupId'],
          ),
        ),
      },
    );
    connectors['search'] = _i1.EndpointConnector(
      name: 'search',
      endpoint: endpoints['search']!,
      methodConnectors: {
        'search': _i1.MethodConnector(
          name: 'search',
          params: {
            'query': _i1.ParameterDescription(
              name: 'query',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'categoryId': _i1.ParameterDescription(
              name: 'categoryId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'subcategoryId': _i1.ParameterDescription(
              name: 'subcategoryId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'acceptsPaypal': _i1.ParameterDescription(
              name: 'acceptsPaypal',
              type: _i1.getType<bool?>(),
              nullable: true,
            ),
            'acceptsBitcoin': _i1.ParameterDescription(
              name: 'acceptsBitcoin',
              type: _i1.getType<bool?>(),
              nullable: true,
            ),
            'page': _i1.ParameterDescription(
              name: 'page',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'pageSize': _i1.ParameterDescription(
              name: 'pageSize',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['search'] as _i10.SearchEndpoint).search(
            session,
            query: params['query'],
            categoryId: params['categoryId'],
            subcategoryId: params['subcategoryId'],
            acceptsPaypal: params['acceptsPaypal'],
            acceptsBitcoin: params['acceptsBitcoin'],
            page: params['page'],
            pageSize: params['pageSize'],
          ),
        ),
        'quickSearch': _i1.MethodConnector(
          name: 'quickSearch',
          params: {
            'query': _i1.ParameterDescription(
              name: 'query',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['search'] as _i10.SearchEndpoint).quickSearch(
            session,
            params['query'],
            limit: params['limit'],
          ),
        ),
        'countActive': _i1.MethodConnector(
          name: 'countActive',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['search'] as _i10.SearchEndpoint).countActive(session),
        ),
      },
    );
    connectors['settings'] = _i1.EndpointConnector(
      name: 'settings',
      endpoint: endpoints['settings']!,
      methodConnectors: {
        'get': _i1.MethodConnector(
          name: 'get',
          params: {
            'key': _i1.ParameterDescription(
              name: 'key',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['settings'] as _i11.SettingsEndpoint).get(
            session,
            params['key'],
          ),
        ),
        'getMultiple': _i1.MethodConnector(
          name: 'getMultiple',
          params: {
            'keys': _i1.ParameterDescription(
              name: 'keys',
              type: _i1.getType<List<String>>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['settings'] as _i11.SettingsEndpoint).getMultiple(
            session,
            params['keys'],
          ),
        ),
        'set': _i1.MethodConnector(
          name: 'set',
          params: {
            'key': _i1.ParameterDescription(
              name: 'key',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'value': _i1.ParameterDescription(
              name: 'value',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'description': _i1.ParameterDescription(
              name: 'description',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['settings'] as _i11.SettingsEndpoint).set(
            session,
            params['key'],
            params['value'],
            description: params['description'],
          ),
        ),
        'delete': _i1.MethodConnector(
          name: 'delete',
          params: {
            'key': _i1.ParameterDescription(
              name: 'key',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['settings'] as _i11.SettingsEndpoint).delete(
            session,
            params['key'],
          ),
        ),
        'getPaymentSettings': _i1.MethodConnector(
          name: 'getPaymentSettings',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['settings'] as _i11.SettingsEndpoint)
                  .getPaymentSettings(session),
        ),
        'updatePaymentSettings': _i1.MethodConnector(
          name: 'updatePaymentSettings',
          params: {
            'paypalEmail': _i1.ParameterDescription(
              name: 'paypalEmail',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'bitcoinWallet': _i1.ParameterDescription(
              name: 'bitcoinWallet',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'paypalEnabled': _i1.ParameterDescription(
              name: 'paypalEnabled',
              type: _i1.getType<bool?>(),
              nullable: true,
            ),
            'bitcoinEnabled': _i1.ParameterDescription(
              name: 'bitcoinEnabled',
              type: _i1.getType<bool?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['settings'] as _i11.SettingsEndpoint)
                  .updatePaymentSettings(
            session,
            paypalEmail: params['paypalEmail'],
            bitcoinWallet: params['bitcoinWallet'],
            paypalEnabled: params['paypalEnabled'],
            bitcoinEnabled: params['bitcoinEnabled'],
          ),
        ),
      },
    );
    connectors['slotOrder'] = _i1.EndpointConnector(
      name: 'slotOrder',
      endpoint: endpoints['slotOrder']!,
      methodConnectors: {
        'create': _i1.MethodConnector(
          name: 'create',
          params: {
            'slotVariantId': _i1.ParameterDescription(
              name: 'slotVariantId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'paymentMethod': _i1.ParameterDescription(
              name: 'paymentMethod',
              type: _i1.getType<_i20.PaymentMethod>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['slotOrder'] as _i12.SlotOrderEndpoint).create(
            session,
            slotVariantId: params['slotVariantId'],
            paymentMethod: params['paymentMethod'],
          ),
        ),
        'getMyOrders': _i1.MethodConnector(
          name: 'getMyOrders',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['slotOrder'] as _i12.SlotOrderEndpoint)
                  .getMyOrders(session),
        ),
        'getPendingOrders': _i1.MethodConnector(
          name: 'getPendingOrders',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['slotOrder'] as _i12.SlotOrderEndpoint)
                  .getPendingOrders(session),
        ),
        'getById': _i1.MethodConnector(
          name: 'getById',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['slotOrder'] as _i12.SlotOrderEndpoint).getById(
            session,
            params['id'],
          ),
        ),
        'cancel': _i1.MethodConnector(
          name: 'cancel',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['slotOrder'] as _i12.SlotOrderEndpoint).cancel(
            session,
            params['id'],
          ),
        ),
        'markAsPaid': _i1.MethodConnector(
          name: 'markAsPaid',
          params: {
            'orderId': _i1.ParameterDescription(
              name: 'orderId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'transactionId': _i1.ParameterDescription(
              name: 'transactionId',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['slotOrder'] as _i12.SlotOrderEndpoint).markAsPaid(
            session,
            orderId: params['orderId'],
            transactionId: params['transactionId'],
          ),
        ),
        'getAllOrders': _i1.MethodConnector(
          name: 'getAllOrders',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['slotOrder'] as _i12.SlotOrderEndpoint)
                  .getAllOrders(session),
        ),
        'getAllPendingOrders': _i1.MethodConnector(
          name: 'getAllPendingOrders',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['slotOrder'] as _i12.SlotOrderEndpoint)
                  .getAllPendingOrders(session),
        ),
        'getOrderUser': _i1.MethodConnector(
          name: 'getOrderUser',
          params: {
            'orderId': _i1.ParameterDescription(
              name: 'orderId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['slotOrder'] as _i12.SlotOrderEndpoint).getOrderUser(
            session,
            params['orderId'],
          ),
        ),
        'getOrderVariant': _i1.MethodConnector(
          name: 'getOrderVariant',
          params: {
            'orderId': _i1.ParameterDescription(
              name: 'orderId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['slotOrder'] as _i12.SlotOrderEndpoint)
                  .getOrderVariant(
            session,
            params['orderId'],
          ),
        ),
        'expireOldOrders': _i1.MethodConnector(
          name: 'expireOldOrders',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['slotOrder'] as _i12.SlotOrderEndpoint)
                  .expireOldOrders(session),
        ),
      },
    );
    connectors['slotVariant'] = _i1.EndpointConnector(
      name: 'slotVariant',
      endpoint: endpoints['slotVariant']!,
      methodConnectors: {
        'getAll': _i1.MethodConnector(
          name: 'getAll',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['slotVariant'] as _i13.SlotVariantEndpoint)
                  .getAll(session),
        ),
        'getActive': _i1.MethodConnector(
          name: 'getActive',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['slotVariant'] as _i13.SlotVariantEndpoint)
                  .getActive(session),
        ),
        'getById': _i1.MethodConnector(
          name: 'getById',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['slotVariant'] as _i13.SlotVariantEndpoint).getById(
            session,
            params['id'],
          ),
        ),
        'create': _i1.MethodConnector(
          name: 'create',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'description': _i1.ParameterDescription(
              name: 'description',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'priceUsdCents': _i1.ParameterDescription(
              name: 'priceUsdCents',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'durationDays': _i1.ParameterDescription(
              name: 'durationDays',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'allowPaypal': _i1.ParameterDescription(
              name: 'allowPaypal',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
            'allowBitcoin': _i1.ParameterDescription(
              name: 'allowBitcoin',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
            'sortOrder': _i1.ParameterDescription(
              name: 'sortOrder',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['slotVariant'] as _i13.SlotVariantEndpoint).create(
            session,
            name: params['name'],
            description: params['description'],
            priceUsdCents: params['priceUsdCents'],
            durationDays: params['durationDays'],
            allowPaypal: params['allowPaypal'],
            allowBitcoin: params['allowBitcoin'],
            sortOrder: params['sortOrder'],
          ),
        ),
        'update': _i1.MethodConnector(
          name: 'update',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'description': _i1.ParameterDescription(
              name: 'description',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'priceUsdCents': _i1.ParameterDescription(
              name: 'priceUsdCents',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'durationDays': _i1.ParameterDescription(
              name: 'durationDays',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'allowPaypal': _i1.ParameterDescription(
              name: 'allowPaypal',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
            'allowBitcoin': _i1.ParameterDescription(
              name: 'allowBitcoin',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
            'isActive': _i1.ParameterDescription(
              name: 'isActive',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
            'sortOrder': _i1.ParameterDescription(
              name: 'sortOrder',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['slotVariant'] as _i13.SlotVariantEndpoint).update(
            session,
            id: params['id'],
            name: params['name'],
            description: params['description'],
            priceUsdCents: params['priceUsdCents'],
            durationDays: params['durationDays'],
            allowPaypal: params['allowPaypal'],
            allowBitcoin: params['allowBitcoin'],
            isActive: params['isActive'],
            sortOrder: params['sortOrder'],
          ),
        ),
        'delete': _i1.MethodConnector(
          name: 'delete',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['slotVariant'] as _i13.SlotVariantEndpoint).delete(
            session,
            params['id'],
          ),
        ),
      },
    );
    connectors['userSlot'] = _i1.EndpointConnector(
      name: 'userSlot',
      endpoint: endpoints['userSlot']!,
      methodConnectors: {
        'getMySlots': _i1.MethodConnector(
          name: 'getMySlots',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['userSlot'] as _i14.UserSlotEndpoint)
                  .getMySlots(session),
        ),
        'getAvailableSlots': _i1.MethodConnector(
          name: 'getAvailableSlots',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['userSlot'] as _i14.UserSlotEndpoint)
                  .getAvailableSlots(session),
        ),
        'getExpiringSoon': _i1.MethodConnector(
          name: 'getExpiringSoon',
          params: {
            'days': _i1.ParameterDescription(
              name: 'days',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['userSlot'] as _i14.UserSlotEndpoint).getExpiringSoon(
            session,
            days: params['days'],
          ),
        ),
        'createSlot': _i1.MethodConnector(
          name: 'createSlot',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'slotVariantId': _i1.ParameterDescription(
              name: 'slotVariantId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['userSlot'] as _i14.UserSlotEndpoint).createSlot(
            session,
            userId: params['userId'],
            slotVariantId: params['slotVariantId'],
          ),
        ),
        'extendSlot': _i1.MethodConnector(
          name: 'extendSlot',
          params: {
            'slotId': _i1.ParameterDescription(
              name: 'slotId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'additionalDays': _i1.ParameterDescription(
              name: 'additionalDays',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['userSlot'] as _i14.UserSlotEndpoint).extendSlot(
            session,
            slotId: params['slotId'],
            additionalDays: params['additionalDays'],
          ),
        ),
        'deactivateExpired': _i1.MethodConnector(
          name: 'deactivateExpired',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['userSlot'] as _i14.UserSlotEndpoint)
                  .deactivateExpired(session),
        ),
        'getSlotStats': _i1.MethodConnector(
          name: 'getSlotStats',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['userSlot'] as _i14.UserSlotEndpoint)
                  .getSlotStats(session),
        ),
        'createTestSlot': _i1.MethodConnector(
          name: 'createTestSlot',
          params: {
            'slotVariantId': _i1.ParameterDescription(
              name: 'slotVariantId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['userSlot'] as _i14.UserSlotEndpoint).createTestSlot(
            session,
            slotVariantId: params['slotVariantId'],
          ),
        ),
      },
    );
    connectors['greeting'] = _i1.EndpointConnector(
      name: 'greeting',
      endpoint: endpoints['greeting']!,
      methodConnectors: {
        'hello': _i1.MethodConnector(
          name: 'hello',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['greeting'] as _i15.GreetingEndpoint).hello(
            session,
            params['name'],
          ),
        )
      },
    );
    modules['serverpod_auth'] = _i21.Endpoints()..initializeEndpoints(server);
  }
}
