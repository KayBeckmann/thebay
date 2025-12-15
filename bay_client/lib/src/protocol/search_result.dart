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
import 'listing.dart' as _i2;

/// DTO für Suchergebnisse mit Pagination-Metadaten
abstract class SearchResult implements _i1.SerializableModel {
  SearchResult._({
    required this.listings,
    required this.totalCount,
    required this.page,
    required this.pageSize,
    required this.hasMore,
  });

  factory SearchResult({
    required List<_i2.Listing> listings,
    required int totalCount,
    required int page,
    required int pageSize,
    required bool hasMore,
  }) = _SearchResultImpl;

  factory SearchResult.fromJson(Map<String, dynamic> jsonSerialization) {
    return SearchResult(
      listings: (jsonSerialization['listings'] as List)
          .map((e) => _i2.Listing.fromJson((e as Map<String, dynamic>)))
          .toList(),
      totalCount: jsonSerialization['totalCount'] as int,
      page: jsonSerialization['page'] as int,
      pageSize: jsonSerialization['pageSize'] as int,
      hasMore: jsonSerialization['hasMore'] as bool,
    );
  }

  /// Liste der gefundenen Listings
  List<_i2.Listing> listings;

  /// Gesamtanzahl der Treffer
  int totalCount;

  /// Aktuelle Seite (0-basiert)
  int page;

  /// Anzahl pro Seite
  int pageSize;

  /// Gibt es weitere Seiten?
  bool hasMore;

  /// Returns a shallow copy of this [SearchResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SearchResult copyWith({
    List<_i2.Listing>? listings,
    int? totalCount,
    int? page,
    int? pageSize,
    bool? hasMore,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'listings': listings.toJson(valueToJson: (v) => v.toJson()),
      'totalCount': totalCount,
      'page': page,
      'pageSize': pageSize,
      'hasMore': hasMore,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _SearchResultImpl extends SearchResult {
  _SearchResultImpl({
    required List<_i2.Listing> listings,
    required int totalCount,
    required int page,
    required int pageSize,
    required bool hasMore,
  }) : super._(
          listings: listings,
          totalCount: totalCount,
          page: page,
          pageSize: pageSize,
          hasMore: hasMore,
        );

  /// Returns a shallow copy of this [SearchResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SearchResult copyWith({
    List<_i2.Listing>? listings,
    int? totalCount,
    int? page,
    int? pageSize,
    bool? hasMore,
  }) {
    return SearchResult(
      listings: listings ?? this.listings.map((e0) => e0.copyWith()).toList(),
      totalCount: totalCount ?? this.totalCount,
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}
