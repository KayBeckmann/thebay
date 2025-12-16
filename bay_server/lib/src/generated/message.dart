/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;

/// Encrypted message between users
abstract class Message
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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

  static final t = MessageTable();

  static const db = MessageRepository._();

  @override
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

  @override
  _i1.Table<int?> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
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

  static MessageInclude include() {
    return MessageInclude._();
  }

  static MessageIncludeList includeList({
    _i1.WhereExpressionBuilder<MessageTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MessageTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MessageTable>? orderByList,
    MessageInclude? include,
  }) {
    return MessageIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Message.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Message.t),
      include: include,
    );
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

class MessageTable extends _i1.Table<int?> {
  MessageTable({super.tableRelation}) : super(tableName: 'messages') {
    senderId = _i1.ColumnInt(
      'senderId',
      this,
    );
    recipientId = _i1.ColumnInt(
      'recipientId',
      this,
    );
    encryptedSubject = _i1.ColumnString(
      'encryptedSubject',
      this,
    );
    encryptedContent = _i1.ColumnString(
      'encryptedContent',
      this,
    );
    isRead = _i1.ColumnBool(
      'isRead',
      this,
      hasDefault: true,
    );
    deletedBySender = _i1.ColumnBool(
      'deletedBySender',
      this,
      hasDefault: true,
    );
    deletedByRecipient = _i1.ColumnBool(
      'deletedByRecipient',
      this,
      hasDefault: true,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
    listingId = _i1.ColumnInt(
      'listingId',
      this,
    );
    parentMessageId = _i1.ColumnInt(
      'parentMessageId',
      this,
    );
  }

  /// Sender user ID
  late final _i1.ColumnInt senderId;

  /// Recipient user ID
  late final _i1.ColumnInt recipientId;

  /// PGP-encrypted subject (encrypted with recipient's public key)
  late final _i1.ColumnString encryptedSubject;

  /// PGP-encrypted content (encrypted with recipient's public key)
  late final _i1.ColumnString encryptedContent;

  /// Whether message has been read by recipient
  late final _i1.ColumnBool isRead;

  /// Soft delete flag for sender
  late final _i1.ColumnBool deletedBySender;

  /// Soft delete flag for recipient
  late final _i1.ColumnBool deletedByRecipient;

  /// Timestamp when message was sent
  late final _i1.ColumnDateTime createdAt;

  /// Optional: reference to a listing (for inquiry messages)
  late final _i1.ColumnInt listingId;

  /// Parent message ID for threading/replies
  late final _i1.ColumnInt parentMessageId;

  @override
  List<_i1.Column> get columns => [
        id,
        senderId,
        recipientId,
        encryptedSubject,
        encryptedContent,
        isRead,
        deletedBySender,
        deletedByRecipient,
        createdAt,
        listingId,
        parentMessageId,
      ];
}

class MessageInclude extends _i1.IncludeObject {
  MessageInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Message.t;
}

class MessageIncludeList extends _i1.IncludeList {
  MessageIncludeList._({
    _i1.WhereExpressionBuilder<MessageTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Message.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Message.t;
}

class MessageRepository {
  const MessageRepository._();

  /// Returns a list of [Message]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<Message>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<MessageTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MessageTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MessageTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Message>(
      where: where?.call(Message.t),
      orderBy: orderBy?.call(Message.t),
      orderByList: orderByList?.call(Message.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Message] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<Message?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<MessageTable>? where,
    int? offset,
    _i1.OrderByBuilder<MessageTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MessageTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Message>(
      where: where?.call(Message.t),
      orderBy: orderBy?.call(Message.t),
      orderByList: orderByList?.call(Message.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Message] by its [id] or null if no such row exists.
  Future<Message?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Message>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Message]s in the list and returns the inserted rows.
  ///
  /// The returned [Message]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Message>> insert(
    _i1.Session session,
    List<Message> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Message>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Message] and returns the inserted row.
  ///
  /// The returned [Message] will have its `id` field set.
  Future<Message> insertRow(
    _i1.Session session,
    Message row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Message>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Message]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Message>> update(
    _i1.Session session,
    List<Message> rows, {
    _i1.ColumnSelections<MessageTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Message>(
      rows,
      columns: columns?.call(Message.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Message]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Message> updateRow(
    _i1.Session session,
    Message row, {
    _i1.ColumnSelections<MessageTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Message>(
      row,
      columns: columns?.call(Message.t),
      transaction: transaction,
    );
  }

  /// Deletes all [Message]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Message>> delete(
    _i1.Session session,
    List<Message> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Message>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Message].
  Future<Message> deleteRow(
    _i1.Session session,
    Message row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Message>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Message>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<MessageTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Message>(
      where: where(Message.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<MessageTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Message>(
      where: where?.call(Message.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
