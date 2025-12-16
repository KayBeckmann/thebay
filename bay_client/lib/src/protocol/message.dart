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

/// Encrypted message between users
abstract class Message implements _i1.SerializableModel {
  Message._({
    this.id,
    required this.senderId,
    required this.recipientId,
    required this.encryptedSubject,
    required this.encryptedContent,
    bool? isRead,
    bool? deletedBySender,
    bool? deletedByRecipient,
    required this.createdAt,
    this.listingId,
    this.parentMessageId,
  })  : isRead = isRead ?? false,
        deletedBySender = deletedBySender ?? false,
        deletedByRecipient = deletedByRecipient ?? false;

  factory Message({
    int? id,
    required int senderId,
    required int recipientId,
    required String encryptedSubject,
    required String encryptedContent,
    bool? isRead,
    bool? deletedBySender,
    bool? deletedByRecipient,
    required DateTime createdAt,
    int? listingId,
    int? parentMessageId,
  }) = _MessageImpl;

  factory Message.fromJson(Map<String, dynamic> jsonSerialization) {
    return Message(
      id: jsonSerialization['id'] as int?,
      senderId: jsonSerialization['senderId'] as int,
      recipientId: jsonSerialization['recipientId'] as int,
      encryptedSubject: jsonSerialization['encryptedSubject'] as String,
      encryptedContent: jsonSerialization['encryptedContent'] as String,
      isRead: jsonSerialization['isRead'] as bool,
      deletedBySender: jsonSerialization['deletedBySender'] as bool,
      deletedByRecipient: jsonSerialization['deletedByRecipient'] as bool,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      listingId: jsonSerialization['listingId'] as int?,
      parentMessageId: jsonSerialization['parentMessageId'] as int?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  /// Sender user ID
  int senderId;

  /// Recipient user ID
  int recipientId;

  /// PGP-encrypted subject (encrypted with recipient's public key)
  String encryptedSubject;

  /// PGP-encrypted content (encrypted with recipient's public key)
  String encryptedContent;

  /// Whether message has been read by recipient
  bool isRead;

  /// Soft delete flag for sender
  bool deletedBySender;

  /// Soft delete flag for recipient
  bool deletedByRecipient;

  /// Timestamp when message was sent
  DateTime createdAt;

  /// Optional: reference to a listing (for inquiry messages)
  int? listingId;

  /// Parent message ID for threading/replies
  int? parentMessageId;

  /// Returns a shallow copy of this [Message]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Message copyWith({
    int? id,
    int? senderId,
    int? recipientId,
    String? encryptedSubject,
    String? encryptedContent,
    bool? isRead,
    bool? deletedBySender,
    bool? deletedByRecipient,
    DateTime? createdAt,
    int? listingId,
    int? parentMessageId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'senderId': senderId,
      'recipientId': recipientId,
      'encryptedSubject': encryptedSubject,
      'encryptedContent': encryptedContent,
      'isRead': isRead,
      'deletedBySender': deletedBySender,
      'deletedByRecipient': deletedByRecipient,
      'createdAt': createdAt.toJson(),
      if (listingId != null) 'listingId': listingId,
      if (parentMessageId != null) 'parentMessageId': parentMessageId,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MessageImpl extends Message {
  _MessageImpl({
    int? id,
    required int senderId,
    required int recipientId,
    required String encryptedSubject,
    required String encryptedContent,
    bool? isRead,
    bool? deletedBySender,
    bool? deletedByRecipient,
    required DateTime createdAt,
    int? listingId,
    int? parentMessageId,
  }) : super._(
          id: id,
          senderId: senderId,
          recipientId: recipientId,
          encryptedSubject: encryptedSubject,
          encryptedContent: encryptedContent,
          isRead: isRead,
          deletedBySender: deletedBySender,
          deletedByRecipient: deletedByRecipient,
          createdAt: createdAt,
          listingId: listingId,
          parentMessageId: parentMessageId,
        );

  /// Returns a shallow copy of this [Message]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Message copyWith({
    Object? id = _Undefined,
    int? senderId,
    int? recipientId,
    String? encryptedSubject,
    String? encryptedContent,
    bool? isRead,
    bool? deletedBySender,
    bool? deletedByRecipient,
    DateTime? createdAt,
    Object? listingId = _Undefined,
    Object? parentMessageId = _Undefined,
  }) {
    return Message(
      id: id is int? ? id : this.id,
      senderId: senderId ?? this.senderId,
      recipientId: recipientId ?? this.recipientId,
      encryptedSubject: encryptedSubject ?? this.encryptedSubject,
      encryptedContent: encryptedContent ?? this.encryptedContent,
      isRead: isRead ?? this.isRead,
      deletedBySender: deletedBySender ?? this.deletedBySender,
      deletedByRecipient: deletedByRecipient ?? this.deletedByRecipient,
      createdAt: createdAt ?? this.createdAt,
      listingId: listingId is int? ? listingId : this.listingId,
      parentMessageId:
          parentMessageId is int? ? parentMessageId : this.parentMessageId,
    );
  }
}
