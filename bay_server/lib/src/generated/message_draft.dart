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

/// Draft message stored for later sending
abstract class MessageDraft
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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

  static final t = MessageDraftTable();

  static const db = MessageDraftRepository._();

  @override
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

  @override
  _i1.Table<int?> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
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

  static MessageDraftInclude include() {
    return MessageDraftInclude._();
  }

  static MessageDraftIncludeList includeList({
    _i1.WhereExpressionBuilder<MessageDraftTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MessageDraftTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MessageDraftTable>? orderByList,
    MessageDraftInclude? include,
  }) {
    return MessageDraftIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(MessageDraft.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(MessageDraft.t),
      include: include,
    );
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

class MessageDraftTable extends _i1.Table<int?> {
  MessageDraftTable({super.tableRelation})
      : super(tableName: 'message_drafts') {
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    recipientId = _i1.ColumnInt(
      'recipientId',
      this,
    );
    recipientUsername = _i1.ColumnString(
      'recipientUsername',
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
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
    );
    expiresAt = _i1.ColumnDateTime(
      'expiresAt',
      this,
    );
    listingId = _i1.ColumnInt(
      'listingId',
      this,
    );
  }

  /// User who owns this draft
  late final _i1.ColumnInt userId;

  /// Intended recipient user ID (optional until selected)
  late final _i1.ColumnInt recipientId;

  /// Plain text recipient username (for display before sending)
  late final _i1.ColumnString recipientUsername;

  /// Encrypted subject (encrypted with user's own public key for storage)
  late final _i1.ColumnString encryptedSubject;

  /// Encrypted content (encrypted with user's own public key for storage)
  late final _i1.ColumnString encryptedContent;

  /// Creation timestamp
  late final _i1.ColumnDateTime createdAt;

  /// Last update timestamp
  late final _i1.ColumnDateTime updatedAt;

  /// Auto-expiration date (7 days after creation)
  late final _i1.ColumnDateTime expiresAt;

  /// Optional: reference to a listing
  late final _i1.ColumnInt listingId;

  @override
  List<_i1.Column> get columns => [
        id,
        userId,
        recipientId,
        recipientUsername,
        encryptedSubject,
        encryptedContent,
        createdAt,
        updatedAt,
        expiresAt,
        listingId,
      ];
}

class MessageDraftInclude extends _i1.IncludeObject {
  MessageDraftInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => MessageDraft.t;
}

class MessageDraftIncludeList extends _i1.IncludeList {
  MessageDraftIncludeList._({
    _i1.WhereExpressionBuilder<MessageDraftTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(MessageDraft.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => MessageDraft.t;
}

class MessageDraftRepository {
  const MessageDraftRepository._();

  /// Returns a list of [MessageDraft]s matching the given query parameters.
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
  Future<List<MessageDraft>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<MessageDraftTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MessageDraftTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MessageDraftTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<MessageDraft>(
      where: where?.call(MessageDraft.t),
      orderBy: orderBy?.call(MessageDraft.t),
      orderByList: orderByList?.call(MessageDraft.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [MessageDraft] matching the given query parameters.
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
  Future<MessageDraft?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<MessageDraftTable>? where,
    int? offset,
    _i1.OrderByBuilder<MessageDraftTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MessageDraftTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<MessageDraft>(
      where: where?.call(MessageDraft.t),
      orderBy: orderBy?.call(MessageDraft.t),
      orderByList: orderByList?.call(MessageDraft.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [MessageDraft] by its [id] or null if no such row exists.
  Future<MessageDraft?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<MessageDraft>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [MessageDraft]s in the list and returns the inserted rows.
  ///
  /// The returned [MessageDraft]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<MessageDraft>> insert(
    _i1.Session session,
    List<MessageDraft> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<MessageDraft>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [MessageDraft] and returns the inserted row.
  ///
  /// The returned [MessageDraft] will have its `id` field set.
  Future<MessageDraft> insertRow(
    _i1.Session session,
    MessageDraft row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<MessageDraft>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [MessageDraft]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<MessageDraft>> update(
    _i1.Session session,
    List<MessageDraft> rows, {
    _i1.ColumnSelections<MessageDraftTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<MessageDraft>(
      rows,
      columns: columns?.call(MessageDraft.t),
      transaction: transaction,
    );
  }

  /// Updates a single [MessageDraft]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<MessageDraft> updateRow(
    _i1.Session session,
    MessageDraft row, {
    _i1.ColumnSelections<MessageDraftTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<MessageDraft>(
      row,
      columns: columns?.call(MessageDraft.t),
      transaction: transaction,
    );
  }

  /// Deletes all [MessageDraft]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<MessageDraft>> delete(
    _i1.Session session,
    List<MessageDraft> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<MessageDraft>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [MessageDraft].
  Future<MessageDraft> deleteRow(
    _i1.Session session,
    MessageDraft row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<MessageDraft>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<MessageDraft>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<MessageDraftTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<MessageDraft>(
      where: where(MessageDraft.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<MessageDraftTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<MessageDraft>(
      where: where?.call(MessageDraft.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
