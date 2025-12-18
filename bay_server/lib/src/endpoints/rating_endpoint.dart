import 'package:serverpod/serverpod.dart' hide Transaction;

import '../generated/protocol.dart';

/// Endpoint für Bewertungen nach abgeschlossenen Transaktionen.
class RatingEndpoint extends Endpoint {
  /// Prüft ob der Benutzer eingeloggt ist und gibt die User-ID zurück.
  Future<int?> _getAuthenticatedUserId(Session session) async {
    final authInfo = await session.authenticated;
    return authInfo?.userId;
  }

  /// Gibt eine Bewertung ab (nur nach abgeschlossener Transaktion).
  /// Jeder Benutzer kann nur einmal pro Transaktion bewerten.
  /// Bewertung nur innerhalb von 14 Tagen nach Abschluss möglich.
  Future<Rating> submitRating(
    Session session, {
    required int transactionId,
    required RatingValue rating,
    String? comment,
  }) async {
    final userId = await _getAuthenticatedUserId(session);
    if (userId == null) {
      throw Exception('Not authenticated');
    }

    // Lade die Transaktion
    final transaction = await Transaction.db.findById(session, transactionId);
    if (transaction == null) {
      throw Exception('Transaction not found');
    }

    // Prüfe ob der Benutzer an der Transaktion beteiligt ist
    final isBuyer = transaction.buyerId == userId;
    final isSeller = transaction.sellerId == userId;
    if (!isBuyer && !isSeller) {
      throw Exception('You are not part of this transaction');
    }

    // Prüfe ob die Transaktion abgeschlossen ist
    if (transaction.status != TransactionStatus.completed) {
      throw Exception('Ratings can only be submitted for completed transactions');
    }

    // Prüfe ob die Transaktion innerhalb der letzten 14 Tage abgeschlossen wurde
    if (transaction.completedAt != null) {
      final daysSinceCompletion =
          DateTime.now().difference(transaction.completedAt!).inDays;
      if (daysSinceCompletion > 14) {
        throw Exception('Rating window has expired (14 days after completion)');
      }
    }

    // Prüfe ob der Benutzer bereits eine Bewertung abgegeben hat
    final existingRating = await Rating.db.findFirstRow(
      session,
      where: (r) =>
          r.transactionId.equals(transactionId) & r.fromUserId.equals(userId),
    );
    if (existingRating != null) {
      throw Exception('You have already submitted a rating for this transaction');
    }

    // Bestimme den zu bewertenden Benutzer
    final toUserId = isBuyer ? transaction.sellerId : transaction.buyerId;

    // Validiere Kommentar-Länge
    if (comment != null && comment.length > 500) {
      throw Exception('Comment must be 500 characters or less');
    }

    // Erstelle die Bewertung
    final newRating = Rating(
      transactionId: transactionId,
      fromUserId: userId,
      toUserId: toUserId,
      rating: rating,
      comment: comment,
      createdAt: DateTime.now(),
      isAutomatic: false,
    );

    return await Rating.db.insertRow(session, newRating);
  }

  /// Ruft eine Bewertung per ID ab.
  Future<Rating?> getById(Session session, int ratingId) async {
    final userId = await _getAuthenticatedUserId(session);
    if (userId == null) {
      throw Exception('Not authenticated');
    }

    return await Rating.db.findById(session, ratingId);
  }

  /// Ruft alle Bewertungen für eine Transaktion ab.
  Future<List<Rating>> getByTransaction(
      Session session, int transactionId) async {
    final userId = await _getAuthenticatedUserId(session);
    if (userId == null) {
      throw Exception('Not authenticated');
    }

    return await Rating.db.find(
      session,
      where: (r) => r.transactionId.equals(transactionId),
      orderBy: (r) => r.createdAt,
    );
  }

  /// Ruft alle Bewertungen für einen Benutzer ab (empfangen).
  Future<List<Rating>> getByUser(
    Session session,
    int userId, {
    int limit = 25,
    int offset = 0,
  }) async {
    final viewerId = await _getAuthenticatedUserId(session);
    if (viewerId == null) {
      throw Exception('Not authenticated');
    }

    return await Rating.db.find(
      session,
      where: (r) => r.toUserId.equals(userId),
      orderBy: (r) => r.createdAt,
      orderDescending: true,
      limit: limit,
      offset: offset,
    );
  }

  /// Ruft alle eigenen abgegebenen Bewertungen ab.
  Future<List<Rating>> getMyGivenRatings(
    Session session, {
    int limit = 25,
    int offset = 0,
  }) async {
    final userId = await _getAuthenticatedUserId(session);
    if (userId == null) {
      throw Exception('Not authenticated');
    }

    return await Rating.db.find(
      session,
      where: (r) => r.fromUserId.equals(userId),
      orderBy: (r) => r.createdAt,
      orderDescending: true,
      limit: limit,
      offset: offset,
    );
  }

  /// Ruft alle eigenen erhaltenen Bewertungen ab.
  Future<List<Rating>> getMyReceivedRatings(
    Session session, {
    int limit = 25,
    int offset = 0,
  }) async {
    final userId = await _getAuthenticatedUserId(session);
    if (userId == null) {
      throw Exception('Not authenticated');
    }

    return await Rating.db.find(
      session,
      where: (r) => r.toUserId.equals(userId),
      orderBy: (r) => r.createdAt,
      orderDescending: true,
      limit: limit,
      offset: offset,
    );
  }

  /// Prüft ob der Benutzer eine Bewertung für eine Transaktion abgeben kann.
  Future<bool> canRateTransaction(Session session, int transactionId) async {
    final userId = await _getAuthenticatedUserId(session);
    if (userId == null) {
      return false;
    }

    // Lade die Transaktion
    final transaction = await Transaction.db.findById(session, transactionId);
    if (transaction == null) {
      return false;
    }

    // Prüfe ob der Benutzer an der Transaktion beteiligt ist
    final isBuyer = transaction.buyerId == userId;
    final isSeller = transaction.sellerId == userId;
    if (!isBuyer && !isSeller) {
      return false;
    }

    // Prüfe ob die Transaktion abgeschlossen ist
    if (transaction.status != TransactionStatus.completed) {
      return false;
    }

    // Prüfe ob die Transaktion innerhalb der letzten 14 Tage abgeschlossen wurde
    if (transaction.completedAt != null) {
      final daysSinceCompletion =
          DateTime.now().difference(transaction.completedAt!).inDays;
      if (daysSinceCompletion > 14) {
        return false;
      }
    }

    // Prüfe ob der Benutzer bereits eine Bewertung abgegeben hat
    final existingRating = await Rating.db.findFirstRow(
      session,
      where: (r) =>
          r.transactionId.equals(transactionId) & r.fromUserId.equals(userId),
    );
    return existingRating == null;
  }

  /// Gibt die Bewertungsstatistiken für einen Benutzer zurück.
  Future<RatingStats> getUserStats(Session session, int userId) async {
    final viewerId = await _getAuthenticatedUserId(session);
    if (viewerId == null) {
      throw Exception('Not authenticated');
    }

    // Lade alle Bewertungen für den Benutzer
    final ratings = await Rating.db.find(
      session,
      where: (r) => r.toUserId.equals(userId),
    );

    if (ratings.isEmpty) {
      return RatingStats(
        totalCount: 0,
        positiveCount: 0,
        neutralCount: 0,
        negativeCount: 0,
        positivePercentage: null,
      );
    }

    int positiveCount = 0;
    int neutralCount = 0;
    int negativeCount = 0;

    for (final rating in ratings) {
      switch (rating.rating) {
        case RatingValue.positive:
          positiveCount++;
          break;
        case RatingValue.neutral:
          neutralCount++;
          break;
        case RatingValue.negative:
          negativeCount++;
          break;
      }
    }

    final totalCount = ratings.length;
    // Berechne Prozentsatz positiver Bewertungen (gerundet auf 1 Dezimalstelle)
    final positivePercentage =
        ((positiveCount / totalCount) * 1000).round() / 10;

    return RatingStats(
      totalCount: totalCount,
      positiveCount: positiveCount,
      neutralCount: neutralCount,
      negativeCount: negativeCount,
      positivePercentage: positivePercentage,
    );
  }

  /// Erstellt automatische positive Bewertungen für abgelaufene Transaktionen.
  /// Wird vom Cron-Job aufgerufen (nur für Admins).
  Future<int> createAutomaticRatings(Session session) async {
    // Prüfe ob Admin
    final userId = await _getAuthenticatedUserId(session);
    if (userId == null) {
      throw Exception('Not authenticated');
    }
    final user = await User.db.findById(session, userId);
    if (user == null || user.role != UserRole.admin) {
      throw Exception('Only administrators can execute this function');
    }

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

    return createdCount;
  }

  /// Gibt die Transaktionen zurück, für die noch eine Bewertung aussteht.
  Future<List<Transaction>> getPendingRatingTransactions(Session session) async {
    final userId = await _getAuthenticatedUserId(session);
    if (userId == null) {
      throw Exception('Not authenticated');
    }

    final now = DateTime.now();
    final threshold = now.subtract(const Duration(days: 14));

    // Finde alle abgeschlossenen Transaktionen des Benutzers
    final transactions = await Transaction.db.find(
      session,
      where: (t) =>
          (t.buyerId.equals(userId) | t.sellerId.equals(userId)) &
          t.status.equals(TransactionStatus.completed),
      orderBy: (t) => t.completedAt,
      orderDescending: true,
    );

    final pendingTransactions = <Transaction>[];

    for (final transaction in transactions) {
      // Überspringe Transaktionen die älter als 14 Tage sind
      if (transaction.completedAt == null ||
          transaction.completedAt!.isBefore(threshold)) {
        continue;
      }

      // Prüfe ob der Benutzer bereits bewertet hat
      final existingRating = await Rating.db.findFirstRow(
        session,
        where: (r) =>
            r.transactionId.equals(transaction.id!) &
            r.fromUserId.equals(userId),
      );

      if (existingRating == null) {
        pendingTransactions.add(transaction);
      }
    }

    return pendingTransactions;
  }

  /// Zählt die ausstehenden Bewertungen für den Benutzer.
  Future<int> getPendingRatingCount(Session session) async {
    final pendingTransactions = await getPendingRatingTransactions(session);
    return pendingTransactions.length;
  }
}
