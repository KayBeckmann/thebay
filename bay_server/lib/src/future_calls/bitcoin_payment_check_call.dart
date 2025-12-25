import 'dart:async';
import 'dart:io';

import 'package:serverpod/serverpod.dart';

import '../services/payment_service.dart';

/// Service der Bitcoin-Zahlungseingänge überwacht.
/// Prüft alle 10 Minuten die Blockchain auf Bestätigungen für ausstehende Bestellungen.
class BitcoinPaymentCheckService {
  /// Intervall in Minuten für die Ausführung
  static const int intervalMinutes = 10;

  static Timer? _timer;

  /// Startet den Service (beim Server-Start aufrufen).
  static Future<void> start(Serverpod pod) async {
    // Führe nach 1 Minute das erste Mal aus (gibt Server Zeit zu starten)
    Future.delayed(const Duration(minutes: 1), () => _runCheck(pod));

    // Starte Timer für periodische Ausführung
    _timer = Timer.periodic(
      const Duration(minutes: intervalMinutes),
      (_) => _runCheck(pod),
    );

    // ignore: avoid_print
    print('BitcoinPaymentCheckService: Gestartet (Intervall: $intervalMinutes Minute(n))');
  }

  /// Stoppt den Service.
  static void stop() {
    _timer?.cancel();
    _timer = null;
  }

  static Future<void> _runCheck(Serverpod pod) async {
    final session = await pod.createSession();
    try {
      session.log('BitcoinPaymentCheckService: Prüfe Bitcoin-Zahlungen...');

      // Hole BlockCypher API Token aus Environment (optional)
      final blockCypherToken = Platform.environment['BLOCKCYPHER_TOKEN'];

      // Prüfe alle ausstehenden Bitcoin-Zahlungen
      final processedCount = await PaymentService.checkPendingBitcoinPayments(
        session,
        blockCypherToken: blockCypherToken,
      );

      if (processedCount > 0) {
        session.log(
          'BitcoinPaymentCheckService: $processedCount Zahlung(en) bestätigt und verarbeitet.',
        );
      } else {
        session.log('BitcoinPaymentCheckService: Keine neuen Zahlungen.');
      }
    } catch (e, stackTrace) {
      session.log(
        'BitcoinPaymentCheckService: Fehler: $e\n$stackTrace',
        level: LogLevel.error,
      );
    } finally {
      await session.close();
    }
  }
}
