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

/// Currency exchange rate cache
abstract class CurrencyRate implements _i1.SerializableModel {
  CurrencyRate._({
    this.id,
    required this.baseCurrency,
    required this.targetCurrency,
    required this.rate,
    required this.updatedAt,
  });

  factory CurrencyRate({
    int? id,
    required String baseCurrency,
    required String targetCurrency,
    required double rate,
    required DateTime updatedAt,
  }) = _CurrencyRateImpl;

  factory CurrencyRate.fromJson(Map<String, dynamic> jsonSerialization) {
    return CurrencyRate(
      id: jsonSerialization['id'] as int?,
      baseCurrency: jsonSerialization['baseCurrency'] as String,
      targetCurrency: jsonSerialization['targetCurrency'] as String,
      rate: (jsonSerialization['rate'] as num).toDouble(),
      updatedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  /// Base currency (e.g., 'USD', 'EUR')
  String baseCurrency;

  /// Target currency (e.g., 'BTC', 'USD')
  String targetCurrency;

  /// Exchange rate (how much target currency equals 1 base currency)
  double rate;

  /// Last update timestamp
  DateTime updatedAt;

  /// Returns a shallow copy of this [CurrencyRate]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CurrencyRate copyWith({
    int? id,
    String? baseCurrency,
    String? targetCurrency,
    double? rate,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'baseCurrency': baseCurrency,
      'targetCurrency': targetCurrency,
      'rate': rate,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CurrencyRateImpl extends CurrencyRate {
  _CurrencyRateImpl({
    int? id,
    required String baseCurrency,
    required String targetCurrency,
    required double rate,
    required DateTime updatedAt,
  }) : super._(
          id: id,
          baseCurrency: baseCurrency,
          targetCurrency: targetCurrency,
          rate: rate,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [CurrencyRate]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CurrencyRate copyWith({
    Object? id = _Undefined,
    String? baseCurrency,
    String? targetCurrency,
    double? rate,
    DateTime? updatedAt,
  }) {
    return CurrencyRate(
      id: id is int? ? id : this.id,
      baseCurrency: baseCurrency ?? this.baseCurrency,
      targetCurrency: targetCurrency ?? this.targetCurrency,
      rate: rate ?? this.rate,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
