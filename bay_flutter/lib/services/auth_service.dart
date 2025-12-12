import 'package:bay_client/bay_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Service for managing authentication state and session persistence.
class AuthService {
  static const String _sessionKeyPref = 'session_key';
  static const String _userIdPref = 'user_id';
  static const String _usernamePref = 'username';
  static const String _userRolePref = 'user_role';

  final Client _client;

  AuthResponse? _currentUser;
  bool _isInitialized = false;

  AuthService(this._client);

  /// Whether the user is currently authenticated.
  bool get isAuthenticated => _currentUser?.success == true;

  /// The current authenticated user info.
  AuthResponse? get currentUser => _currentUser;

  /// Initialize the auth service and restore session if available.
  Future<void> initialize() async {
    if (_isInitialized) return;

    final prefs = await SharedPreferences.getInstance();
    final sessionKey = prefs.getString(_sessionKeyPref);

    if (sessionKey != null) {
      // Try to restore session
      try {
        _client.authenticationKeyManager?.put(sessionKey);
        final response = await _client.auth.getCurrentUser();
        if (response.success) {
          _currentUser = response;
        } else {
          // Session expired, clear stored data
          await _clearStoredSession();
        }
      } catch (e) {
        // Session invalid, clear stored data
        await _clearStoredSession();
      }
    }

    _isInitialized = true;
  }

  /// Register a new user account.
  Future<AuthResponse> register({
    required String username,
    required String password,
    required bool acceptedTerms,
  }) async {
    final request = RegistrationRequest(
      username: username,
      password: password,
      acceptedTerms: acceptedTerms,
    );

    final response = await _client.auth.register(request);

    if (response.success && response.sessionKey != null) {
      await _storeSession(response);
      _currentUser = response;
    }

    return response;
  }

  /// Log in with username and password.
  Future<AuthResponse> login({
    required String username,
    required String password,
    bool stayLoggedIn = false,
  }) async {
    final request = LoginRequest(
      username: username,
      password: password,
      stayLoggedIn: stayLoggedIn,
    );

    final response = await _client.auth.login(request);

    if (response.success && response.sessionKey != null) {
      await _storeSession(response);
      _currentUser = response;
    }

    return response;
  }

  /// Log out the current user.
  Future<void> logout() async {
    try {
      await _client.auth.logout();
    } catch (e) {
      // Ignore errors during logout
    }

    await _clearStoredSession();
    _currentUser = null;
  }

  /// Change the current user's password.
  Future<AuthResponse> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    return await _client.auth.changePassword(currentPassword, newPassword);
  }

  /// Delete the current user's account.
  Future<AuthResponse> deleteAccount(String password) async {
    final response = await _client.auth.deleteAccount(password);

    if (response.success) {
      await _clearStoredSession();
      _currentUser = null;
    }

    return response;
  }

  /// Store session data for persistence.
  Future<void> _storeSession(AuthResponse response) async {
    final prefs = await SharedPreferences.getInstance();

    if (response.sessionKey != null) {
      await prefs.setString(_sessionKeyPref, response.sessionKey!);
      _client.authenticationKeyManager?.put(response.sessionKey!);
    }
    if (response.userId != null) {
      await prefs.setInt(_userIdPref, response.userId!);
    }
    if (response.username != null) {
      await prefs.setString(_usernamePref, response.username!);
    }
    if (response.role != null) {
      await prefs.setInt(_userRolePref, response.role!.index);
    }
  }

  /// Clear stored session data.
  Future<void> _clearStoredSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_sessionKeyPref);
    await prefs.remove(_userIdPref);
    await prefs.remove(_usernamePref);
    await prefs.remove(_userRolePref);
    _client.authenticationKeyManager?.remove();
  }
}
