import 'package:shared_preferences/shared_preferences.dart';

/// Service for managing user preferences (local storage)
class UserPreferencesService {
  static const String _currencyPref = 'user_currency';
  static const String _paginationSizePref = 'pagination_size';
  static const String _languagePref = 'user_language';

  /// Get the user's preferred currency
  Future<String> getCurrency() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_currencyPref) ?? 'USD';
  }

  /// Set the user's preferred currency
  Future<void> setCurrency(String currency) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_currencyPref, currency);
  }

  /// Get the user's preferred pagination size
  Future<int> getPaginationSize() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_paginationSizePref) ?? 25;
  }

  /// Set the user's preferred pagination size
  Future<void> setPaginationSize(int size) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_paginationSizePref, size);
  }

  /// Get the user's preferred language (ISO code)
  Future<String> getLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_languagePref) ?? 'en';
  }

  /// Set the user's preferred language (ISO code)
  Future<void> setLanguage(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languagePref, languageCode);
  }

  /// Clear all preferences
  Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_currencyPref);
    await prefs.remove(_paginationSizePref);
    await prefs.remove(_languagePref);
  }
}
