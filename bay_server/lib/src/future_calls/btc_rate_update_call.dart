import 'dart:async';

import 'package:serverpod/serverpod.dart';

import '../services/currency_service.dart';

/// Service der den BTC/USD Wechselkurs periodisch aktualisiert.
/// Ruft alle 10 Minuten den aktuellen Kurs von CoinGecko ab und speichert ihn im Cache.
class BtcRateUpdateService {
  /// Intervall in Minuten für die Ausführung
  static const int intervalMinutes = 10;

  static Timer? _timer;

  /// Der zuletzt abgerufene BTC/USD Kurs (für schnellen Zugriff ohne DB)
  static double? _cachedBtcUsdRate;

  /// Zeitpunkt des letzten Updates
  static DateTime? _lastUpdate;

  /// Startet den Service (beim Server-Start aufrufen).
  static Future<void> start(Serverpod pod) async {
    // Führe sofort das erste Mal aus, um den Kurs zu haben
    await _updateRate(pod);

    // Starte Timer für periodische Ausführung
    _timer = Timer.periodic(
      const Duration(minutes: intervalMinutes),
      (_) => _updateRate(pod),
    );

    // ignore: avoid_print
    print('BtcRateUpdateService: Gestartet (Intervall: $intervalMinutes Minute(n))');
  }

  /// Stoppt den Service.
  static void stop() {
    _timer?.cancel();
    _timer = null;
  }

  /// Gibt den aktuellen BTC/USD Kurs zurück.
  /// Falls kein Kurs im Cache ist, wird ein Fallback-Wert verwendet.
  static double getBtcUsdRate() {
    return _cachedBtcUsdRate ?? _fallbackRate;
  }

  /// Gibt den Zeitpunkt des letzten Updates zurück.
  static DateTime? getLastUpdate() {
    return _lastUpdate;
  }

  /// Prüft ob der Cache aktuell ist (nicht älter als 15 Minuten).
  static bool isCacheValid() {
    if (_lastUpdate == null) return false;
    return DateTime.now().difference(_lastUpdate!).inMinutes < 15;
  }

  /// Fallback-Rate falls API nicht erreichbar ist
  static const double _fallbackRate = 100000.0;

  static Future<void> _updateRate(Serverpod pod) async {
    final session = await pod.createSession();
    try {
      session.log('BtcRateUpdateService: Aktualisiere BTC/USD Kurs...');

      // Hole den Kurs über CurrencyService (dieser ruft die API ab und cached)
      final rate = await CurrencyService.getExchangeRate(
        session,
        baseCurrency: 'BTC',
        targetCurrency: 'USD',
      );

      // Speichere im lokalen Cache für schnellen Zugriff
      _cachedBtcUsdRate = rate;
      _lastUpdate = DateTime.now();

      session.log(
        'BtcRateUpdateService: BTC/USD Kurs aktualisiert: \$${rate.toStringAsFixed(2)}',
      );
    } catch (e, stackTrace) {
      session.log(
        'BtcRateUpdateService: Fehler beim Abrufen des Kurses: $e\n$stackTrace',
        level: LogLevel.error,
      );

      // Bei Fehler: Behalte den alten Kurs oder nutze Fallback
      if (_cachedBtcUsdRate == null) {
        _cachedBtcUsdRate = _fallbackRate;
        session.log(
          'BtcRateUpdateService: Verwende Fallback-Kurs: \$$_fallbackRate',
          level: LogLevel.warning,
        );
      }
    } finally {
      await session.close();
    }
  }

  /// Konvertiert USD zu BTC mit dem gecachten Kurs.
  static double convertUsdToBtc(double usd) {
    final rate = getBtcUsdRate();
    return usd / rate;
  }

  /// Konvertiert BTC zu USD mit dem gecachten Kurs.
  static double convertBtcToUsd(double btc) {
    final rate = getBtcUsdRate();
    return btc * rate;
  }
}
