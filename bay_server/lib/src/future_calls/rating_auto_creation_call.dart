import 'dart:async';

import 'package:serverpod/serverpod.dart' hide Transaction;

import '../generated/protocol.dart';

/// Service der automatisch positive Bewertungen für abgeschlossene Transaktionen erstellt.
/// Läuft alle 12 Stunden im Hintergrund.
class RatingAutoCreationService {
  /// Intervall in Stunden für die Ausführung
  static const int intervalHours = 12;

  static Timer? _timer;

  /// Startet den Service (beim Server-Start aufrufen).
  static Future<void> start(Serverpod pod) async {
    // Führe sofort aus
    await _runAutoCreation(pod);

    // Starte Timer für periodische Ausführung
    _timer = Timer.periodic(
      const Duration(hours: intervalHours),
      (_) => _runAutoCreation(pod),
    );

    // ignore: avoid_print
    print(
        'RatingAutoCreationService: Gestartet (Intervall: $intervalHours Stunde(n))');
  }

  /// Stoppt den Service.
  static void stop() {
    _timer?.cancel();
    _timer = null;
  }

  static Future<void> _runAutoCreation(Serverpod pod) async {
    final session = await pod.createSession();
    try {
      session.log(
          'RatingAutoCreationService: Starte automatische Bewertungserstellung...');

      final now = DateTime.now();
      final threshold = now.subtract(const Duration(days: 14));

      // Finde alle abgeschlossenen Transaktionen, die vor mehr als 14 Tagen abgeschlossen wurden
      final transactions = await Transaction.db.find(
        session,
        where: (t) => t.status.equals(TransactionStatus.completed),
      );

      int createdCount = 0;

      for (final transaction in transactions) {
        // Überspringe Transaktionen die noch nicht 14 Tage alt sind
        if (transaction.completedAt == null ||
            transaction.completedAt!.isAfter(threshold)) {
          continue;
        }

        // Prüfe ob Käufer bereits bewertet hat
        final buyerRating = await Rating.db.findFirstRow(
          session,
          where: (r) =>
              r.transactionId.equals(transaction.id!) &
              r.fromUserId.equals(transaction.buyerId),
        );

        // Erstelle automatische Bewertung vom Käufer an den Verkäufer
        if (buyerRating == null) {
          final autoRatingBuyer = Rating(
            transactionId: transaction.id!,
            fromUserId: transaction.buyerId,
            toUserId: transaction.sellerId,
            rating: RatingValue.positive,
            comment: null,
            createdAt: now,
            isAutomatic: true,
          );
          await Rating.db.insertRow(session, autoRatingBuyer);
          createdCount++;
        }

        // Prüfe ob Verkäufer bereits bewertet hat
        final sellerRating = await Rating.db.findFirstRow(
          session,
          where: (r) =>
              r.transactionId.equals(transaction.id!) &
              r.fromUserId.equals(transaction.sellerId),
        );

        // Erstelle automatische Bewertung vom Verkäufer an den Käufer
        if (sellerRating == null) {
          final autoRatingSeller = Rating(
            transactionId: transaction.id!,
            fromUserId: transaction.sellerId,
            toUserId: transaction.buyerId,
            rating: RatingValue.positive,
            comment: null,
            createdAt: now,
            isAutomatic: true,
          );
          await Rating.db.insertRow(session, autoRatingSeller);
          createdCount++;
        }
      }

      session.log(
        'RatingAutoCreationService: Fertig. $createdCount automatische Bewertungen erstellt.',
      );
    } catch (e) {
      session.log('RatingAutoCreationService: Fehler: $e');
    } finally {
      await session.close();
    }
  }
}
