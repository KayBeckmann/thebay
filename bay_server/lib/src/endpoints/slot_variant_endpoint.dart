import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Endpoint for managing slot variants.
/// Most operations require admin privileges.
class SlotVariantEndpoint extends Endpoint {
  /// Get all slot variants (admin only).
  Future<List<SlotVariant>> getAll(Session session) async {
    if (!await _isAdmin(session)) {
      return [];
    }

    return await SlotVariant.db.find(
      session,
      orderBy: (t) => t.sortOrder,
    );
  }

  /// Get only active slot variants (public).
  /// Free promotional slots are excluded from this list.
  Future<List<SlotVariant>> getActive(Session session) async {
    return await SlotVariant.db.find(
      session,
      where: (t) => t.isActive.equals(true) & t.isFree.equals(false),
      orderBy: (t) => t.sortOrder,
    );
  }

  /// Get all free slot variants (admin only).
  /// These are used for promotional purposes.
  Future<List<SlotVariant>> getFreeVariants(Session session) async {
    if (!await _isAdmin(session)) {
      return [];
    }

    return await SlotVariant.db.find(
      session,
      where: (t) => t.isFree.equals(true),
      orderBy: (t) => t.sortOrder,
    );
  }

  /// Get a single slot variant by ID (public).
  Future<SlotVariant?> getById(Session session, int id) async {
    return await SlotVariant.db.findById(session, id);
  }

  /// Create a new slot variant (admin only).
  Future<SlotVariant?> create(
    Session session, {
    required String name,
    String? description,
    required int priceUsdCents,
    required int durationDays,
    required bool allowPaypal,
    required bool allowBitcoin,
    required int sortOrder,
    bool isFree = false,
  }) async {
    // Check admin permission
    if (!await _isAdmin(session)) {
      return null;
    }

    // Validate at least one payment method (not required for free slots)
    if (!isFree && !allowPaypal && !allowBitcoin) {
      return null;
    }

    // Validate price and duration
    if (!isFree && priceUsdCents < 0) {
      return null;
    }
    if (durationDays <= 0) {
      return null;
    }

    final now = DateTime.now();
    final variant = SlotVariant(
      name: name,
      description: description,
      priceUsdCents: isFree ? 0 : priceUsdCents,
      durationDays: durationDays,
      allowPaypal: allowPaypal,
      allowBitcoin: allowBitcoin,
      isActive: true,
      isFree: isFree,
      sortOrder: sortOrder,
      createdAt: now,
      updatedAt: now,
    );

    return await SlotVariant.db.insertRow(session, variant);
  }

  /// Update a slot variant (admin only).
  Future<SlotVariant?> update(
    Session session, {
    required int id,
    required String name,
    String? description,
    required int priceUsdCents,
    required int durationDays,
    required bool allowPaypal,
    required bool allowBitcoin,
    required bool isActive,
    required bool isFree,
    required int sortOrder,
  }) async {
    // Check admin permission
    if (!await _isAdmin(session)) {
      return null;
    }

    final variant = await SlotVariant.db.findById(session, id);
    if (variant == null) {
      return null;
    }

    // Validate at least one payment method (not required for free slots)
    if (!isFree && !allowPaypal && !allowBitcoin) {
      return null;
    }

    // Validate price and duration
    if (!isFree && priceUsdCents < 0) {
      return null;
    }
    if (durationDays <= 0) {
      return null;
    }

    variant.name = name;
    variant.description = description;
    variant.priceUsdCents = isFree ? 0 : priceUsdCents;
    variant.durationDays = durationDays;
    variant.allowPaypal = allowPaypal;
    variant.allowBitcoin = allowBitcoin;
    variant.isActive = isActive;
    variant.isFree = isFree;
    variant.sortOrder = sortOrder;
    variant.updatedAt = DateTime.now();

    return await SlotVariant.db.updateRow(session, variant);
  }

  /// Delete a slot variant (admin only).
  Future<bool> delete(Session session, int id) async {
    // Check admin permission
    if (!await _isAdmin(session)) {
      return false;
    }

    final variant = await SlotVariant.db.findById(session, id);
    if (variant == null) {
      return false;
    }

    // TODO: Check if any active slots use this variant before deleting

    await SlotVariant.db.deleteRow(session, variant);
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
