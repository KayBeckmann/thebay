import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Base endpoint with role-based access control helpers.
abstract class AuthenticatedEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  /// Gets the current authenticated user from the database.
  Future<User?> getAuthenticatedUser(Session session) async {
    final authInfo = await session.authenticated;
    if (authInfo == null) return null;

    return await User.db.findById(session, authInfo.userId);
  }

  /// Throws an exception if the user is not authenticated.
  Future<User> requireUser(Session session) async {
    final user = await getAuthenticatedUser(session);
    if (user == null) {
      throw AuthenticationException('Not authenticated');
    }
    return user;
  }

  /// Throws an exception if the user is not an admin.
  Future<User> requireAdmin(Session session) async {
    final user = await requireUser(session);
    if (user.role != UserRole.admin) {
      throw AuthorizationException('Admin access required');
    }
    return user;
  }

  /// Throws an exception if the user is not a moderator or admin.
  Future<User> requireModerator(Session session) async {
    final user = await requireUser(session);
    if (user.role != UserRole.admin && user.role != UserRole.moderator) {
      throw AuthorizationException('Moderator access required');
    }
    return user;
  }

  /// Checks if the current user has admin role.
  Future<bool> isAdmin(Session session) async {
    final user = await getAuthenticatedUser(session);
    return user?.role == UserRole.admin;
  }

  /// Checks if the current user has moderator or admin role.
  Future<bool> isModerator(Session session) async {
    final user = await getAuthenticatedUser(session);
    return user?.role == UserRole.admin || user?.role == UserRole.moderator;
  }
}

/// Exception thrown when authentication fails.
class AuthenticationException implements Exception {
  final String message;
  AuthenticationException(this.message);

  @override
  String toString() => 'AuthenticationException: $message';
}

/// Exception thrown when authorization fails.
class AuthorizationException implements Exception {
  final String message;
  AuthorizationException(this.message);

  @override
  String toString() => 'AuthorizationException: $message';
}

/// Endpoint that requires admin access.
abstract class AdminEndpoint extends AuthenticatedEndpoint {
  @override
  Set<Scope> get requiredScopes => {Scope('admin')};
}

/// Endpoint that requires moderator or admin access.
abstract class ModeratorEndpoint extends AuthenticatedEndpoint {
  @override
  Set<Scope> get requiredScopes => {Scope('moderator'), Scope('admin')};
}
