import 'package:serverpod/serverpod.dart' hide Transaction;

import '../generated/protocol.dart';

/// Endpoint für Reklamationen (Disputes).
class DisputeEndpoint extends Endpoint {
  /// Prüft ob der Benutzer eingeloggt ist und gibt die User-ID zurück.
  Future<int?> _getAuthenticatedUserId(Session session) async {
    final authInfo = await session.authenticated;
    return authInfo?.userId;
  }

  /// Prüft ob der Benutzer Moderator oder Admin ist.
  Future<bool> _isModerator(Session session) async {
    final userId = await _getAuthenticatedUserId(session);
    if (userId == null) return false;

    final user = await User.db.findById(session, userId);
    if (user == null) return false;

    return user.role == UserRole.moderator || user.role == UserRole.admin;
  }

  /// Ruft eine Reklamation per ID ab.
  Future<Dispute?> getById(Session session, int disputeId) async {
    final userId = await _getAuthenticatedUserId(session);
    if (userId == null) {
      throw Exception('Nicht authentifiziert');
    }

    final dispute = await Dispute.db.findById(session, disputeId);
    if (dispute == null) {
      return null;
    }

    // Lade zugehörige Transaktion
    final transaction = await Transaction.db.findById(
      session,
      dispute.transactionId,
    );
    if (transaction == null) {
      return null;
    }

    // Nur beteiligte Parteien oder Moderatoren dürfen sehen
    final isMod = await _isModerator(session);
    if (transaction.buyerId != userId &&
        transaction.sellerId != userId &&
        !isMod) {
      throw Exception('Keine Berechtigung');
    }

    return dispute;
  }

  /// Ruft alle Reklamationen für eine Transaktion ab.
  Future<List<Dispute>> getByTransaction(
    Session session,
    int transactionId,
  ) async {
    final userId = await _getAuthenticatedUserId(session);
    if (userId == null) {
      throw Exception('Nicht authentifiziert');
    }

    // Lade Transaktion
    final transaction = await Transaction.db.findById(session, transactionId);
    if (transaction == null) {
      throw Exception('Transaktion nicht gefunden');
    }

    // Nur beteiligte Parteien oder Moderatoren dürfen sehen
    final isMod = await _isModerator(session);
    if (transaction.buyerId != userId &&
        transaction.sellerId != userId &&
        !isMod) {
      throw Exception('Keine Berechtigung');
    }

    return await Dispute.db.find(
      session,
      where: (d) => d.transactionId.equals(transactionId),
      orderBy: (d) => d.createdAt,
      orderDescending: true,
    );
  }

  /// Ruft alle offenen Reklamationen ab (nur Moderatoren).
  Future<List<Dispute>> getOpenDisputes(
    Session session, {
    int limit = 25,
    int offset = 0,
  }) async {
    final isMod = await _isModerator(session);
    if (!isMod) {
      throw Exception('Nur Moderatoren können alle Reklamationen sehen');
    }

    return await Dispute.db.find(
      session,
      where: (d) => d.status.equals(DisputeStatus.open),
      orderBy: (d) => d.createdAt,
      orderDescending: false, // Älteste zuerst
      limit: limit,
      offset: offset,
    );
  }

  /// Zählt offene Reklamationen (für Moderatoren).
  Future<int> getOpenCount(Session session) async {
    final isMod = await _isModerator(session);
    if (!isMod) {
      throw Exception('Nur Moderatoren können Reklamationen zählen');
    }

    final disputes = await Dispute.db.find(
      session,
      where: (d) => d.status.equals(DisputeStatus.open),
    );

    return disputes.length;
  }

  /// Übernimmt eine Reklamation (Moderator weist sich selbst zu).
  Future<Dispute> assignToMe(Session session, int disputeId) async {
    final userId = await _getAuthenticatedUserId(session);
    if (userId == null) {
      throw Exception('Nicht authentifiziert');
    }

    final isMod = await _isModerator(session);
    if (!isMod) {
      throw Exception('Nur Moderatoren können Reklamationen übernehmen');
    }

    final dispute = await Dispute.db.findById(session, disputeId);
    if (dispute == null) {
      throw Exception('Reklamation nicht gefunden');
    }

    if (dispute.status != DisputeStatus.open) {
      throw Exception('Reklamation ist nicht offen');
    }

    dispute.moderatorId = userId;
    return await Dispute.db.updateRow(session, dispute);
  }

  /// Löst eine Reklamation (nur Moderatoren).
  Future<Dispute> resolve(
    Session session,
    int disputeId, {
    required String resolution,
    required bool completTransaction,
  }) async {
    final userId = await _getAuthenticatedUserId(session);
    if (userId == null) {
      throw Exception('Nicht authentifiziert');
    }

    final isMod = await _isModerator(session);
    if (!isMod) {
      throw Exception('Nur Moderatoren können Reklamationen lösen');
    }

    final dispute = await Dispute.db.findById(session, disputeId);
    if (dispute == null) {
      throw Exception('Reklamation nicht gefunden');
    }

    if (dispute.status != DisputeStatus.open) {
      throw Exception('Reklamation ist bereits geschlossen');
    }

    // Aktualisiere Reklamation
    final now = DateTime.now();
    dispute.status = DisputeStatus.resolved;
    dispute.resolution = resolution;
    dispute.resolvedAt = now;
    if (dispute.moderatorId == null) {
      dispute.moderatorId = userId;
    }

    await Dispute.db.updateRow(session, dispute);

    // Aktualisiere Transaktion
    final transaction = await Transaction.db.findById(
      session,
      dispute.transactionId,
    );
    if (transaction != null) {
      if (completTransaction) {
        // Transaktion abschließen
        transaction.status = TransactionStatus.completed;
        transaction.completedAt = now;
      } else {
        // Transaktion abbrechen
        transaction.status = TransactionStatus.cancelled;
      }
      transaction.updatedAt = now;
      await Transaction.db.updateRow(session, transaction);
    }

    return dispute;
  }

  /// Schließt eine Reklamation ohne Lösung (nur Moderatoren).
  Future<Dispute> close(
    Session session,
    int disputeId, {
    String? resolution,
  }) async {
    final userId = await _getAuthenticatedUserId(session);
    if (userId == null) {
      throw Exception('Nicht authentifiziert');
    }

    final isMod = await _isModerator(session);
    if (!isMod) {
      throw Exception('Nur Moderatoren können Reklamationen schließen');
    }

    final dispute = await Dispute.db.findById(session, disputeId);
    if (dispute == null) {
      throw Exception('Reklamation nicht gefunden');
    }

    if (dispute.status != DisputeStatus.open) {
      throw Exception('Reklamation ist bereits geschlossen');
    }

    dispute.status = DisputeStatus.closed;
    dispute.resolution = resolution;
    dispute.resolvedAt = DateTime.now();
    if (dispute.moderatorId == null) {
      dispute.moderatorId = userId;
    }

    return await Dispute.db.updateRow(session, dispute);
  }

  /// Ruft meine Reklamationen ab (als Käufer/Verkäufer).
  Future<List<Dispute>> getMyDisputes(
    Session session, {
    DisputeStatus? status,
    int limit = 25,
    int offset = 0,
  }) async {
    final userId = await _getAuthenticatedUserId(session);
    if (userId == null) {
      throw Exception('Nicht authentifiziert');
    }

    // Finde alle Transaktionen des Benutzers
    final transactions = await Transaction.db.find(
      session,
      where: (t) => t.buyerId.equals(userId) | t.sellerId.equals(userId),
    );

    if (transactions.isEmpty) {
      return [];
    }

    final transactionIds = transactions.map((t) => t.id!).toList();

    // Finde alle Reklamationen zu diesen Transaktionen
    final allDisputes = await Dispute.db.find(
      session,
      orderBy: (d) => d.createdAt,
      orderDescending: true,
    );

    // Filtere nach Transaktions-IDs und optional Status
    var filtered = allDisputes.where(
      (d) => transactionIds.contains(d.transactionId),
    );

    if (status != null) {
      filtered = filtered.where((d) => d.status == status);
    }

    // Pagination
    final list = filtered.toList();
    if (offset >= list.length) {
      return [];
    }
    final end = (offset + limit) > list.length ? list.length : offset + limit;
    return list.sublist(offset, end);
  }
}
