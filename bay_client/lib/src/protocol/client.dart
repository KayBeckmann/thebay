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
import 'package:bay_client/src/protocol/greeting.dart' as _i6;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i7;
import 'protocol.dart' as _i8;

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

/// This is an example endpoint that returns a greeting message through
/// its [hello] method.
/// {@category Endpoint}
class EndpointGreeting extends _i1.EndpointRef {
  EndpointGreeting(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'greeting';

  /// Returns a personalized greeting message: "Hello {name}".
  _i2.Future<_i6.Greeting> hello(String name) =>
      caller.callServerEndpoint<_i6.Greeting>(
        'greeting',
        'hello',
        {'name': name},
      );
}

class Modules {
  Modules(Client client) {
    auth = _i7.Caller(client);
  }

  late final _i7.Caller auth;
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
          _i8.Protocol(),
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
    greeting = EndpointGreeting(this);
    modules = Modules(this);
  }

  late final EndpointAuth auth;

  late final EndpointGreeting greeting;

  late final Modules modules;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
        'auth': auth,
        'greeting': greeting,
      };

  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup =>
      {'auth': modules.auth};
}
