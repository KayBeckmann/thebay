import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Endpoint für Nachrichten-Entwürfe.
/// Entwürfe werden mit dem eigenen Public Key verschlüsselt gespeichert
/// und nach 7 Tagen automatisch gelöscht.
class DraftEndpoint extends Endpoint {
  /// Prüft ob der Benutzer eingeloggt ist und gibt die User-ID zurück.
  Future<int?> _getAuthenticatedUserId(Session session) async {
    final authInfo = await session.authenticated;
    return authInfo?.userId;
  }

  /// Speichert einen neuen Entwurf.
  /// Der Inhalt sollte client-seitig mit dem eigenen Public Key verschlüsselt sein.
  Future<MessageDraft?> save(
    Session session, {
    int? recipientId,
    String? recipientUsername,
    String? encryptedSubject,
    String? encryptedContent,
    int? listingId,
  }) async {
    final userId = await _getAuthenticatedUserId(session);
    if (userId == null) {
      throw Exception('Nicht authentifiziert');
    }

    // Validiere Empfänger falls angegeben
    if (recipientId != null) {
      final recipient = await User.db.findById(session, recipientId);
      if (recipient == null || !recipient.isActive) {
        throw Exception('Empfänger nicht gefunden');
      }
    }

    // Validiere Listing falls angegeben
    if (listingId != null) {
      final listing = await Listing.db.findById(session, listingId);
      if (listing == null) {
        throw Exception('Angebot nicht gefunden');
      }
    }

    final now = DateTime.now();
    final draft = MessageDraft(
      userId: userId,
      recipientId: recipientId,
      recipientUsername: recipientUsername,
      encryptedSubject: encryptedSubject,
      encryptedContent: encryptedContent,
      createdAt: now,
      updatedAt: now,
      expiresAt: now.add(const Duration(days: 7)),
      listingId: listingId,
    );

    return await MessageDraft.db.insertRow(session, draft);
  }

  /// Aktualisiert einen vorhandenen Entwurf.
  Future<MessageDraft?> update(
    Session session,
    int draftId, {
    int? recipientId,
    String? recipientUsername,
    String? encryptedSubject,
    String? encryptedContent,
    int? listingId,
  }) async {
    final userId = await _getAuthenticatedUserId(session);
    if (userId == null) {
      throw Exception('Nicht authentifiziert');
    }

    final draft = await MessageDraft.db.findById(session, draftId);
    if (draft == null) {
      return null;
    }

    // Nur eigene Entwürfe bearbeiten
    if (draft.userId != userId) {
      throw Exception('Keine Berechtigung');
    }

    // Validiere Empfänger falls angegeben
    if (recipientId != null) {
      final recipient = await User.db.findById(session, recipientId);
      if (recipient == null || !recipient.isActive) {
        throw Exception('Empfänger nicht gefunden');
      }
    }

    // Validiere Listing falls angegeben
    if (listingId != null) {
      final listing = await Listing.db.findById(session, listingId);
      if (listing == null) {
        throw Exception('Angebot nicht gefunden');
      }
    }

    // Aktualisiere Felder
    draft.recipientId = recipientId;
    draft.recipientUsername = recipientUsername;
    draft.encryptedSubject = encryptedSubject;
    draft.encryptedContent = encryptedContent;
    draft.listingId = listingId;
    draft.updatedAt = DateTime.now();
    // Verlängere Ablaufzeit bei Aktualisierung
    draft.expiresAt = DateTime.now().add(const Duration(days: 7));

    return await MessageDraft.db.updateRow(session, draft);
  }

  /// Ruft alle Entwürfe des Benutzers ab.
  Future<List<MessageDraft>> getAll(
    Session session, {
    int limit = 25,
    int offset = 0,
  }) async {
    final userId = await _getAuthenticatedUserId(session);
    if (userId == null) {
      throw Exception('Nicht authentifiziert');
    }

    return await MessageDraft.db.find(
      session,
      where: (t) => t.userId.equals(userId),
      orderBy: (t) => t.updatedAt,
      orderDescending: true,
      limit: limit,
      offset: offset,
    );
  }

  /// Ruft einen einzelnen Entwurf ab.
  Future<MessageDraft?> getById(Session session, int draftId) async {
    final userId = await _getAuthenticatedUserId(session);
    if (userId == null) {
      throw Exception('Nicht authentifiziert');
    }

    final draft = await MessageDraft.db.findById(session, draftId);
    if (draft == null) {
      return null;
    }

    // Nur eigene Entwürfe abrufen
    if (draft.userId != userId) {
      throw Exception('Keine Berechtigung');
    }

    return draft;
  }

  /// Löscht einen Entwurf.
  Future<bool> delete(Session session, int draftId) async {
    final userId = await _getAuthenticatedUserId(session);
    if (userId == null) {
      throw Exception('Nicht authentifiziert');
    }

    final draft = await MessageDraft.db.findById(session, draftId);
    if (draft == null) {
      return false;
    }

    // Nur eigene Entwürfe löschen
    if (draft.userId != userId) {
      throw Exception('Keine Berechtigung');
    }

    await MessageDraft.db.deleteRow(session, draft);
    return true;
  }

  /// Zählt die Anzahl der Entwürfe des Benutzers.
  Future<int> getCount(Session session) async {
    final userId = await _getAuthenticatedUserId(session);
    if (userId == null) {
      throw Exception('Nicht authentifiziert');
    }

    final drafts = await MessageDraft.db.find(
      session,
      where: (t) => t.userId.equals(userId),
    );

    return drafts.length;
  }

  /// Ruft den Entwurf für ein bestimmtes Listing ab (falls vorhanden).
  Future<MessageDraft?> getByListing(Session session, int listingId) async {
    final userId = await _getAuthenticatedUserId(session);
    if (userId == null) {
      throw Exception('Nicht authentifiziert');
    }

    return await MessageDraft.db.findFirstRow(
      session,
      where: (t) => t.userId.equals(userId) & t.listingId.equals(listingId),
    );
  }

  /// Ruft den Entwurf für einen bestimmten Empfänger ab (falls vorhanden).
  Future<MessageDraft?> getByRecipient(Session session, int recipientId) async {
    final userId = await _getAuthenticatedUserId(session);
    if (userId == null) {
      throw Exception('Nicht authentifiziert');
    }

    return await MessageDraft.db.findFirstRow(
      session,
      where: (t) =>
          t.userId.equals(userId) &
          t.recipientId.equals(recipientId) &
          t.listingId.equals(null),
    );
  }
}
