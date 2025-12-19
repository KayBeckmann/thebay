import 'package:serverpod/serverpod.dart' hide Transaction;

import '../generated/protocol.dart';

/// Endpoint für Transaktionen (Handelsablauf).
class TransactionEndpoint extends Endpoint {
  /// Prüft ob der Benutzer eingeloggt ist und gibt die User-ID zurück.
  Future<int?> _getAuthenticatedUserId(Session session) async {
    final authInfo = await session.authenticated;
    return authInfo?.userId;
  }

  /// Startet eine neue Transaktion (Käufer initiiert).
  Future<Transaction> create(
    Session session, {
    required int listingId,
    required double quantity,
    String? buyerNote,
  }) async {
    final buyerId = await _getAuthenticatedUserId(session);
    if (buyerId == null) {
      throw Exception('Nicht authentifiziert');
    }

    // Lade das Angebot
    final listing = await Listing.db.findById(session, listingId);
    if (listing == null || !listing.isActive) {
      throw Exception('Angebot nicht gefunden oder nicht aktiv');
    }

    // Prüfe ob Angebot abgelaufen ist
    if (listing.expiresAt != null && listing.expiresAt!.isBefore(DateTime.now())) {
      throw Exception('Angebot ist abgelaufen');
    }

    // Käufer darf nicht der Verkäufer sein
    if (listing.userId == buyerId) {
      throw Exception('Du kannst dein eigenes Angebot nicht kaufen');
    }

    // Prüfe Menge
    if (quantity <= 0) {
      throw Exception('Ungültige Menge');
    }
    if (quantity > listing.quantity) {
      throw Exception('Gewünschte Menge übersteigt verfügbare Menge');
    }

    // Berechne Gesamtpreis
    final totalPriceCents = (listing.pricePerUnit * quantity).round();

    // Bestimme Zahlungsmethode basierend auf Angebot
    PaymentMethod paymentMethod;
    if (listing.acceptsPaypal && !listing.acceptsBitcoin) {
      paymentMethod = PaymentMethod.paypal;
    } else if (listing.acceptsBitcoin && !listing.acceptsPaypal) {
      paymentMethod = PaymentMethod.bitcoin;
    } else {
      // Wenn beides akzeptiert wird, standardmäßig PayPal
      paymentMethod = PaymentMethod.paypal;
    }

    final now = DateTime.now();
    final transaction = Transaction(
      buyerId: buyerId,
      sellerId: listing.userId,
      listingId: listingId,
      status: TransactionStatus.open,
      quantity: quantity,
      totalPriceCents: totalPriceCents,
      paymentMethod: paymentMethod,
      createdAt: now,
      updatedAt: now,
      buyerNote: buyerNote,
    );

    return await Transaction.db.insertRow(session, transaction);
  }

  /// Ruft eine Transaktion per ID ab.
  Future<Transaction?> getById(Session session, int transactionId) async {
    final userId = await _getAuthenticatedUserId(session);
    if (userId == null) {
      throw Exception('Nicht authentifiziert');
    }

    final transaction = await Transaction.db.findById(session, transactionId);
    if (transaction == null) {
      return null;
    }

    // Nur Käufer oder Verkäufer dürfen die Transaktion sehen
    if (transaction.buyerId != userId && transaction.sellerId != userId) {
      throw Exception('Keine Berechtigung');
    }

    return transaction;
  }

  /// Ruft alle Transaktionen des Benutzers ab.
  Future<List<Transaction>> getMyTransactions(
    Session session, {
    TransactionStatus? status,
    bool asBuyer = true,
    bool asSeller = true,
    int limit = 25,
    int offset = 0,
  }) async {
    final userId = await _getAuthenticatedUserId(session);
    if (userId == null) {
      throw Exception('Nicht authentifiziert');
    }

    // Baue die Where-Klausel
    List<Transaction> transactions;

    if (asBuyer && asSeller) {
      // Beide Rollen
      transactions = await Transaction.db.find(
        session,
        where: (t) {
          var condition = t.buyerId.equals(userId) | t.sellerId.equals(userId);
          if (status != null) {
            condition = condition & t.status.equals(status);
          }
          return condition;
        },
        orderBy: (t) => t.createdAt,
        orderDescending: true,
        limit: limit,
        offset: offset,
      );
    } else if (asBuyer) {
      // Nur als Käufer
      transactions = await Transaction.db.find(
        session,
        where: (t) {
          var condition = t.buyerId.equals(userId);
          if (status != null) {
            condition = condition & t.status.equals(status);
          }
          return condition;
        },
        orderBy: (t) => t.createdAt,
        orderDescending: true,
        limit: limit,
        offset: offset,
      );
    } else if (asSeller) {
      // Nur als Verkäufer
      transactions = await Transaction.db.find(
        session,
        where: (t) {
          var condition = t.sellerId.equals(userId);
          if (status != null) {
            condition = condition & t.status.equals(status);
          }
          return condition;
        },
        orderBy: (t) => t.createdAt,
        orderDescending: true,
        limit: limit,
        offset: offset,
      );
    } else {
      transactions = [];
    }

    return transactions;
  }

  /// Markiert eine Transaktion als versendet (nur Verkäufer).
  Future<Transaction> markAsShipped(Session session, int transactionId) async {
    final userId = await _getAuthenticatedUserId(session);
    if (userId == null) {
      throw Exception('Nicht authentifiziert');
    }

    final transaction = await Transaction.db.findById(session, transactionId);
    if (transaction == null) {
      throw Exception('Transaktion nicht gefunden');
    }

    // Nur Verkäufer darf als versendet markieren
    if (transaction.sellerId != userId) {
      throw Exception('Nur der Verkäufer kann als versendet markieren');
    }

    // Prüfe Status
    if (transaction.status != TransactionStatus.paid) {
      throw Exception('Transaktion kann nicht als versendet markiert werden (Status: ${transaction.status})');
    }

    final now = DateTime.now();
    transaction.status = TransactionStatus.shipped;
    transaction.shippedAt = now;
    transaction.updatedAt = now;
    // Setze automatischen Abschluss auf 14 Tage nach Versand
    transaction.autoCompleteAt = now.add(const Duration(days: 14));

    return await Transaction.db.updateRow(session, transaction);
  }

  /// Markiert eine Transaktion als bezahlt (nur Käufer).
  Future<Transaction> markAsPaid(Session session, int transactionId) async {
    final userId = await _getAuthenticatedUserId(session);
    if (userId == null) {
      throw Exception('Nicht authentifiziert');
    }

    final transaction = await Transaction.db.findById(session, transactionId);
    if (transaction == null) {
      throw Exception('Transaktion nicht gefunden');
    }

    // Nur Käufer darf als bezahlt markieren
    if (transaction.buyerId != userId) {
      throw Exception('Nur der Käufer kann als bezahlt markieren');
    }

    // Prüfe Status
    if (transaction.status != TransactionStatus.open) {
      throw Exception('Transaktion kann nicht als bezahlt markiert werden (Status: ${transaction.status})');
    }

    transaction.status = TransactionStatus.paid;
    transaction.updatedAt = DateTime.now();

    return await Transaction.db.updateRow(session, transaction);
  }

  /// Markiert eine Transaktion als erhalten (nur Käufer).
  /// Schließt die Transaktion ab.
  Future<Transaction> markAsReceived(Session session, int transactionId) async {
    final userId = await _getAuthenticatedUserId(session);
    if (userId == null) {
      throw Exception('Nicht authentifiziert');
    }

    final transaction = await Transaction.db.findById(session, transactionId);
    if (transaction == null) {
      throw Exception('Transaktion nicht gefunden');
    }

    // Nur Käufer darf als erhalten markieren
    if (transaction.buyerId != userId) {
      throw Exception('Nur der Käufer kann als erhalten markieren');
    }

    // Prüfe Status - muss shipped sein
    if (transaction.status != TransactionStatus.shipped) {
      throw Exception('Transaktion muss erst als versendet markiert sein');
    }

    final now = DateTime.now();
    transaction.status = TransactionStatus.completed;
    transaction.receivedAt = now;
    transaction.completedAt = now;
    transaction.updatedAt = now;
    transaction.autoCompleteAt = null; // Kein automatischer Abschluss mehr nötig

    return await Transaction.db.updateRow(session, transaction);
  }

  /// Bricht eine Transaktion ab (nur wenn Status = open).
  Future<Transaction> cancel(Session session, int transactionId) async {
    final userId = await _getAuthenticatedUserId(session);
    if (userId == null) {
      throw Exception('Nicht authentifiziert');
    }

    final transaction = await Transaction.db.findById(session, transactionId);
    if (transaction == null) {
      throw Exception('Transaktion nicht gefunden');
    }

    // Käufer oder Verkäufer kann abbrechen
    if (transaction.buyerId != userId && transaction.sellerId != userId) {
      throw Exception('Keine Berechtigung');
    }

    // Nur offene Transaktionen können abgebrochen werden
    if (transaction.status != TransactionStatus.open) {
      throw Exception('Nur offene Transaktionen können abgebrochen werden');
    }

    transaction.status = TransactionStatus.cancelled;
    transaction.updatedAt = DateTime.now();

    return await Transaction.db.updateRow(session, transaction);
  }

  /// Öffnet eine Reklamation für eine Transaktion.
  Future<Dispute> openDispute(
    Session session,
    int transactionId, {
    required String reason,
  }) async {
    final userId = await _getAuthenticatedUserId(session);
    if (userId == null) {
      throw Exception('Nicht authentifiziert');
    }

    final transaction = await Transaction.db.findById(session, transactionId);
    if (transaction == null) {
      throw Exception('Transaktion nicht gefunden');
    }

    // Käufer oder Verkäufer kann Reklamation öffnen
    if (transaction.buyerId != userId && transaction.sellerId != userId) {
      throw Exception('Keine Berechtigung');
    }

    // Nur bei versendeten Transaktionen kann reklamiert werden
    if (transaction.status != TransactionStatus.shipped) {
      throw Exception('Reklamation nur bei versendeten Transaktionen möglich');
    }

    // Prüfe ob bereits eine offene Reklamation existiert
    final existingDispute = await Dispute.db.findFirstRow(
      session,
      where: (d) =>
          d.transactionId.equals(transactionId) &
          d.status.equals(DisputeStatus.open),
    );
    if (existingDispute != null) {
      throw Exception('Es existiert bereits eine offene Reklamation');
    }

    // Setze Transaktionsstatus auf disputed
    transaction.status = TransactionStatus.disputed;
    transaction.updatedAt = DateTime.now();
    transaction.autoCompleteAt = null; // Kein automatischer Abschluss bei Reklamation
    await Transaction.db.updateRow(session, transaction);

    // Erstelle Reklamation
    final dispute = Dispute(
      transactionId: transactionId,
      openedByUserId: userId,
      reason: reason,
      status: DisputeStatus.open,
      createdAt: DateTime.now(),
    );

    return await Dispute.db.insertRow(session, dispute);
  }

  /// Zählt offene Transaktionen des Benutzers.
  Future<int> getOpenCount(Session session) async {
    final userId = await _getAuthenticatedUserId(session);
    if (userId == null) {
      throw Exception('Nicht authentifiziert');
    }

    final transactions = await Transaction.db.find(
      session,
      where: (t) =>
          (t.buyerId.equals(userId) | t.sellerId.equals(userId)) &
          (t.status.equals(TransactionStatus.open) |
              t.status.equals(TransactionStatus.paid) |
              t.status.equals(TransactionStatus.shipped)),
    );

    return transactions.length;
  }

  /// Zählt abgeschlossene Transaktionen eines Benutzers.
  Future<int> getCompletedCount(Session session, int userId) async {
    final viewerId = await _getAuthenticatedUserId(session);
    if (viewerId == null) {
      throw Exception('Nicht authentifiziert');
    }

    final transactions = await Transaction.db.find(
      session,
      where: (t) =>
          (t.buyerId.equals(userId) | t.sellerId.equals(userId)) &
          t.status.equals(TransactionStatus.completed),
    );

    return transactions.length;
  }

  /// Automatischer Abschluss von Transaktionen (für Cron-Job).
  /// Gibt die Anzahl der abgeschlossenen Transaktionen zurück.
  /// Nur für Admins zugänglich.
  Future<int> autoCompleteExpired(Session session) async {
    // Prüfe ob Admin
    final userId = await _getAuthenticatedUserId(session);
    if (userId == null) {
      throw Exception('Nicht authentifiziert');
    }
    final user = await User.db.findById(session, userId);
    if (user == null || user.role != UserRole.admin) {
      throw Exception('Nur Administratoren können diese Funktion ausführen');
    }

    final now = DateTime.now();

    // Finde alle Transaktionen die automatisch abgeschlossen werden sollen
    final transactions = await Transaction.db.find(
      session,
      where: (t) =>
          t.status.equals(TransactionStatus.shipped) &
          t.autoCompleteAt.notEquals(null),
    );

    int completedCount = 0;
    for (final transaction in transactions) {
      if (transaction.autoCompleteAt != null &&
          transaction.autoCompleteAt!.isBefore(now)) {
        transaction.status = TransactionStatus.completed;
        transaction.completedAt = now;
        transaction.updatedAt = now;
        transaction.autoCompleteAt = null;
        await Transaction.db.updateRow(session, transaction);
        completedCount++;
      }
    }

    return completedCount;
  }

  /// Ruft Transaktionen ab, die bald automatisch abgeschlossen werden.
  /// Für Benachrichtigungen (3 Tage vor Abschluss).
  Future<List<Transaction>> getUpcomingAutoComplete(
    Session session, {
    int daysAhead = 3,
  }) async {
    final userId = await _getAuthenticatedUserId(session);
    if (userId == null) {
      throw Exception('Nicht authentifiziert');
    }

    final now = DateTime.now();
    final threshold = now.add(Duration(days: daysAhead));

    final transactions = await Transaction.db.find(
      session,
      where: (t) =>
          (t.buyerId.equals(userId) | t.sellerId.equals(userId)) &
          t.status.equals(TransactionStatus.shipped) &
          t.autoCompleteAt.notEquals(null),
    );

    // Filtere manuell nach Datum (da komplexe Datumvergleiche)
    return transactions.where((t) {
      if (t.autoCompleteAt == null) return false;
      return t.autoCompleteAt!.isBefore(threshold) &&
          t.autoCompleteAt!.isAfter(now);
    }).toList();
  }

  /// Ruft die Zahlungsinformationen des Verkäufers für eine Transaktion ab.
  /// Nur für den Käufer zugänglich.
  Future<UserPaymentInfo?> getSellerPaymentInfo(
    Session session,
    int transactionId,
  ) async {
    final userId = await _getAuthenticatedUserId(session);
    if (userId == null) {
      throw Exception('Nicht authentifiziert');
    }

    final transaction = await Transaction.db.findById(session, transactionId);
    if (transaction == null) {
      throw Exception('Transaktion nicht gefunden');
    }

    // Nur der Käufer darf die Zahlungsinformationen des Verkäufers sehen
    if (transaction.buyerId != userId) {
      throw Exception('Nur der Käufer kann Zahlungsinformationen einsehen');
    }

    // Lade die Zahlungsinformationen des Verkäufers
    final paymentInfo = await UserPaymentInfo.db.findFirstRow(
      session,
      where: (p) => p.userId.equals(transaction.sellerId),
    );

    return paymentInfo;
  }
}
