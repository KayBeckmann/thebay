import 'dart:convert';
import 'package:serverpod/serverpod.dart';
import 'package:http/http.dart' as http;
import '../generated/protocol.dart';

/// Service for currency exchange rate management
class CurrencyService {
  /// Cache duration in minutes
  static const int cacheDurationMinutes = 30;

  /// Get exchange rate from base currency to target currency
  /// Returns the rate from cache if available and fresh, otherwise fetches from API
  static Future<double> getExchangeRate(
    Session session, {
    required String baseCurrency,
    required String targetCurrency,
  }) async {
    // Normalize currency codes to uppercase
    final base = baseCurrency.toUpperCase();
    final target = targetCurrency.toUpperCase();

    // If same currency, return 1.0
    if (base == target) {
      return 1.0;
    }

    // Try to get from cache
    final cached = await _getCachedRate(session, base, target);
    if (cached != null) {
      final age = DateTime.now().difference(cached.updatedAt);
      if (age.inMinutes < cacheDurationMinutes) {
        session.log('Using cached rate: $base/$target = ${cached.rate}');
        return cached.rate;
      }
    }

    // Fetch fresh rate from API
    session.log('Fetching fresh rate for $base/$target');
    final rate = await _fetchRateFromAPI(session, base, target);

    // Update cache
    await _updateCache(session, base, target, rate);

    return rate;
  }

  /// Convert amount from one currency to another
  static Future<double> convert(
    Session session, {
    required double amount,
    required String fromCurrency,
    required String toCurrency,
  }) async {
    final rate = await getExchangeRate(
      session,
      baseCurrency: fromCurrency,
      targetCurrency: toCurrency,
    );
    return amount * rate;
  }

  /// Get cached rate from database
  static Future<CurrencyRate?> _getCachedRate(
    Session session,
    String base,
    String target,
  ) async {
    try {
      final rates = await CurrencyRate.db.find(
        session,
        where: (t) =>
            t.baseCurrency.equals(base) & t.targetCurrency.equals(target),
        limit: 1,
      );
      return rates.isEmpty ? null : rates.first;
    } catch (e) {
      session.log('Error getting cached rate: $e', level: LogLevel.warning);
      return null;
    }
  }

  /// Update cache with new rate
  static Future<void> _updateCache(
    Session session,
    String base,
    String target,
    double rate,
  ) async {
    try {
      final existing = await _getCachedRate(session, base, target);

      if (existing != null) {
        // Update existing
        final updated = existing.copyWith(
          rate: rate,
          updatedAt: DateTime.now(),
        );
        await CurrencyRate.db.updateRow(session, updated);
      } else {
        // Insert new
        final newRate = CurrencyRate(
          baseCurrency: base,
          targetCurrency: target,
          rate: rate,
          updatedAt: DateTime.now(),
        );
        await CurrencyRate.db.insertRow(session, newRate);
      }
    } catch (e) {
      session.log('Error updating cache: $e', level: LogLevel.warning);
    }
  }

  /// Fetch rate from external API
  static Future<double> _fetchRateFromAPI(
    Session session,
    String base,
    String target,
  ) async {
    // Handle crypto currencies (BTC)
    if (base == 'BTC' || target == 'BTC') {
      return await _fetchCryptoRate(session, base, target);
    }

    // Handle fiat currencies
    return await _fetchFiatRate(session, base, target);
  }

  /// Fetch crypto currency rate from CoinGecko API
  static Future<double> _fetchCryptoRate(
    Session session,
    String base,
    String target,
  ) async {
    try {
      // Determine which is crypto and which is fiat
      final isBtcBase = base == 'BTC';
      final cryptoId = 'bitcoin'; // CoinGecko ID for Bitcoin
      final fiatCurrency = isBtcBase ? target : base;

      // CoinGecko API endpoint (free tier, no API key required)
      final url = Uri.parse(
        'https://api.coingecko.com/api/v3/simple/price?ids=$cryptoId&vs_currencies=${fiatCurrency.toLowerCase()}',
      );

      final response = await http.get(url).timeout(
        const Duration(seconds: 10),
      );

      if (response.statusCode != 200) {
        throw Exception('API returned status ${response.statusCode}');
      }

      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final price = (data[cryptoId] as Map<String, dynamic>)[fiatCurrency.toLowerCase()] as num;
      final btcToFiat = price.toDouble();

      // If BTC is base currency, return the rate directly
      // If BTC is target currency, return inverse (1/rate)
      return isBtcBase ? btcToFiat : 1.0 / btcToFiat;
    } catch (e) {
      session.log('Error fetching crypto rate: $e', level: LogLevel.error);

      // Fallback to approximate BTC/USD rate if API fails
      if ((base == 'BTC' && target == 'USD') || (base == 'USD' && target == 'BTC')) {
        final fallbackRate = 95000.0; // Approximate BTC/USD rate
        session.log('Using fallback BTC/USD rate: $fallbackRate', level: LogLevel.warning);
        return base == 'BTC' ? fallbackRate : 1.0 / fallbackRate;
      }

      throw Exception('Failed to fetch crypto rate: $e');
    }
  }

  /// Fetch fiat currency rate from exchangerate-api.com
  static Future<double> _fetchFiatRate(
    Session session,
    String base,
    String target,
  ) async {
    try {
      // Using exchangerate-api.com free tier (no API key required)
      final url = Uri.parse(
        'https://api.exchangerate-api.com/v4/latest/$base',
      );

      final response = await http.get(url).timeout(
        const Duration(seconds: 10),
      );

      if (response.statusCode != 200) {
        throw Exception('API returned status ${response.statusCode}');
      }

      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final rates = data['rates'] as Map<String, dynamic>;

      if (!rates.containsKey(target)) {
        throw Exception('Target currency $target not found');
      }

      return (rates[target] as num).toDouble();
    } catch (e) {
      session.log('Error fetching fiat rate: $e', level: LogLevel.error);

      // If both are USD/EUR, provide approximate fallback
      if ((base == 'USD' && target == 'EUR') || (base == 'EUR' && target == 'USD')) {
        final fallbackRate = base == 'USD' ? 0.92 : 1.09; // Approximate USD/EUR rate
        session.log('Using fallback rate for $base/$target: $fallbackRate', level: LogLevel.warning);
        return fallbackRate;
      }

      throw Exception('Failed to fetch fiat rate: $e');
    }
  }

  /// Get multiple exchange rates at once (batch operation)
  static Future<Map<String, double>> getMultipleRates(
    Session session, {
    required String baseCurrency,
    required List<String> targetCurrencies,
  }) async {
    final rates = <String, double>{};

    for (final target in targetCurrencies) {
      try {
        rates[target] = await getExchangeRate(
          session,
          baseCurrency: baseCurrency,
          targetCurrency: target,
        );
      } catch (e) {
        session.log('Error getting rate for $baseCurrency/$target: $e', level: LogLevel.warning);
      }
    }

    return rates;
  }

  /// Clear old cache entries (older than 24 hours)
  static Future<void> clearOldCache(Session session) async {
    try {
      final cutoff = DateTime.now().subtract(const Duration(hours: 24));
      final oldRates = await CurrencyRate.db.find(
        session,
        where: (t) => t.updatedAt < cutoff,
      );

      for (final rate in oldRates) {
        await CurrencyRate.db.deleteRow(session, rate);
      }

      session.log('Cleared ${oldRates.length} old currency rate entries');
    } catch (e) {
      session.log('Error clearing old cache: $e', level: LogLevel.warning);
    }
  }
}
