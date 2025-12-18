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

/// Rating statistics for a user (no table, used for API responses)
abstract class RatingStats
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  RatingStats._({
    required this.totalCount,
    required this.positiveCount,
    required this.neutralCount,
    required this.negativeCount,
    this.positivePercentage,
  });

  factory RatingStats({
    required int totalCount,
    required int positiveCount,
    required int neutralCount,
    required int negativeCount,
    double? positivePercentage,
  }) = _RatingStatsImpl;

  factory RatingStats.fromJson(Map<String, dynamic> jsonSerialization) {
    return RatingStats(
      totalCount: jsonSerialization['totalCount'] as int,
      positiveCount: jsonSerialization['positiveCount'] as int,
      neutralCount: jsonSerialization['neutralCount'] as int,
      negativeCount: jsonSerialization['negativeCount'] as int,
      positivePercentage:
          (jsonSerialization['positivePercentage'] as num?)?.toDouble(),
    );
  }

  /// Total number of ratings received
  int totalCount;

  /// Number of positive ratings
  int positiveCount;

  /// Number of neutral ratings
  int neutralCount;

  /// Number of negative ratings
  int negativeCount;

  /// Percentage of positive ratings (0-100, null if no ratings)
  double? positivePercentage;

  /// Returns a shallow copy of this [RatingStats]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  RatingStats copyWith({
    int? totalCount,
    int? positiveCount,
    int? neutralCount,
    int? negativeCount,
    double? positivePercentage,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'totalCount': totalCount,
      'positiveCount': positiveCount,
      'neutralCount': neutralCount,
      'negativeCount': negativeCount,
      if (positivePercentage != null) 'positivePercentage': positivePercentage,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      'totalCount': totalCount,
      'positiveCount': positiveCount,
      'neutralCount': neutralCount,
      'negativeCount': negativeCount,
      if (positivePercentage != null) 'positivePercentage': positivePercentage,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RatingStatsImpl extends RatingStats {
  _RatingStatsImpl({
    required int totalCount,
    required int positiveCount,
    required int neutralCount,
    required int negativeCount,
    double? positivePercentage,
  }) : super._(
          totalCount: totalCount,
          positiveCount: positiveCount,
          neutralCount: neutralCount,
          negativeCount: negativeCount,
          positivePercentage: positivePercentage,
        );

  /// Returns a shallow copy of this [RatingStats]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  RatingStats copyWith({
    int? totalCount,
    int? positiveCount,
    int? neutralCount,
    int? negativeCount,
    Object? positivePercentage = _Undefined,
  }) {
    return RatingStats(
      totalCount: totalCount ?? this.totalCount,
      positiveCount: positiveCount ?? this.positiveCount,
      neutralCount: neutralCount ?? this.neutralCount,
      negativeCount: negativeCount ?? this.negativeCount,
      positivePercentage: positivePercentage is double?
          ? positivePercentage
          : this.positivePercentage,
    );
  }
}
