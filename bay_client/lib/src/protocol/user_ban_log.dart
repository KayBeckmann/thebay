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

/// Log entry for user ban/unban actions
abstract class UserBanLog implements _i1.SerializableModel {
  UserBanLog._({
    this.id,
    required this.userId,
    required this.adminId,
    required this.action,
    this.reason,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory UserBanLog({
    int? id,
    required int userId,
    required int adminId,
    required String action,
    String? reason,
    DateTime? createdAt,
  }) = _UserBanLogImpl;

  factory UserBanLog.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserBanLog(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      adminId: jsonSerialization['adminId'] as int,
      action: jsonSerialization['action'] as String,
      reason: jsonSerialization['reason'] as String?,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  /// User who was banned/unbanned
  int userId;

  /// Admin who performed the action
  int adminId;

  /// Action type: ban or unban
  String action;

  /// Reason for the action
  String? reason;

  /// Timestamp of the action
  DateTime createdAt;

  /// Returns a shallow copy of this [UserBanLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UserBanLog copyWith({
    int? id,
    int? userId,
    int? adminId,
    String? action,
    String? reason,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'adminId': adminId,
      'action': action,
      if (reason != null) 'reason': reason,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserBanLogImpl extends UserBanLog {
  _UserBanLogImpl({
    int? id,
    required int userId,
    required int adminId,
    required String action,
    String? reason,
    DateTime? createdAt,
  }) : super._(
          id: id,
          userId: userId,
          adminId: adminId,
          action: action,
          reason: reason,
          createdAt: createdAt,
        );

  /// Returns a shallow copy of this [UserBanLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UserBanLog copyWith({
    Object? id = _Undefined,
    int? userId,
    int? adminId,
    String? action,
    Object? reason = _Undefined,
    DateTime? createdAt,
  }) {
    return UserBanLog(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      adminId: adminId ?? this.adminId,
      action: action ?? this.action,
      reason: reason is String? ? reason : this.reason,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
