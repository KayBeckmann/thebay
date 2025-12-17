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
import 'dispute_status.dart' as _i2;

/// Reklamation zu einer Transaktion
abstract class Dispute implements _i1.SerializableModel {
  Dispute._({
    this.id,
    required this.transactionId,
    required this.openedByUserId,
    required this.reason,
    _i2.DisputeStatus? status,
    this.resolution,
    this.moderatorId,
    required this.createdAt,
    this.resolvedAt,
  }) : status = status ?? _i2.DisputeStatus.open;

  factory Dispute({
    int? id,
    required int transactionId,
    required int openedByUserId,
    required String reason,
    _i2.DisputeStatus? status,
    String? resolution,
    int? moderatorId,
    required DateTime createdAt,
    DateTime? resolvedAt,
  }) = _DisputeImpl;

  factory Dispute.fromJson(Map<String, dynamic> jsonSerialization) {
    return Dispute(
      id: jsonSerialization['id'] as int?,
      transactionId: jsonSerialization['transactionId'] as int,
      openedByUserId: jsonSerialization['openedByUserId'] as int,
      reason: jsonSerialization['reason'] as String,
      status: _i2.DisputeStatus.fromJson((jsonSerialization['status'] as int)),
      resolution: jsonSerialization['resolution'] as String?,
      moderatorId: jsonSerialization['moderatorId'] as int?,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      resolvedAt: jsonSerialization['resolvedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['resolvedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  /// Zugehörige Transaktion
  int transactionId;

  /// Benutzer der die Reklamation eröffnet hat
  int openedByUserId;

  /// Grund für die Reklamation
  String reason;

  /// Aktueller Status
  _i2.DisputeStatus status;

  /// Lösung/Ergebnis (vom Moderator eingetragen)
  String? resolution;

  /// Moderator der die Reklamation bearbeitet
  int? moderatorId;

  /// Erstellungszeitpunkt
  DateTime createdAt;

  /// Zeitpunkt der Lösung
  DateTime? resolvedAt;

  /// Returns a shallow copy of this [Dispute]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Dispute copyWith({
    int? id,
    int? transactionId,
    int? openedByUserId,
    String? reason,
    _i2.DisputeStatus? status,
    String? resolution,
    int? moderatorId,
    DateTime? createdAt,
    DateTime? resolvedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'transactionId': transactionId,
      'openedByUserId': openedByUserId,
      'reason': reason,
      'status': status.toJson(),
      if (resolution != null) 'resolution': resolution,
      if (moderatorId != null) 'moderatorId': moderatorId,
      'createdAt': createdAt.toJson(),
      if (resolvedAt != null) 'resolvedAt': resolvedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DisputeImpl extends Dispute {
  _DisputeImpl({
    int? id,
    required int transactionId,
    required int openedByUserId,
    required String reason,
    _i2.DisputeStatus? status,
    String? resolution,
    int? moderatorId,
    required DateTime createdAt,
    DateTime? resolvedAt,
  }) : super._(
          id: id,
          transactionId: transactionId,
          openedByUserId: openedByUserId,
          reason: reason,
          status: status,
          resolution: resolution,
          moderatorId: moderatorId,
          createdAt: createdAt,
          resolvedAt: resolvedAt,
        );

  /// Returns a shallow copy of this [Dispute]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Dispute copyWith({
    Object? id = _Undefined,
    int? transactionId,
    int? openedByUserId,
    String? reason,
    _i2.DisputeStatus? status,
    Object? resolution = _Undefined,
    Object? moderatorId = _Undefined,
    DateTime? createdAt,
    Object? resolvedAt = _Undefined,
  }) {
    return Dispute(
      id: id is int? ? id : this.id,
      transactionId: transactionId ?? this.transactionId,
      openedByUserId: openedByUserId ?? this.openedByUserId,
      reason: reason ?? this.reason,
      status: status ?? this.status,
      resolution: resolution is String? ? resolution : this.resolution,
      moderatorId: moderatorId is int? ? moderatorId : this.moderatorId,
      createdAt: createdAt ?? this.createdAt,
      resolvedAt: resolvedAt is DateTime? ? resolvedAt : this.resolvedAt,
    );
  }
}
