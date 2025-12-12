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

/// News article for dashboard announcements
abstract class News implements _i1.SerializableModel {
  News._({
    this.id,
    required this.title,
    required this.content,
    required this.authorId,
    required this.isPublished,
    this.publishedAt,
    this.expiresAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory News({
    int? id,
    required String title,
    required String content,
    required int authorId,
    required bool isPublished,
    DateTime? publishedAt,
    DateTime? expiresAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _NewsImpl;

  factory News.fromJson(Map<String, dynamic> jsonSerialization) {
    return News(
      id: jsonSerialization['id'] as int?,
      title: jsonSerialization['title'] as String,
      content: jsonSerialization['content'] as String,
      authorId: jsonSerialization['authorId'] as int,
      isPublished: jsonSerialization['isPublished'] as bool,
      publishedAt: jsonSerialization['publishedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['publishedAt']),
      expiresAt: jsonSerialization['expiresAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['expiresAt']),
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  /// News title
  String title;

  /// News content (supports markdown)
  String content;

  /// Author user ID
  int authorId;

  /// Whether news is published
  bool isPublished;

  /// Publication date
  DateTime? publishedAt;

  /// Expiration date (auto-delete after this date)
  DateTime? expiresAt;

  /// Creation timestamp
  DateTime createdAt;

  /// Last modification timestamp
  DateTime updatedAt;

  /// Returns a shallow copy of this [News]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  News copyWith({
    int? id,
    String? title,
    String? content,
    int? authorId,
    bool? isPublished,
    DateTime? publishedAt,
    DateTime? expiresAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'title': title,
      'content': content,
      'authorId': authorId,
      'isPublished': isPublished,
      if (publishedAt != null) 'publishedAt': publishedAt?.toJson(),
      if (expiresAt != null) 'expiresAt': expiresAt?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _NewsImpl extends News {
  _NewsImpl({
    int? id,
    required String title,
    required String content,
    required int authorId,
    required bool isPublished,
    DateTime? publishedAt,
    DateTime? expiresAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
          id: id,
          title: title,
          content: content,
          authorId: authorId,
          isPublished: isPublished,
          publishedAt: publishedAt,
          expiresAt: expiresAt,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [News]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  News copyWith({
    Object? id = _Undefined,
    String? title,
    String? content,
    int? authorId,
    bool? isPublished,
    Object? publishedAt = _Undefined,
    Object? expiresAt = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return News(
      id: id is int? ? id : this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      authorId: authorId ?? this.authorId,
      isPublished: isPublished ?? this.isPublished,
      publishedAt: publishedAt is DateTime? ? publishedAt : this.publishedAt,
      expiresAt: expiresAt is DateTime? ? expiresAt : this.expiresAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
