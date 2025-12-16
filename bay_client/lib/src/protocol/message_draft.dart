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

/// Draft message stored for later sending
abstract class MessageDraft implements _i1.SerializableModel {
  MessageDraft._({
    this.id,
    required this.userId,
    this.recipientId,
    this.recipientUsername,
    this.encryptedSubject,
    this.encryptedContent,
    required this.createdAt,
    required this.updatedAt,
    required this.expiresAt,
    this.listingId,
  });

  factory MessageDraft({
    int? id,
    required int userId,
    int? recipientId,
    String? recipientUsername,
    String? encryptedSubject,
    String? encryptedContent,
    required DateTime createdAt,
    required DateTime updatedAt,
    required DateTime expiresAt,
    int? listingId,
  }) = _MessageDraftImpl;

  factory MessageDraft.fromJson(Map<String, dynamic> jsonSerialization) {
    return MessageDraft(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      recipientId: jsonSerialization['recipientId'] as int?,
      recipientUsername: jsonSerialization['recipientUsername'] as String?,
      encryptedSubject: jsonSerialization['encryptedSubject'] as String?,
      encryptedContent: jsonSerialization['encryptedContent'] as String?,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
      expiresAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['expiresAt']),
      listingId: jsonSerialization['listingId'] as int?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  /// User who owns this draft
  int userId;

  /// Intended recipient user ID (optional until selected)
  int? recipientId;

  /// Plain text recipient username (for display before sending)
  String? recipientUsername;

  /// Encrypted subject (encrypted with user's own public key for storage)
  String? encryptedSubject;

  /// Encrypted content (encrypted with user's own public key for storage)
  String? encryptedContent;

  /// Creation timestamp
  DateTime createdAt;

  /// Last update timestamp
  DateTime updatedAt;

  /// Auto-expiration date (7 days after creation)
  DateTime expiresAt;

  /// Optional: reference to a listing
  int? listingId;

  /// Returns a shallow copy of this [MessageDraft]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  MessageDraft copyWith({
    int? id,
    int? userId,
    int? recipientId,
    String? recipientUsername,
    String? encryptedSubject,
    String? encryptedContent,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? expiresAt,
    int? listingId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      if (recipientId != null) 'recipientId': recipientId,
      if (recipientUsername != null) 'recipientUsername': recipientUsername,
      if (encryptedSubject != null) 'encryptedSubject': encryptedSubject,
      if (encryptedContent != null) 'encryptedContent': encryptedContent,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
      'expiresAt': expiresAt.toJson(),
      if (listingId != null) 'listingId': listingId,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MessageDraftImpl extends MessageDraft {
  _MessageDraftImpl({
    int? id,
    required int userId,
    int? recipientId,
    String? recipientUsername,
    String? encryptedSubject,
    String? encryptedContent,
    required DateTime createdAt,
    required DateTime updatedAt,
    required DateTime expiresAt,
    int? listingId,
  }) : super._(
          id: id,
          userId: userId,
          recipientId: recipientId,
          recipientUsername: recipientUsername,
          encryptedSubject: encryptedSubject,
          encryptedContent: encryptedContent,
          createdAt: createdAt,
          updatedAt: updatedAt,
          expiresAt: expiresAt,
          listingId: listingId,
        );

  /// Returns a shallow copy of this [MessageDraft]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  MessageDraft copyWith({
    Object? id = _Undefined,
    int? userId,
    Object? recipientId = _Undefined,
    Object? recipientUsername = _Undefined,
    Object? encryptedSubject = _Undefined,
    Object? encryptedContent = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? expiresAt,
    Object? listingId = _Undefined,
  }) {
    return MessageDraft(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      recipientId: recipientId is int? ? recipientId : this.recipientId,
      recipientUsername: recipientUsername is String?
          ? recipientUsername
          : this.recipientUsername,
      encryptedSubject: encryptedSubject is String?
          ? encryptedSubject
          : this.encryptedSubject,
      encryptedContent: encryptedContent is String?
          ? encryptedContent
          : this.encryptedContent,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      expiresAt: expiresAt ?? this.expiresAt,
      listingId: listingId is int? ? listingId : this.listingId,
    );
  }
}
