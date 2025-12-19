import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'base_endpoint.dart';

/// Endpoint for reporting listings and users
class ReportEndpoint extends AuthenticatedEndpoint {
  /// Create a report for a listing
  Future<Report> createListingReport(
    Session session,
    int listingId,
    ReportReason reason,
    String? details,
  ) async {
    final user = await requireUser(session);

    // Check if listing exists
    final listing = await Listing.db.findById(session, listingId);
    if (listing == null) {
      throw Exception('Listing not found');
    }

    // Check if user already reported this listing
    final existing = await Report.db.find(
      session,
      where: (t) =>
          t.reporterId.equals(user.id!) &
          t.targetType.equals(ReportTargetType.listing) &
          t.targetId.equals(listingId),
      limit: 1,
    );

    if (existing.isNotEmpty) {
      throw Exception('You have already reported this listing');
    }

    // Create report
    final report = Report(
      reporterId: user.id!,
      targetType: ReportTargetType.listing,
      targetId: listingId,
      reason: reason,
      details: details,
      status: ReportStatus.open,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    return await Report.db.insertRow(session, report);
  }

  /// Create a report for a user
  Future<Report> createUserReport(
    Session session,
    int userId,
    ReportReason reason,
    String? details,
  ) async {
    final user = await requireUser(session);

    // Cannot report yourself
    if (userId == user.id) {
      throw Exception('You cannot report yourself');
    }

    // Check if reported user exists
    final reportedUser = await User.db.findById(session, userId);
    if (reportedUser == null) {
      throw Exception('User not found');
    }

    // Check if user already reported this user
    final existing = await Report.db.find(
      session,
      where: (t) =>
          t.reporterId.equals(user.id!) &
          t.targetType.equals(ReportTargetType.user) &
          t.targetId.equals(userId),
      limit: 1,
    );

    if (existing.isNotEmpty) {
      throw Exception('You have already reported this user');
    }

    // Create report
    final report = Report(
      reporterId: user.id!,
      targetType: ReportTargetType.user,
      targetId: userId,
      reason: reason,
      details: details,
      status: ReportStatus.open,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    return await Report.db.insertRow(session, report);
  }

  /// Get reports created by the current user
  Future<List<Report>> getMyReports(Session session) async {
    final user = await requireUser(session);

    return await Report.db.find(
      session,
      where: (t) => t.reporterId.equals(user.id!),
      orderBy: (t) => t.createdAt,
      orderDescending: true,
    );
  }

  /// Get a report by ID
  /// Only accessible by the reporter, assigned moderator, or admins
  Future<Report?> getById(Session session, int reportId) async {
    final user = await requireUser(session);
    final report = await Report.db.findById(session, reportId);

    if (report == null) return null;

    // Check access: reporter, assigned moderator, or admin/moderator
    final hasAccess = report.reporterId == user.id! ||
        report.assignedModeratorId == user.id ||
        user.role == UserRole.admin ||
        user.role == UserRole.moderator;

    if (!hasAccess) {
      throw AuthorizationException('Access denied to this report');
    }

    return report;
  }

  /// Get count of reports created by current user
  Future<int> getMyReportCount(Session session) async {
    final user = await requireUser(session);

    return await Report.db.count(
      session,
      where: (t) => t.reporterId.equals(user.id!),
    );
  }

  /// Delete a report (only by the reporter if status is still 'open')
  Future<bool> deleteReport(Session session, int reportId) async {
    final user = await requireUser(session);
    final report = await Report.db.findById(session, reportId);

    if (report == null) {
      throw Exception('Report not found');
    }

    // Only reporter can delete, and only if status is open
    if (report.reporterId != user.id!) {
      throw AuthorizationException('Only the reporter can delete this report');
    }

    if (report.status != ReportStatus.open) {
      throw Exception('Cannot delete report that is being reviewed or resolved');
    }

    await Report.db.deleteRow(session, report);
    return true;
  }

  // ========== Moderator Functions ==========

  /// Get all open reports (for moderators/admins)
  Future<List<Report>> getOpenReports(
    Session session, {
    ReportTargetType? targetType,
    int? limit,
    int? offset,
  }) async {
    await requireModerator(session);

    var query = Report.db.find(
      session,
      where: (t) {
        var condition = t.status.equals(ReportStatus.open);
        if (targetType != null) {
          condition = condition & t.targetType.equals(targetType);
        }
        return condition;
      },
      orderBy: (t) => t.createdAt,
      orderDescending: true,
    );

    if (limit != null) {
      query = query.then((results) => results.take(limit).toList());
    }

    return query;
  }

  /// Get all reports with any status (for moderators/admins)
  Future<List<Report>> getAllReports(
    Session session, {
    ReportTargetType? targetType,
    ReportStatus? status,
    int? limit,
    int? offset,
  }) async {
    await requireModerator(session);

    // Fetch all reports with optional filters
    final allReports = await Report.db.find(
      session,
      orderBy: (t) => t.createdAt,
      orderDescending: true,
    );

    // Apply filters in Dart if specified
    var filtered = allReports;
    if (targetType != null) {
      filtered = filtered.where((r) => r.targetType == targetType).toList();
    }
    if (status != null) {
      filtered = filtered.where((r) => r.status == status).toList();
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

  /// Get count of open reports
  Future<int> getOpenCount(
    Session session, {
    ReportTargetType? targetType,
  }) async {
    await requireModerator(session);

    return await Report.db.count(
      session,
      where: (t) {
        var condition = t.status.equals(ReportStatus.open);
        if (targetType != null) {
          condition = condition & t.targetType.equals(targetType);
        }
        return condition;
      },
    );
  }

  /// Assign report to current moderator
  Future<Report> assignToMe(Session session, int reportId) async {
    final user = await requireModerator(session);
    final report = await Report.db.findById(session, reportId);

    if (report == null) {
      throw Exception('Report not found');
    }

    // Update report with assigned moderator
    final updated = report.copyWith(
      assignedModeratorId: user.id,
      status: ReportStatus.reviewing,
      updatedAt: DateTime.now(),
    );

    return await Report.db.updateRow(session, updated);
  }

  /// Update report status
  Future<Report> updateStatus(
    Session session,
    int reportId,
    ReportStatus newStatus,
  ) async {
    await requireModerator(session);
    final report = await Report.db.findById(session, reportId);

    if (report == null) {
      throw Exception('Report not found');
    }

    final updated = report.copyWith(
      status: newStatus,
      updatedAt: DateTime.now(),
      resolvedAt: (newStatus == ReportStatus.resolved ||
              newStatus == ReportStatus.dismissed)
          ? DateTime.now()
          : null,
    );

    return await Report.db.updateRow(session, updated);
  }

  /// Add or update moderator note
  Future<Report> addModeratorNote(
    Session session,
    int reportId,
    String note,
  ) async {
    await requireModerator(session);
    final report = await Report.db.findById(session, reportId);

    if (report == null) {
      throw Exception('Report not found');
    }

    final updated = report.copyWith(
      moderatorNotes: note,
      updatedAt: DateTime.now(),
    );

    return await Report.db.updateRow(session, updated);
  }

  /// Deactivate a reported listing (moderator action)
  Future<bool> deactivateReportedListing(
    Session session,
    int reportId,
  ) async {
    await requireModerator(session);
    final report = await Report.db.findById(session, reportId);

    if (report == null) {
      throw Exception('Report not found');
    }

    if (report.targetType != ReportTargetType.listing) {
      throw Exception('Report is not for a listing');
    }

    final listing = await Listing.db.findById(session, report.targetId);
    if (listing == null) {
      throw Exception('Listing not found');
    }

    // Deactivate the listing
    final updated = listing.copyWith(isActive: false);
    await Listing.db.updateRow(session, updated);

    // Update report status to resolved
    await updateStatus(session, reportId, ReportStatus.resolved);

    return true;
  }
}
