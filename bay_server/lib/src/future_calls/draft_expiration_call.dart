import 'dart:async';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Service der abgelaufene Entwürfe automatisch löscht.
/// Läuft alle 6 Stunden im Hintergrund.
class DraftExpirationService {
  /// Intervall in Stunden für die Ausführung
  static const int intervalHours = 6;

  static Timer? _timer;

  /// Startet den Service (beim Server-Start aufrufen).
  static Future<void> start(Serverpod pod) async {
    // Führe sofort aus
    await _runExpiration(pod);

    // Starte Timer für periodische Ausführung
    _timer = Timer.periodic(
      const Duration(hours: intervalHours),
      (_) => _runExpiration(pod),
    );

    // ignore: avoid_print
    print(
        'DraftExpirationService: Gestartet (Intervall: $intervalHours Stunde(n))');
  }

  /// Stoppt den Service.
  static void stop() {
    _timer?.cancel();
    _timer = null;
  }

  static Future<void> _runExpiration(Serverpod pod) async {
    final session = await pod.createSession();
    try {
      session.log('DraftExpirationService: Starte Löschung abgelaufener Entwürfe...');

      final now = DateTime.now();

      // Finde alle abgelaufenen Entwürfe
      final expiredDrafts = await MessageDraft.db.find(
        session,
        where: (t) => t.expiresAt < now,
      );

      // Lösche abgelaufene Entwürfe
      int deletedCount = 0;
      for (final draft in expiredDrafts) {
        await MessageDraft.db.deleteRow(session, draft);
        deletedCount++;
      }

      session.log(
        'DraftExpirationService: Fertig. $deletedCount Entwürfe gelöscht.',
      );
    } catch (e) {
      session.log('DraftExpirationService: Fehler: $e');
    } finally {
      await session.close();
    }
  }
}
