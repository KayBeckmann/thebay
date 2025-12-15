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

/// Favoriten-Tabelle für Benutzer-Lesezeichen
abstract class Favorite implements _i1.SerializableModel {
  Favorite._({
    this.id,
    required this.userId,
    required this.listingId,
    required this.createdAt,
  });

  factory Favorite({
    int? id,
    required int userId,
    required int listingId,
    required DateTime createdAt,
  }) = _FavoriteImpl;

  factory Favorite.fromJson(Map<String, dynamic> jsonSerialization) {
    return Favorite(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      listingId: jsonSerialization['listingId'] as int,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  /// Benutzer, der das Angebot favorisiert hat
  int userId;

  /// Das favorisierte Angebot
  int listingId;

  /// Zeitstempel der Erstellung
  DateTime createdAt;

  /// Returns a shallow copy of this [Favorite]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Favorite copyWith({
    int? id,
    int? userId,
    int? listingId,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'listingId': listingId,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FavoriteImpl extends Favorite {
  _FavoriteImpl({
    int? id,
    required int userId,
    required int listingId,
    required DateTime createdAt,
  }) : super._(
          id: id,
          userId: userId,
          listingId: listingId,
          createdAt: createdAt,
        );

  /// Returns a shallow copy of this [Favorite]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Favorite copyWith({
    Object? id = _Undefined,
    int? userId,
    int? listingId,
    DateTime? createdAt,
  }) {
    return Favorite(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      listingId: listingId ?? this.listingId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
