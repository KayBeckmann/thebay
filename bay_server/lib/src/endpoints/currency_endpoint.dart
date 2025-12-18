import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/currency_service.dart';

/// Endpoint for currency exchange operations
class CurrencyEndpoint extends Endpoint {
  @override
  bool get requireLogin => false; // Public endpoint

  /// Get exchange rate between two currencies
  ///
  /// Returns the rate where 1 unit of [baseCurrency] equals [rate] units of [targetCurrency]
  /// Example: getExchangeRate('BTC', 'USD') might return 95000.0
  ///          meaning 1 BTC = 95000 USD
  Future<double> getExchangeRate(
    Session session,
    String baseCurrency,
    String targetCurrency,
  ) async {
    try {
      return await CurrencyService.getExchangeRate(
        session,
        baseCurrency: baseCurrency,
        targetCurrency: targetCurrency,
      );
    } catch (e) {
      session.log('Error getting exchange rate: $e', level: LogLevel.error);
      throw Exception('Failed to get exchange rate: $e');
    }
  }

  /// Convert amount from one currency to another
  ///
  /// Example: convert(1.0, 'BTC', 'USD') might return 95000.0
  Future<double> convert(
    Session session,
    double amount,
    String fromCurrency,
    String toCurrency,
  ) async {
    try {
      return await CurrencyService.convert(
        session,
        amount: amount,
        fromCurrency: fromCurrency,
        toCurrency: toCurrency,
      );
    } catch (e) {
      session.log('Error converting currency: $e', level: LogLevel.error);
      throw Exception('Failed to convert currency: $e');
    }
  }

  /// Get multiple exchange rates at once
  ///
  /// Returns a map of target currency to exchange rate
  /// Example: getMultipleRates('USD', ['EUR', 'BTC']) might return
  ///          {'EUR': 0.92, 'BTC': 0.000011}
  Future<Map<String, double>> getMultipleRates(
    Session session,
    String baseCurrency,
    List<String> targetCurrencies,
  ) async {
    try {
      return await CurrencyService.getMultipleRates(
        session,
        baseCurrency: baseCurrency,
        targetCurrencies: targetCurrencies,
      );
    } catch (e) {
      session.log('Error getting multiple rates: $e', level: LogLevel.error);
      throw Exception('Failed to get multiple rates: $e');
    }
  }

  /// Get the latest rate from cache (without updating)
  /// Returns null if not cached or cache is old
  Future<CurrencyRate?> getCachedRate(
    Session session,
    String baseCurrency,
    String targetCurrency,
  ) async {
    try {
      final base = baseCurrency.toUpperCase();
      final target = targetCurrency.toUpperCase();

      final rates = await CurrencyRate.db.find(
        session,
        where: (t) =>
            t.baseCurrency.equals(base) & t.targetCurrency.equals(target),
        limit: 1,
      );

      if (rates.isEmpty) return null;

      final cached = rates.first;
      final age = DateTime.now().difference(cached.updatedAt);

      // Return null if cache is older than 30 minutes
      if (age.inMinutes >= 30) return null;

      return cached;
    } catch (e) {
      session.log('Error getting cached rate: $e', level: LogLevel.warning);
      return null;
    }
  }
}
