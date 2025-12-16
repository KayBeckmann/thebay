import 'package:bay_client/bay_client.dart';
import 'package:flutter/material.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';

import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/main_shell.dart';
import 'services/auth_service.dart';
import 'services/pgp_key_service.dart';
import 'services/message_service.dart';
import 'theme/app_theme.dart';

/// Global client object for server communication.
late final Client client;

/// Global auth service for authentication management.
late final AuthService authService;

/// Global PGP key service for encryption management.
late final PgpKeyService pgpKeyService;

/// Global message service for encrypted messaging.
late final MessageService messageService;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Server URL configuration
  // Set via: flutter run --dart-define=SERVER_URL=https://api.example.com/
  const serverUrlFromEnv = String.fromEnvironment('SERVER_URL');
  final serverUrl =
      serverUrlFromEnv.isEmpty ? 'http://$localhost:8080/' : serverUrlFromEnv;

  // Initialize client with authentication key manager
  client = Client(
    serverUrl,
    authenticationKeyManager: FlutterAuthenticationKeyManager(),
  )..connectivityMonitor = FlutterConnectivityMonitor();

  // Initialize auth service
  authService = AuthService(client);

  // Initialize PGP key service
  pgpKeyService = PgpKeyService(client);
  await pgpKeyService.initialize();

  // Initialize message service
  messageService = MessageService(client, pgpKeyService);

  runApp(const BayApp());
}

/// Main application widget.
class BayApp extends StatelessWidget {
  const BayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bay',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const AuthWrapper(),
    );
  }
}

/// Wrapper widget that handles authentication state and navigation.
class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  bool _isLoading = true;
  bool _isAuthenticated = false;
  bool _showLogin = true;

  @override
  void initState() {
    super.initState();
    _initializeAuth();
  }

  Future<void> _initializeAuth() async {
    await authService.initialize();

    if (mounted) {
      setState(() {
        _isLoading = false;
        _isAuthenticated = authService.isAuthenticated;
      });
    }
  }

  void _handleLoginSuccess() {
    setState(() {
      _isAuthenticated = true;
    });
  }

  void _handleLogout() {
    setState(() {
      _isAuthenticated = false;
      _showLogin = true;
    });
  }

  void _navigateToRegister() {
    setState(() {
      _showLogin = false;
    });
  }

  void _navigateToLogin() {
    setState(() {
      _showLogin = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_isAuthenticated) {
      return MainShell(
        authService: authService,
        pgpKeyService: pgpKeyService,
        messageService: messageService,
        onLogout: _handleLogout,
      );
    }

    if (_showLogin) {
      return LoginScreen(
        authService: authService,
        onLoginSuccess: _handleLoginSuccess,
        onNavigateToRegister: _navigateToRegister,
      );
    }

    return RegisterScreen(
      authService: authService,
      pgpKeyService: pgpKeyService,
      onRegisterSuccess: _handleLoginSuccess,
      onNavigateToLogin: _navigateToLogin,
    );
  }
}
