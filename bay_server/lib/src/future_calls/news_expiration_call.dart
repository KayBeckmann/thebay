import 'dart:async';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Service der abgelaufene News automatisch löscht.
/// Läuft alle 24 Stunden im Hintergrund.
class NewsExpirationService {
  /// Intervall in Stunden für die Ausführung
  static const int intervalHours = 24;

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
        'NewsExpirationService: Gestartet (Intervall: $intervalHours Stunde(n))');
  }

  /// Stoppt den Service.
  static void stop() {
    _timer?.cancel();
    _timer = null;
  }

  static Future<void> _runExpiration(Serverpod pod) async {
    final session = await pod.createSession();
    try {
      session.log('NewsExpirationService: Starte Löschung abgelaufener News...');

      final now = DateTime.now();

      // Finde alle abgelaufenen News
      final expiredNews = await News.db.find(
        session,
        where: (t) => t.expiresAt < now,
      );

      // Lösche abgelaufene News
      int deletedCount = 0;
      for (final news in expiredNews) {
        await News.db.deleteRow(session, news);
        deletedCount++;
      }

      session.log(
        'NewsExpirationService: Fertig. $deletedCount News gelöscht.',
      );
    } catch (e) {
      session.log('NewsExpirationService: Fehler: $e');
    } finally {
      await session.close();
    }
  }
}
