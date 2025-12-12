import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Endpoint for managing news articles.
/// Admin can create/edit/delete, users can read published news.
class NewsEndpoint extends Endpoint {
  /// Default news lifetime in days.
  static const int defaultLifetimeDays = 14;

  /// Get all published and non-expired news (public).
  Future<List<News>> getPublished(Session session) async {
    final now = DateTime.now();

    // Get published news that either have no expiration or haven't expired yet
    final allPublished = await News.db.find(
      session,
      where: (t) => t.isPublished.equals(true),
      orderBy: (t) => t.publishedAt,
      orderDescending: true,
    );

    // Filter out expired news
    return allPublished.where((news) {
      if (news.expiresAt == null) return true;
      return news.expiresAt!.isAfter(now);
    }).toList();
  }

  /// Get all news including unpublished (admin only).
  Future<List<News>> getAll(Session session) async {
    if (!await _isAdmin(session)) {
      return [];
    }

    return await News.db.find(
      session,
      orderBy: (t) => t.createdAt,
      orderDescending: true,
    );
  }

  /// Get a single news article by ID.
  Future<News?> getById(Session session, int id) async {
    final news = await News.db.findById(session, id);

    // Non-admins can only see published news
    if (news != null && !news.isPublished) {
      if (!await _isAdmin(session)) {
        return null;
      }
    }

    return news;
  }

  /// Create a new news article (admin only).
  Future<News?> create(
    Session session, {
    required String title,
    required String content,
    bool publish = false,
    int? lifetimeDays,
  }) async {
    // Check admin permission
    final authInfo = await session.authenticated;
    if (authInfo == null || !await _isAdmin(session)) {
      return null;
    }
    final userId = authInfo.userId;

    final now = DateTime.now();
    DateTime? expiresAt;

    if (lifetimeDays != null && lifetimeDays > 0) {
      expiresAt = now.add(Duration(days: lifetimeDays));
    } else {
      // Use default lifetime
      expiresAt = now.add(const Duration(days: defaultLifetimeDays));
    }

    final news = News(
      title: title,
      content: content,
      authorId: userId,
      isPublished: publish,
      publishedAt: publish ? now : null,
      expiresAt: expiresAt,
      createdAt: now,
      updatedAt: now,
    );

    return await News.db.insertRow(session, news);
  }

  /// Update a news article (admin only).
  Future<News?> update(
    Session session, {
    required int id,
    required String title,
    required String content,
    required bool isPublished,
    DateTime? expiresAt,
  }) async {
    // Check admin permission
    if (!await _isAdmin(session)) {
      return null;
    }

    final news = await News.db.findById(session, id);
    if (news == null) {
      return null;
    }

    final now = DateTime.now();

    // Set publishedAt if publishing for the first time
    if (isPublished && !news.isPublished) {
      news.publishedAt = now;
    }

    news.title = title;
    news.content = content;
    news.isPublished = isPublished;
    news.expiresAt = expiresAt;
    news.updatedAt = now;

    return await News.db.updateRow(session, news);
  }

  /// Delete a news article (admin only).
  Future<bool> delete(Session session, int id) async {
    // Check admin permission
    if (!await _isAdmin(session)) {
      return false;
    }

    final news = await News.db.findById(session, id);
    if (news == null) {
      return false;
    }

    await News.db.deleteRow(session, news);
    return true;
  }

  /// Delete all expired news (called by cron job).
  /// Returns the number of deleted articles.
  Future<int> deleteExpired(Session session) async {
    // This should be called internally, but we check admin anyway
    if (!await _isAdmin(session)) {
      return 0;
    }

    final now = DateTime.now();

    // Get all news with expiration date set
    final newsWithExpiry = await News.db.find(
      session,
      where: (t) => t.expiresAt.notEquals(null),
    );

    // Filter to expired ones and delete
    int deletedCount = 0;
    for (final news in newsWithExpiry) {
      if (news.expiresAt != null && news.expiresAt!.isBefore(now)) {
        await News.db.deleteRow(session, news);
        deletedCount++;
      }
    }

    return deletedCount;
  }

  /// Check if current user is admin.
  Future<bool> _isAdmin(Session session) async {
    final authInfo = await session.authenticated;
    if (authInfo == null) return false;

    final user = await User.db.findById(session, authInfo.userId);
    return user?.role == UserRole.admin;
  }
}
