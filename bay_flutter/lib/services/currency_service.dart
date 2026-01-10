import 'package:bay_client/bay_client.dart';
import 'package:intl/intl.dart';

/// Service for currency conversion and formatting
class CurrencyService {
  final Client _client;

  /// Cache for exchange rates (currency pair -> rate)
  final Map<String, double> _rateCache = {};

  /// Cache expiration time
  final Map<String, DateTime> _cacheExpiry = {};

  /// Cache duration in minutes
  static const int cacheDurationMinutes = 30;

  CurrencyService(this._client);

  /// Get exchange rate from base currency to target currency
  Future<double> getExchangeRate({
    required String baseCurrency,
    required String targetCurrency,
  }) async {
    // Normalize to uppercase
    final base = baseCurrency.toUpperCase();
    final target = targetCurrency.toUpperCase();

    // Same currency
    if (base == target) return 1.0;

    final cacheKey = '$base-$target';

    // Check cache
    if (_rateCache.containsKey(cacheKey) && _cacheExpiry.containsKey(cacheKey)) {
      final expiry = _cacheExpiry[cacheKey]!;
      if (DateTime.now().isBefore(expiry)) {
        return _rateCache[cacheKey]!;
      }
    }

    // Fetch from API
    try {
      final rate = await _client.currency.getExchangeRate(base, target);

      // Update cache
      _rateCache[cacheKey] = rate;
      _cacheExpiry[cacheKey] = DateTime.now().add(
        const Duration(minutes: cacheDurationMinutes),
      );

      return rate;
    } catch (e) {
      // If API fails and we have stale cache, use it
      if (_rateCache.containsKey(cacheKey)) {
        return _rateCache[cacheKey]!;
      }

      rethrow;
    }
  }

  /// Convert amount from one currency to another
  Future<double> convert({
    required double amount,
    required String fromCurrency,
    required String toCurrency,
  }) async {
    final rate = await getExchangeRate(
      baseCurrency: fromCurrency,
      targetCurrency: toCurrency,
    );

    return amount * rate;
  }

  /// Convert price in cents from one currency to another
  Future<int> convertCents({
    required int amountCents,
    required String fromCurrency,
    required String toCurrency,
  }) async {
    final amountInUnits = amountCents / 100.0;
    final converted = await convert(
      amount: amountInUnits,
      fromCurrency: fromCurrency,
      toCurrency: toCurrency,
    );

    return (converted * 100).round();
  }

  /// Format price with currency symbol using localized number formatting
  String formatPrice({
    required int priceInCents,
    required String currency,
    String? locale, // Optional locale, defaults to 'en_US' if not provided
    bool showSymbol = true,
  }) {
    final price = priceInCents / 100.0;
    final currencyUpper = currency.toUpperCase();
    final effectiveLocale = locale ?? 'en_US';

    // Format based on currency
    if (currencyUpper == 'BTC') {
      // BTC with 8 decimal places
      final formatter = NumberFormat('#,##0.00000000', effectiveLocale);
      final formatted = formatter.format(price);
      return showSymbol ? '₿$formatted' : formatted;
    } else {
      // Fiat currencies with localized formatting
      if (showSymbol) {
        final symbol = _getCurrencySymbol(currencyUpper);
        final formatter = NumberFormat.currency(
          locale: effectiveLocale,
          symbol: symbol,
          decimalDigits: 2,
        );
        return formatter.format(price);
      } else {
        final formatter = NumberFormat.currency(
          locale: effectiveLocale,
          symbol: '',
          decimalDigits: 2,
        );
        return formatter.format(price).trim();
      }
    }
  }

  /// Format price with conversion to user's preferred currency
  Future<String> formatPriceWithConversion({
    required int priceInCents,
    required String priceCurrency,
    required String userCurrency,
    String? locale, // Optional locale for number formatting
    bool showOriginal = false,
  }) async {
    final priceCurrencyUpper = priceCurrency.toUpperCase();
    final userCurrencyUpper = userCurrency.toUpperCase();

    // If same currency, just format
    if (priceCurrencyUpper == userCurrencyUpper) {
      return formatPrice(
        priceInCents: priceInCents,
        currency: priceCurrency,
        locale: locale,
      );
    }

    try {
      // Convert price
      final convertedCents = await convertCents(
        amountCents: priceInCents,
        fromCurrency: priceCurrency,
        toCurrency: userCurrency,
      );

      final convertedFormatted = formatPrice(
        priceInCents: convertedCents,
        currency: userCurrency,
        locale: locale,
      );

      if (showOriginal) {
        final originalFormatted = formatPrice(
          priceInCents: priceInCents,
          currency: priceCurrency,
          locale: locale,
        );
        return '$convertedFormatted ($originalFormatted)';
      }

      return convertedFormatted;
    } catch (e) {
      // Fallback to original currency if conversion fails
      return formatPrice(
        priceInCents: priceInCents,
        currency: priceCurrency,
        locale: locale,
      );
    }
  }

  /// Get currency symbol for common currencies
  String _getCurrencySymbol(String currency) {
    switch (currency) {
      case 'USD':
        return '\$';
      case 'EUR':
        return '€';
      case 'GBP':
        return '£';
      case 'JPY':
        return '¥';
      case 'BTC':
        return '₿';
      default:
        return '$currency ';
    }
  }

  /// Clear cache
  void clearCache() {
    _rateCache.clear();
    _cacheExpiry.clear();
  }

  /// Preload common exchange rates
  Future<void> preloadRates({
    required String baseCurrency,
    required List<String> targetCurrencies,
  }) async {
    try {
      await Future.wait(
        targetCurrencies.map(
          (target) => getExchangeRate(
            baseCurrency: baseCurrency,
            targetCurrency: target,
          ),
        ),
      );
    } catch (e) {
      // Ignore errors during preload
    }
  }
}
