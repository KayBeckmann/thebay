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

/// Bilder zu Angeboten
abstract class ListingImage implements _i1.SerializableModel {
  ListingImage._({
    this.id,
    required this.listingId,
    required this.fileName,
    required this.originalName,
    required this.mimeType,
    required this.sizeBytes,
    required this.sortOrder,
    required this.createdAt,
  });

  factory ListingImage({
    int? id,
    required int listingId,
    required String fileName,
    required String originalName,
    required String mimeType,
    required int sizeBytes,
    required int sortOrder,
    required DateTime createdAt,
  }) = _ListingImageImpl;

  factory ListingImage.fromJson(Map<String, dynamic> jsonSerialization) {
    return ListingImage(
      id: jsonSerialization['id'] as int?,
      listingId: jsonSerialization['listingId'] as int,
      fileName: jsonSerialization['fileName'] as String,
      originalName: jsonSerialization['originalName'] as String,
      mimeType: jsonSerialization['mimeType'] as String,
      sizeBytes: jsonSerialization['sizeBytes'] as int,
      sortOrder: jsonSerialization['sortOrder'] as int,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int listingId;

  String fileName;

  String originalName;

  String mimeType;

  int sizeBytes;

  int sortOrder;

  DateTime createdAt;

  /// Returns a shallow copy of this [ListingImage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ListingImage copyWith({
    int? id,
    int? listingId,
    String? fileName,
    String? originalName,
    String? mimeType,
    int? sizeBytes,
    int? sortOrder,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'listingId': listingId,
      'fileName': fileName,
      'originalName': originalName,
      'mimeType': mimeType,
      'sizeBytes': sizeBytes,
      'sortOrder': sortOrder,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ListingImageImpl extends ListingImage {
  _ListingImageImpl({
    int? id,
    required int listingId,
    required String fileName,
    required String originalName,
    required String mimeType,
    required int sizeBytes,
    required int sortOrder,
    required DateTime createdAt,
  }) : super._(
          id: id,
          listingId: listingId,
          fileName: fileName,
          originalName: originalName,
          mimeType: mimeType,
          sizeBytes: sizeBytes,
          sortOrder: sortOrder,
          createdAt: createdAt,
        );

  /// Returns a shallow copy of this [ListingImage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ListingImage copyWith({
    Object? id = _Undefined,
    int? listingId,
    String? fileName,
    String? originalName,
    String? mimeType,
    int? sizeBytes,
    int? sortOrder,
    DateTime? createdAt,
  }) {
    return ListingImage(
      id: id is int? ? id : this.id,
      listingId: listingId ?? this.listingId,
      fileName: fileName ?? this.fileName,
      originalName: originalName ?? this.originalName,
      mimeType: mimeType ?? this.mimeType,
      sizeBytes: sizeBytes ?? this.sizeBytes,
      sortOrder: sortOrder ?? this.sortOrder,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
