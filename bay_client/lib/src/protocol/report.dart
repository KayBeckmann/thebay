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
import 'report_status.dart' as _i2;
import 'report_target_type.dart' as _i3;
import 'report_reason.dart' as _i4;

/// Report for listings or users
abstract class Report implements _i1.SerializableModel {
  Report._({
    this.id,
    required this.reporterId,
    required this.targetType,
    required this.targetId,
    required this.reason,
    this.details,
    _i2.ReportStatus? status,
    this.assignedModeratorId,
    this.moderatorNotes,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.resolvedAt,
  })  : status = status ?? _i2.ReportStatus.open,
        createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  factory Report({
    int? id,
    required int reporterId,
    required _i3.ReportTargetType targetType,
    required int targetId,
    required _i4.ReportReason reason,
    String? details,
    _i2.ReportStatus? status,
    int? assignedModeratorId,
    String? moderatorNotes,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? resolvedAt,
  }) = _ReportImpl;

  factory Report.fromJson(Map<String, dynamic> jsonSerialization) {
    return Report(
      id: jsonSerialization['id'] as int?,
      reporterId: jsonSerialization['reporterId'] as int,
      targetType: _i3.ReportTargetType.fromJson(
          (jsonSerialization['targetType'] as int)),
      targetId: jsonSerialization['targetId'] as int,
      reason: _i4.ReportReason.fromJson((jsonSerialization['reason'] as int)),
      details: jsonSerialization['details'] as String?,
      status: _i2.ReportStatus.fromJson((jsonSerialization['status'] as int)),
      assignedModeratorId: jsonSerialization['assignedModeratorId'] as int?,
      moderatorNotes: jsonSerialization['moderatorNotes'] as String?,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
      resolvedAt: jsonSerialization['resolvedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['resolvedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  /// User who created the report
  int reporterId;

  /// Type of entity being reported (listing or user)
  _i3.ReportTargetType targetType;

  /// ID of the reported entity
  int targetId;

  /// Reason for the report
  _i4.ReportReason reason;

  /// Additional details provided by reporter
  String? details;

  /// Current status of the report
  _i2.ReportStatus status;

  /// Moderator who is handling this report
  int? assignedModeratorId;

  /// Internal notes from moderators
  String? moderatorNotes;

  /// When the report was created
  DateTime createdAt;

  /// When the report status was last updated
  DateTime updatedAt;

  /// When the report was resolved
  DateTime? resolvedAt;

  /// Returns a shallow copy of this [Report]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Report copyWith({
    int? id,
    int? reporterId,
    _i3.ReportTargetType? targetType,
    int? targetId,
    _i4.ReportReason? reason,
    String? details,
    _i2.ReportStatus? status,
    int? assignedModeratorId,
    String? moderatorNotes,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? resolvedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'reporterId': reporterId,
      'targetType': targetType.toJson(),
      'targetId': targetId,
      'reason': reason.toJson(),
      if (details != null) 'details': details,
      'status': status.toJson(),
      if (assignedModeratorId != null)
        'assignedModeratorId': assignedModeratorId,
      if (moderatorNotes != null) 'moderatorNotes': moderatorNotes,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
      if (resolvedAt != null) 'resolvedAt': resolvedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ReportImpl extends Report {
  _ReportImpl({
    int? id,
    required int reporterId,
    required _i3.ReportTargetType targetType,
    required int targetId,
    required _i4.ReportReason reason,
    String? details,
    _i2.ReportStatus? status,
    int? assignedModeratorId,
    String? moderatorNotes,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? resolvedAt,
  }) : super._(
          id: id,
          reporterId: reporterId,
          targetType: targetType,
          targetId: targetId,
          reason: reason,
          details: details,
          status: status,
          assignedModeratorId: assignedModeratorId,
          moderatorNotes: moderatorNotes,
          createdAt: createdAt,
          updatedAt: updatedAt,
          resolvedAt: resolvedAt,
        );

  /// Returns a shallow copy of this [Report]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Report copyWith({
    Object? id = _Undefined,
    int? reporterId,
    _i3.ReportTargetType? targetType,
    int? targetId,
    _i4.ReportReason? reason,
    Object? details = _Undefined,
    _i2.ReportStatus? status,
    Object? assignedModeratorId = _Undefined,
    Object? moderatorNotes = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
    Object? resolvedAt = _Undefined,
  }) {
    return Report(
      id: id is int? ? id : this.id,
      reporterId: reporterId ?? this.reporterId,
      targetType: targetType ?? this.targetType,
      targetId: targetId ?? this.targetId,
      reason: reason ?? this.reason,
      details: details is String? ? details : this.details,
      status: status ?? this.status,
      assignedModeratorId: assignedModeratorId is int?
          ? assignedModeratorId
          : this.assignedModeratorId,
      moderatorNotes:
          moderatorNotes is String? ? moderatorNotes : this.moderatorNotes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      resolvedAt: resolvedAt is DateTime? ? resolvedAt : this.resolvedAt,
    );
  }
}
