import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Endpoint for managing categories.
/// Most operations require admin privileges.
class CategoryEndpoint extends Endpoint {
  /// Get all categories (public).
  Future<List<Category>> getAll(Session session) async {
    return await Category.db.find(
      session,
      orderBy: (t) => t.sortOrder,
    );
  }

  /// Get only active categories (public).
  Future<List<Category>> getActive(Session session) async {
    return await Category.db.find(
      session,
      where: (t) => t.isActive.equals(true),
      orderBy: (t) => t.sortOrder,
    );
  }

  /// Get root categories (no parent).
  Future<List<Category>> getRootCategories(Session session) async {
    return await Category.db.find(
      session,
      where: (t) => t.parentId.equals(null) & t.isActive.equals(true),
      orderBy: (t) => t.sortOrder,
    );
  }

  /// Get subcategories for a parent category.
  Future<List<Category>> getSubcategories(
    Session session,
    int parentId,
  ) async {
    return await Category.db.find(
      session,
      where: (t) => t.parentId.equals(parentId) & t.isActive.equals(true),
      orderBy: (t) => t.sortOrder,
    );
  }

  /// Create a new category (admin only).
  Future<Category?> create(
    Session session,
    String name,
    int? parentId,
    int sortOrder,
  ) async {
    // Check admin permission
    if (!await _isAdmin(session)) {
      return null;
    }

    // Validate parent exists if provided
    if (parentId != null) {
      final parent = await Category.db.findById(session, parentId);
      if (parent == null) {
        return null;
      }
    }

    final now = DateTime.now();
    final category = Category(
      name: name,
      parentId: parentId,
      sortOrder: sortOrder,
      isActive: true,
      createdAt: now,
      updatedAt: now,
    );

    return await Category.db.insertRow(session, category);
  }

  /// Update a category (admin only).
  Future<Category?> update(
    Session session,
    int id,
    String name,
    int? parentId,
    int sortOrder,
    bool isActive,
  ) async {
    // Check admin permission
    if (!await _isAdmin(session)) {
      return null;
    }

    final category = await Category.db.findById(session, id);
    if (category == null) {
      return null;
    }

    // Prevent circular reference
    if (parentId == id) {
      return null;
    }

    // Validate parent exists if provided
    if (parentId != null) {
      final parent = await Category.db.findById(session, parentId);
      if (parent == null) {
        return null;
      }
    }

    category.name = name;
    category.parentId = parentId;
    category.sortOrder = sortOrder;
    category.isActive = isActive;
    category.updatedAt = DateTime.now();

    return await Category.db.updateRow(session, category);
  }

  /// Delete a category (admin only).
  /// Also deletes all subcategories.
  Future<bool> delete(Session session, int id) async {
    // Check admin permission
    if (!await _isAdmin(session)) {
      return false;
    }

    final category = await Category.db.findById(session, id);
    if (category == null) {
      return false;
    }

    // Delete subcategories first
    final subcategories = await Category.db.find(
      session,
      where: (t) => t.parentId.equals(id),
    );

    for (final sub in subcategories) {
      await delete(session, sub.id!);
    }

    // Delete the category
    await Category.db.deleteRow(session, category);
    return true;
  }

  /// Check if current user is admin.
  Future<bool> _isAdmin(Session session) async {
    final authInfo = await session.authenticated;
    if (authInfo == null) return false;

    final user = await User.db.findById(session, authInfo.userId);
    return user?.role == UserRole.admin;
  }
}
