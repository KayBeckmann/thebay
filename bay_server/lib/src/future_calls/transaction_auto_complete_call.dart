import 'dart:async';

import 'package:serverpod/serverpod.dart' hide Transaction;

import '../generated/protocol.dart';

/// Service der Transaktionen nach 14 Tagen automatisch abschließt.
/// Läuft alle 6 Stunden im Hintergrund.
class TransactionAutoCompleteService {
  /// Intervall in Stunden für die Ausführung
  static const int intervalHours = 6;

  static Timer? _timer;

  /// Startet den Service (beim Server-Start aufrufen).
  static Future<void> start(Serverpod pod) async {
    // Führe sofort aus
    await _runAutoComplete(pod);

    // Starte Timer für periodische Ausführung
    _timer = Timer.periodic(
      const Duration(hours: intervalHours),
      (_) => _runAutoComplete(pod),
    );

    // ignore: avoid_print
    print(
        'TransactionAutoCompleteService: Gestartet (Intervall: $intervalHours Stunde(n))');
  }

  /// Stoppt den Service.
  static void stop() {
    _timer?.cancel();
    _timer = null;
  }

  static Future<void> _runAutoComplete(Serverpod pod) async {
    final session = await pod.createSession();
    try {
      session.log(
          'TransactionAutoCompleteService: Starte automatischen Abschluss...');

      final now = DateTime.now();

      // Finde alle Transaktionen im Status "shipped" mit abgelaufenem autoCompleteAt
      final transactions = await Transaction.db.find(
        session,
        where: (t) =>
            t.status.equals(TransactionStatus.shipped) &
            t.autoCompleteAt.notEquals(null),
      );

      int completedCount = 0;
      for (final transaction in transactions) {
        // Prüfe ob autoCompleteAt in der Vergangenheit liegt
        if (transaction.autoCompleteAt != null &&
            transaction.autoCompleteAt!.isBefore(now)) {
          // Schließe Transaktion ab
          transaction.status = TransactionStatus.completed;
          transaction.receivedAt = now;
          transaction.completedAt = now;
          transaction.updatedAt = now;
          transaction.autoCompleteAt = null;

          await Transaction.db.updateRow(session, transaction);
          completedCount++;

          session.log(
              'TransactionAutoCompleteService: Transaktion ${transaction.id} automatisch abgeschlossen.');
        }
      }

      session.log(
        'TransactionAutoCompleteService: Fertig. $completedCount Transaktionen abgeschlossen.',
      );
    } catch (e) {
      session.log('TransactionAutoCompleteService: Fehler: $e');
    } finally {
      await session.close();
    }
  }
}
