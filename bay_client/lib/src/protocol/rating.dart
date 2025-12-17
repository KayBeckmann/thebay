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
import 'rating_value.dart' as _i2;

/// Bewertung nach abgeschlossener Transaktion
abstract class Rating implements _i1.SerializableModel {
  Rating._({
    this.id,
    required this.transactionId,
    required this.fromUserId,
    required this.toUserId,
    required this.rating,
    this.comment,
    required this.createdAt,
    bool? isAutomatic,
  }) : isAutomatic = isAutomatic ?? false;

  factory Rating({
    int? id,
    required int transactionId,
    required int fromUserId,
    required int toUserId,
    required _i2.RatingValue rating,
    String? comment,
    required DateTime createdAt,
    bool? isAutomatic,
  }) = _RatingImpl;

  factory Rating.fromJson(Map<String, dynamic> jsonSerialization) {
    return Rating(
      id: jsonSerialization['id'] as int?,
      transactionId: jsonSerialization['transactionId'] as int,
      fromUserId: jsonSerialization['fromUserId'] as int,
      toUserId: jsonSerialization['toUserId'] as int,
      rating: _i2.RatingValue.fromJson((jsonSerialization['rating'] as int)),
      comment: jsonSerialization['comment'] as String?,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      isAutomatic: jsonSerialization['isAutomatic'] as bool,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  /// Zugehörige Transaktion
  int transactionId;

  /// Benutzer der die Bewertung abgibt
  int fromUserId;

  /// Benutzer der bewertet wird
  int toUserId;

  /// Bewertungswert (positiv/neutral/negativ)
  _i2.RatingValue rating;

  /// Optionaler Kommentar (max 500 Zeichen)
  String? comment;

  /// Erstellungszeitpunkt
  DateTime createdAt;

  /// Ob die Bewertung automatisch erstellt wurde
  bool isAutomatic;

  /// Returns a shallow copy of this [Rating]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Rating copyWith({
    int? id,
    int? transactionId,
    int? fromUserId,
    int? toUserId,
    _i2.RatingValue? rating,
    String? comment,
    DateTime? createdAt,
    bool? isAutomatic,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'transactionId': transactionId,
      'fromUserId': fromUserId,
      'toUserId': toUserId,
      'rating': rating.toJson(),
      if (comment != null) 'comment': comment,
      'createdAt': createdAt.toJson(),
      'isAutomatic': isAutomatic,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RatingImpl extends Rating {
  _RatingImpl({
    int? id,
    required int transactionId,
    required int fromUserId,
    required int toUserId,
    required _i2.RatingValue rating,
    String? comment,
    required DateTime createdAt,
    bool? isAutomatic,
  }) : super._(
          id: id,
          transactionId: transactionId,
          fromUserId: fromUserId,
          toUserId: toUserId,
          rating: rating,
          comment: comment,
          createdAt: createdAt,
          isAutomatic: isAutomatic,
        );

  /// Returns a shallow copy of this [Rating]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Rating copyWith({
    Object? id = _Undefined,
    int? transactionId,
    int? fromUserId,
    int? toUserId,
    _i2.RatingValue? rating,
    Object? comment = _Undefined,
    DateTime? createdAt,
    bool? isAutomatic,
  }) {
    return Rating(
      id: id is int? ? id : this.id,
      transactionId: transactionId ?? this.transactionId,
      fromUserId: fromUserId ?? this.fromUserId,
      toUserId: toUserId ?? this.toUserId,
      rating: rating ?? this.rating,
      comment: comment is String? ? comment : this.comment,
      createdAt: createdAt ?? this.createdAt,
      isAutomatic: isAutomatic ?? this.isAutomatic,
    );
  }
}
