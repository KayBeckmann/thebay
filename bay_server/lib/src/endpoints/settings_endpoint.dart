import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Known settings keys.
class SettingsKeys {
  static const String paypalEmail = 'payment.paypal.email';
  static const String bitcoinWallet = 'payment.bitcoin.wallet';
  static const String newsDefaultLifetimeDays = 'news.default_lifetime_days';
  static const String slotPaypalEnabled = 'slot.paypal.enabled';
  static const String slotBitcoinEnabled = 'slot.bitcoin.enabled';
}

/// Endpoint for managing application settings.
/// Most operations require admin privileges.
class SettingsEndpoint extends Endpoint {
  /// Get a setting value by key (admin only for sensitive settings).
  Future<String?> get(Session session, String key) async {
    // Check if this is a sensitive setting
    if (_isSensitiveSetting(key)) {
      if (!await _isAdmin(session)) {
        return null;
      }
    }

    final setting = await Settings.db.findFirstRow(
      session,
      where: (t) => t.key.equals(key),
    );

    return setting?.value;
  }

  /// Get multiple settings by keys.
  Future<Map<String, String>> getMultiple(
    Session session,
    List<String> keys,
  ) async {
    final isAdmin = await _isAdmin(session);
    final result = <String, String>{};

    for (final key in keys) {
      if (_isSensitiveSetting(key) && !isAdmin) {
        continue;
      }

      final setting = await Settings.db.findFirstRow(
        session,
        where: (t) => t.key.equals(key),
      );

      if (setting != null) {
        result[key] = setting.value;
      }
    }

    return result;
  }

  /// Set a setting value (admin only).
  Future<bool> set(
    Session session,
    String key,
    String value, {
    String? description,
  }) async {
    // Check admin permission
    if (!await _isAdmin(session)) {
      return false;
    }

    final now = DateTime.now();
    var setting = await Settings.db.findFirstRow(
      session,
      where: (t) => t.key.equals(key),
    );

    if (setting != null) {
      setting.value = value;
      setting.updatedAt = now;
      if (description != null) {
        setting.description = description;
      }
      await Settings.db.updateRow(session, setting);
    } else {
      setting = Settings(
        key: key,
        value: value,
        description: description,
        updatedAt: now,
      );
      await Settings.db.insertRow(session, setting);
    }

    return true;
  }

  /// Delete a setting (admin only).
  Future<bool> delete(Session session, String key) async {
    // Check admin permission
    if (!await _isAdmin(session)) {
      return false;
    }

    final setting = await Settings.db.findFirstRow(
      session,
      where: (t) => t.key.equals(key),
    );

    if (setting == null) {
      return false;
    }

    await Settings.db.deleteRow(session, setting);
    return true;
  }

  /// Get all payment settings (admin only).
  Future<Map<String, String>> getPaymentSettings(Session session) async {
    if (!await _isAdmin(session)) {
      return {};
    }

    final keys = [
      SettingsKeys.paypalEmail,
      SettingsKeys.bitcoinWallet,
      SettingsKeys.slotPaypalEnabled,
      SettingsKeys.slotBitcoinEnabled,
    ];

    final settings = await getMultiple(session, keys);

    return {
      'paypalEmail': settings[SettingsKeys.paypalEmail] ?? '',
      'bitcoinWallet': settings[SettingsKeys.bitcoinWallet] ?? '',
      'paypalEnabled': settings[SettingsKeys.slotPaypalEnabled] ?? 'false',
      'bitcoinEnabled': settings[SettingsKeys.slotBitcoinEnabled] ?? 'false',
    };
  }

  /// Update payment settings (admin only).
  Future<bool> updatePaymentSettings(
    Session session, {
    String? paypalEmail,
    String? bitcoinWallet,
    bool? paypalEnabled,
    bool? bitcoinEnabled,
  }) async {
    if (!await _isAdmin(session)) {
      return false;
    }

    if (paypalEmail != null) {
      await set(
        session,
        SettingsKeys.paypalEmail,
        paypalEmail,
        description: 'PayPal email for receiving slot payments',
      );
    }

    if (bitcoinWallet != null) {
      await set(
        session,
        SettingsKeys.bitcoinWallet,
        bitcoinWallet,
        description: 'Bitcoin wallet address for receiving slot payments',
      );
    }

    if (paypalEnabled != null) {
      await set(
        session,
        SettingsKeys.slotPaypalEnabled,
        paypalEnabled.toString(),
        description: 'Whether PayPal is enabled for slot purchases',
      );
    }

    if (bitcoinEnabled != null) {
      await set(
        session,
        SettingsKeys.slotBitcoinEnabled,
        bitcoinEnabled.toString(),
        description: 'Whether Bitcoin is enabled for slot purchases',
      );
    }

    return true;
  }

  /// Check if a setting key is sensitive.
  bool _isSensitiveSetting(String key) {
    return key.startsWith('payment.') || key.contains('secret');
  }

  /// Check if current user is admin.
  Future<bool> _isAdmin(Session session) async {
    final authInfo = await session.authenticated;
    if (authInfo == null) return false;

    final user = await User.db.findById(session, authInfo.userId);
    return user?.role == UserRole.admin;
  }
}
