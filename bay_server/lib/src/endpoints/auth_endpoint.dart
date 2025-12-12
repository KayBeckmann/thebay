import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as auth;

import '../generated/protocol.dart';
import '../services/password_service.dart';

/// Authentication endpoint for user registration, login, and logout.
class AuthEndpoint extends Endpoint {
  // Rate limiting constants
  static const int _maxFailedAttempts = 3;
  static const int _firstLockoutSeconds = 60;
  static const int _secondLockoutSeconds = 600; // 10 minutes

  /// Register a new user account.
  Future<AuthResponse> register(
    Session session,
    RegistrationRequest request,
  ) async {
    // Validate terms acceptance
    if (!request.acceptedTerms) {
      return AuthResponse(
        success: false,
        errorMessage: 'You must accept the terms of service',
      );
    }

    // Validate username
    final usernameValidation = _validateUsername(request.username);
    if (!usernameValidation.isValid) {
      return AuthResponse(
        success: false,
        errorMessage: usernameValidation.error,
      );
    }

    // Validate password
    final passwordValidation =
        PasswordService.validatePassword(request.password);
    if (!passwordValidation.isValid) {
      return AuthResponse(
        success: false,
        errorMessage: passwordValidation.errors.join(', '),
      );
    }

    // Check if username already exists
    final existingUser = await User.db.findFirstRow(
      session,
      where: (t) => t.username.equals(request.username.toLowerCase()),
    );

    if (existingUser != null) {
      return AuthResponse(
        success: false,
        errorMessage: 'Username already taken',
      );
    }

    // Hash password
    final passwordHash = await PasswordService.hashPassword(request.password);

    // Create user
    final user = User(
      username: request.username.toLowerCase(),
      passwordHash: passwordHash,
      role: UserRole.user,
      createdAt: DateTime.now().toUtc(),
      acceptedTerms: true,
    );

    final insertedUser = await User.db.insertRow(session, user);

    // Create auth key using serverpod_auth
    final authKey = await auth.UserAuthentication.signInUser(
      session,
      insertedUser.id!,
      'custom',
      scopes: {Scope('user')},
    );

    return AuthResponse(
      success: true,
      userId: insertedUser.id,
      username: insertedUser.username,
      role: insertedUser.role,
      sessionKey: '${authKey.id}:${authKey.key}',
    );
  }

  /// Log in with username and password.
  Future<AuthResponse> login(
    Session session,
    LoginRequest request,
  ) async {
    // Find user by username
    final user = await User.db.findFirstRow(
      session,
      where: (t) => t.username.equals(request.username.toLowerCase()),
    );

    if (user == null) {
      return AuthResponse(
        success: false,
        errorMessage: 'Invalid username or password',
      );
    }

    // Check if account is active
    if (!user.isActive) {
      return AuthResponse(
        success: false,
        errorMessage: 'Account is suspended',
      );
    }

    // Check if account is locked out
    if (user.lockedUntil != null && user.lockedUntil!.isAfter(DateTime.now())) {
      final remainingSeconds =
          user.lockedUntil!.difference(DateTime.now()).inSeconds;
      return AuthResponse(
        success: false,
        errorMessage: 'Account temporarily locked. Try again later.',
        lockoutSeconds: remainingSeconds,
      );
    }

    // Verify password
    final isValid =
        await PasswordService.verifyPassword(request.password, user.passwordHash);

    if (!isValid) {
      // Increment failed attempts and potentially lock account
      await _handleFailedLogin(session, user);

      return AuthResponse(
        success: false,
        errorMessage: 'Invalid username or password',
      );
    }

    // Reset failed attempts on successful login
    await User.db.updateRow(
      session,
      user.copyWith(
        failedLoginAttempts: 0,
        lockedUntil: null,
        lastLoginAt: DateTime.now().toUtc(),
        stayLoggedIn: request.stayLoggedIn,
      ),
    );

    // Create auth key with appropriate scopes
    final authKey = await auth.UserAuthentication.signInUser(
      session,
      user.id!,
      'custom',
      scopes: {_getScopeForRole(user.role)},
    );

    return AuthResponse(
      success: true,
      userId: user.id,
      username: user.username,
      role: user.role,
      sessionKey: '${authKey.id}:${authKey.key}',
    );
  }

  /// Log out the current user.
  Future<bool> logout(Session session) async {
    final authInfo = await session.authenticated;
    if (authInfo == null) {
      return false;
    }

    await auth.UserAuthentication.signOutUser(session);
    return true;
  }

  /// Get the currently authenticated user's info.
  Future<AuthResponse> getCurrentUser(Session session) async {
    final authInfo = await session.authenticated;
    if (authInfo == null) {
      return AuthResponse(
        success: false,
        errorMessage: 'Not authenticated',
      );
    }

    final user = await User.db.findById(session, authInfo.userId);
    if (user == null) {
      return AuthResponse(
        success: false,
        errorMessage: 'User not found',
      );
    }

    return AuthResponse(
      success: true,
      userId: user.id,
      username: user.username,
      role: user.role,
    );
  }

  /// Change the current user's password.
  Future<AuthResponse> changePassword(
    Session session,
    String currentPassword,
    String newPassword,
  ) async {
    final authInfo = await session.authenticated;
    if (authInfo == null) {
      return AuthResponse(
        success: false,
        errorMessage: 'Not authenticated',
      );
    }

    final user = await User.db.findById(session, authInfo.userId);
    if (user == null) {
      return AuthResponse(
        success: false,
        errorMessage: 'User not found',
      );
    }

    // Verify current password
    final isValid = await PasswordService.verifyPassword(
      currentPassword,
      user.passwordHash,
    );

    if (!isValid) {
      return AuthResponse(
        success: false,
        errorMessage: 'Current password is incorrect',
      );
    }

    // Validate new password
    final validation = PasswordService.validatePassword(newPassword);
    if (!validation.isValid) {
      return AuthResponse(
        success: false,
        errorMessage: validation.errors.join(', '),
      );
    }

    // Hash and save new password
    final newHash = await PasswordService.hashPassword(newPassword);
    await User.db.updateRow(
      session,
      user.copyWith(passwordHash: newHash),
    );

    return AuthResponse(
      success: true,
      userId: user.id,
      username: user.username,
      role: user.role,
    );
  }

  /// Delete the current user's account.
  Future<AuthResponse> deleteAccount(
    Session session,
    String password,
  ) async {
    final authInfo = await session.authenticated;
    if (authInfo == null) {
      return AuthResponse(
        success: false,
        errorMessage: 'Not authenticated',
      );
    }

    final user = await User.db.findById(session, authInfo.userId);
    if (user == null) {
      return AuthResponse(
        success: false,
        errorMessage: 'User not found',
      );
    }

    // Prevent admin from deleting their own account
    if (user.role == UserRole.admin) {
      return AuthResponse(
        success: false,
        errorMessage: 'Admin accounts cannot be deleted through this method',
      );
    }

    // Verify password
    final isValid = await PasswordService.verifyPassword(
      password,
      user.passwordHash,
    );

    if (!isValid) {
      return AuthResponse(
        success: false,
        errorMessage: 'Password is incorrect',
      );
    }

    // Sign out and delete user
    await auth.UserAuthentication.signOutUser(session);
    await User.db.deleteRow(session, user);

    return AuthResponse(success: true);
  }

  // Helper methods

  /// Validates username requirements.
  _UsernameValidation _validateUsername(String username) {
    if (username.length < 3) {
      return _UsernameValidation(
        isValid: false,
        error: 'Username must be at least 3 characters',
      );
    }

    if (username.length > 20) {
      return _UsernameValidation(
        isValid: false,
        error: 'Username must be at most 20 characters',
      );
    }

    if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(username)) {
      return _UsernameValidation(
        isValid: false,
        error: 'Username can only contain letters, numbers, and underscores',
      );
    }

    return _UsernameValidation(isValid: true);
  }

  /// Handles failed login attempts and rate limiting.
  Future<void> _handleFailedLogin(Session session, User user) async {
    final newAttempts = user.failedLoginAttempts + 1;
    DateTime? lockUntil;

    if (newAttempts >= _maxFailedAttempts * 2) {
      // Second lockout: 10 minutes
      lockUntil = DateTime.now().add(Duration(seconds: _secondLockoutSeconds));
    } else if (newAttempts >= _maxFailedAttempts) {
      // First lockout: 60 seconds
      lockUntil = DateTime.now().add(Duration(seconds: _firstLockoutSeconds));
    }

    await User.db.updateRow(
      session,
      user.copyWith(
        failedLoginAttempts: newAttempts,
        lockedUntil: lockUntil,
      ),
    );
  }

  /// Returns the appropriate scope for a user role.
  Scope _getScopeForRole(UserRole role) {
    switch (role) {
      case UserRole.admin:
        return Scope('admin');
      case UserRole.moderator:
        return Scope('moderator');
      case UserRole.user:
        return Scope('user');
    }
  }
}

class _UsernameValidation {
  final bool isValid;
  final String? error;

  _UsernameValidation({required this.isValid, this.error});
}
