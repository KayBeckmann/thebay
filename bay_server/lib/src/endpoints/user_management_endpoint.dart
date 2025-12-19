import 'package:serverpod/serverpod.dart' hide Transaction;

import '../generated/protocol.dart';
import 'base_endpoint.dart';

/// Endpoint for user management (admin only)
class UserManagementEndpoint extends AuthenticatedEndpoint {
  /// Get all users with optional filters
  Future<List<User>> getAllUsers(
    Session session, {
    String? searchQuery,
    UserRole? role,
    bool? isBanned,
    int? limit,
    int? offset,
  }) async {
    await requireAdmin(session);

    // Fetch all users
    var allUsers = await User.db.find(
      session,
      orderBy: (t) => t.createdAt,
      orderDescending: true,
    );

    // Apply filters
    var filtered = allUsers;

    if (searchQuery != null && searchQuery.isNotEmpty) {
      final query = searchQuery.toLowerCase();
      filtered = filtered
          .where((u) => u.username.toLowerCase().contains(query))
          .toList();
    }

    if (role != null) {
      filtered = filtered.where((u) => u.role == role).toList();
    }

    if (isBanned != null) {
      filtered = filtered.where((u) => u.isBanned == isBanned).toList();
    }

    // Apply pagination
    if (offset != null) {
      filtered = filtered.skip(offset).toList();
    }
    if (limit != null) {
      filtered = filtered.take(limit).toList();
    }

    return filtered;
  }

  /// Get a user by ID
  Future<User?> getUserById(Session session, int userId) async {
    await requireAdmin(session);
    return await User.db.findById(session, userId);
  }

  /// Update user role
  Future<User> updateUserRole(
    Session session,
    int userId,
    UserRole newRole,
  ) async {
    final admin = await requireAdmin(session);

    // Cannot change your own role
    if (userId == admin.id) {
      throw Exception('You cannot change your own role');
    }

    final user = await User.db.findById(session, userId);
    if (user == null) {
      throw Exception('User not found');
    }

    final updated = user.copyWith(role: newRole);
    return await User.db.updateRow(session, updated);
  }

  /// Ban a user
  Future<User> banUser(
    Session session,
    int userId,
    String reason,
  ) async {
    final admin = await requireAdmin(session);

    // Cannot ban yourself
    if (userId == admin.id) {
      throw Exception('You cannot ban yourself');
    }

    final user = await User.db.findById(session, userId);
    if (user == null) {
      throw Exception('User not found');
    }

    if (user.isBanned) {
      throw Exception('User is already banned');
    }

    // Update user
    final updated = user.copyWith(
      isBanned: true,
      bannedAt: DateTime.now(),
      bannedReason: reason,
      bannedBy: admin.id,
      isActive: false,
    );
    await User.db.updateRow(session, updated);

    // Create ban log entry
    final logEntry = UserBanLog(
      userId: userId,
      adminId: admin.id!,
      action: 'ban',
      reason: reason,
      createdAt: DateTime.now(),
    );
    await UserBanLog.db.insertRow(session, logEntry);

    // Deactivate all user's listings
    final listings = await Listing.db.find(
      session,
      where: (t) => t.userId.equals(userId) & t.isActive.equals(true),
    );

    for (final listing in listings) {
      final deactivated = listing.copyWith(isActive: false);
      await Listing.db.updateRow(session, deactivated);
    }

    // Cancel all open transactions where user is buyer or seller
    final openTransactions = await Transaction.db.find(
      session,
      where: (t) =>
          (t.buyerId.equals(userId) | t.sellerId.equals(userId)) &
          t.status.equals(TransactionStatus.open),
    );

    for (final transaction in openTransactions) {
      final cancelled = transaction.copyWith(
        status: TransactionStatus.cancelled,
        updatedAt: DateTime.now(),
      );
      await Transaction.db.updateRow(session, cancelled);
    }

    return updated;
  }

  /// Unban a user
  Future<User> unbanUser(
    Session session,
    int userId,
    String? reason,
  ) async {
    final admin = await requireAdmin(session);

    final user = await User.db.findById(session, userId);
    if (user == null) {
      throw Exception('User not found');
    }

    if (!user.isBanned) {
      throw Exception('User is not banned');
    }

    // Update user
    final updated = user.copyWith(
      isBanned: false,
      bannedAt: null,
      bannedReason: null,
      bannedBy: null,
      isActive: true,
    );
    await User.db.updateRow(session, updated);

    // Create ban log entry
    final logEntry = UserBanLog(
      userId: userId,
      adminId: admin.id!,
      action: 'unban',
      reason: reason,
      createdAt: DateTime.now(),
    );
    await UserBanLog.db.insertRow(session, logEntry);

    return updated;
  }

  /// Get all banned users
  Future<List<User>> getBannedUsers(Session session) async {
    await requireAdmin(session);

    return await User.db.find(
      session,
      where: (t) => t.isBanned.equals(true),
      orderBy: (t) => t.bannedAt,
      orderDescending: true,
    );
  }

  /// Get ban history for a user
  Future<List<UserBanLog>> getBanHistory(
    Session session,
    int userId,
  ) async {
    await requireAdmin(session);

    return await UserBanLog.db.find(
      session,
      where: (t) => t.userId.equals(userId),
      orderBy: (t) => t.createdAt,
      orderDescending: true,
    );
  }

  /// Get count of users by role
  Future<Map<String, int>> getUserCountByRole(Session session) async {
    await requireAdmin(session);

    final allUsers = await User.db.find(session);

    return {
      'total': allUsers.length,
      'users': allUsers.where((u) => u.role == UserRole.user).length,
      'moderators':
          allUsers.where((u) => u.role == UserRole.moderator).length,
      'admins': allUsers.where((u) => u.role == UserRole.admin).length,
      'banned': allUsers.where((u) => u.isBanned).length,
    };
  }

  /// Get count of total users
  Future<int> getTotalUserCount(Session session) async {
    await requireAdmin(session);
    return await User.db.count(session);
  }
}
