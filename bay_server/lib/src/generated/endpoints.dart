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
import '../endpoints/news_endpoint.dart' as _i4;
import '../endpoints/settings_endpoint.dart' as _i5;
import '../endpoints/slot_variant_endpoint.dart' as _i6;
import '../greeting_endpoint.dart' as _i7;
import 'package:bay_server/src/generated/registration_request.dart' as _i8;
import 'package:bay_server/src/generated/login_request.dart' as _i9;
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as _i10;

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
      'news': _i4.NewsEndpoint()
        ..initialize(
          server,
          'news',
          null,
        ),
      'settings': _i5.SettingsEndpoint()
        ..initialize(
          server,
          'settings',
          null,
        ),
      'slotVariant': _i6.SlotVariantEndpoint()
        ..initialize(
          server,
          'slotVariant',
          null,
        ),
      'greeting': _i7.GreetingEndpoint()
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
              type: _i1.getType<_i8.RegistrationRequest>(),
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
              type: _i1.getType<_i9.LoginRequest>(),
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
              (endpoints['news'] as _i4.NewsEndpoint).getPublished(session),
        ),
        'getAll': _i1.MethodConnector(
          name: 'getAll',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['news'] as _i4.NewsEndpoint).getAll(session),
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
              (endpoints['news'] as _i4.NewsEndpoint).getById(
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
              (endpoints['news'] as _i4.NewsEndpoint).create(
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
              (endpoints['news'] as _i4.NewsEndpoint).update(
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
              (endpoints['news'] as _i4.NewsEndpoint).delete(
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
              (endpoints['news'] as _i4.NewsEndpoint).deleteExpired(session),
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
              (endpoints['settings'] as _i5.SettingsEndpoint).get(
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
              (endpoints['settings'] as _i5.SettingsEndpoint).getMultiple(
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
              (endpoints['settings'] as _i5.SettingsEndpoint).set(
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
              (endpoints['settings'] as _i5.SettingsEndpoint).delete(
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
              (endpoints['settings'] as _i5.SettingsEndpoint)
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
              (endpoints['settings'] as _i5.SettingsEndpoint)
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
              (endpoints['slotVariant'] as _i6.SlotVariantEndpoint)
                  .getAll(session),
        ),
        'getActive': _i1.MethodConnector(
          name: 'getActive',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['slotVariant'] as _i6.SlotVariantEndpoint)
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
              (endpoints['slotVariant'] as _i6.SlotVariantEndpoint).getById(
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
              (endpoints['slotVariant'] as _i6.SlotVariantEndpoint).create(
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
              (endpoints['slotVariant'] as _i6.SlotVariantEndpoint).update(
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
              (endpoints['slotVariant'] as _i6.SlotVariantEndpoint).delete(
            session,
            params['id'],
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
              (endpoints['greeting'] as _i7.GreetingEndpoint).hello(
            session,
            params['name'],
          ),
        )
      },
    );
    modules['serverpod_auth'] = _i10.Endpoints()..initializeEndpoints(server);
  }
}
