import 'package:bay_client/bay_client.dart';

import 'pgp_key_service.dart';

/// Service für verschlüsselte Nachrichten.
/// Verwaltet Senden, Empfangen und Verschlüsselung/Entschlüsselung.
class MessageService {
  final Client _client;
  final PgpKeyService _pgpKeyService;

  // Cache für Benutzernamen
  final Map<int, String> _usernameCache = {};

  MessageService(this._client, this._pgpKeyService);

  // === Posteingang ===

  /// Ruft den Posteingang ab.
  Future<List<Message>> getInbox({
    int limit = 25,
    int offset = 0,
  }) async {
    return await _client.message.getInbox(
      limit: limit,
      offset: offset,
      includeDeleted: false,
    );
  }

  /// Ruft gesendete Nachrichten ab.
  Future<List<Message>> getSent({
    int limit = 25,
    int offset = 0,
  }) async {
    return await _client.message.getSent(
      limit: limit,
      offset: offset,
      includeDeleted: false,
    );
  }

  /// Zählt ungelesene Nachrichten.
  Future<int> getUnreadCount() async {
    return await _client.message.getUnreadCount();
  }

  /// Markiert eine Nachricht als gelesen.
  Future<bool> markAsRead(int messageId) async {
    return await _client.message.markAsRead(messageId);
  }

  /// Löscht eine Nachricht (Soft-Delete).
  Future<bool> deleteMessage(int messageId) async {
    return await _client.message.delete(messageId);
  }

  /// Ruft eine einzelne Nachricht ab.
  Future<Message?> getMessageById(int messageId) async {
    return await _client.message.getById(messageId);
  }

  // === Entwürfe ===

  /// Ruft alle Entwürfe ab.
  Future<List<MessageDraft>> getDrafts({
    int limit = 25,
    int offset = 0,
  }) async {
    return await _client.draft.getAll(
      limit: limit,
      offset: offset,
    );
  }

  /// Zählt Entwürfe.
  Future<int> getDraftCount() async {
    return await _client.draft.getCount();
  }

  /// Speichert einen Entwurf (verschlüsselt mit eigenem Public Key).
  Future<MessageDraft?> saveDraft({
    int? recipientId,
    String? recipientUsername,
    String? subject,
    String? content,
    int? listingId,
    int? existingDraftId,
  }) async {
    // Verschlüssele mit eigenem Public Key für sichere Speicherung
    String? encryptedSubject;
    String? encryptedContent;

    final myPublicKey = await _pgpKeyService.getMyPublicKey();
    if (myPublicKey != null && (subject != null || content != null)) {
      if (subject != null && subject.isNotEmpty) {
        encryptedSubject = await _pgpKeyService.encryptForRecipient(
          subject,
          myPublicKey.publicKeyArmored,
        );
      }
      if (content != null && content.isNotEmpty) {
        encryptedContent = await _pgpKeyService.encryptForRecipient(
          content,
          myPublicKey.publicKeyArmored,
        );
      }
    }

    if (existingDraftId != null) {
      return await _client.draft.update(
        existingDraftId,
        recipientId: recipientId,
        recipientUsername: recipientUsername,
        encryptedSubject: encryptedSubject,
        encryptedContent: encryptedContent,
        listingId: listingId,
      );
    } else {
      return await _client.draft.save(
        recipientId: recipientId,
        recipientUsername: recipientUsername,
        encryptedSubject: encryptedSubject,
        encryptedContent: encryptedContent,
        listingId: listingId,
      );
    }
  }

  /// Löscht einen Entwurf.
  Future<bool> deleteDraft(int draftId) async {
    return await _client.draft.delete(draftId);
  }

  /// Ruft einen Entwurf ab und entschlüsselt ihn.
  Future<DecryptedDraft?> getDraftById(int draftId) async {
    final draft = await _client.draft.getById(draftId);
    if (draft == null) return null;

    return await _decryptDraft(draft);
  }

  // === Nachrichten senden ===

  /// Sendet eine verschlüsselte Nachricht.
  Future<Message?> sendMessage({
    required int recipientId,
    required String subject,
    required String content,
    int? listingId,
    int? parentMessageId,
  }) async {
    // Hole Public Key des Empfängers
    final recipientKey = await _client.pgpKey.getPublicKey(recipientId);
    if (recipientKey == null) {
      throw Exception('Empfänger hat keinen PGP-Schlüssel');
    }

    // Verschlüssele Betreff und Inhalt
    final encryptedSubject = await _pgpKeyService.encryptForRecipient(
      subject,
      recipientKey.publicKeyArmored,
    );
    final encryptedContent = await _pgpKeyService.encryptForRecipient(
      content,
      recipientKey.publicKeyArmored,
    );

    return await _client.message.send(
      recipientId: recipientId,
      encryptedSubject: encryptedSubject,
      encryptedContent: encryptedContent,
      listingId: listingId,
      parentMessageId: parentMessageId,
    );
  }

  // === Entschlüsselung ===

  /// Entschlüsselt eine empfangene Nachricht.
  Future<DecryptedMessage> decryptMessage(Message message) async {
    String? decryptedSubject;
    String? decryptedContent;

    try {
      decryptedSubject = await _pgpKeyService.decryptMessage(
        message.encryptedSubject,
      );
    } catch (e) {
      decryptedSubject = '[Entschlüsselung fehlgeschlagen]';
    }

    try {
      decryptedContent = await _pgpKeyService.decryptMessage(
        message.encryptedContent,
      );
    } catch (e) {
      decryptedContent = '[Entschlüsselung fehlgeschlagen]';
    }

    return DecryptedMessage(
      message: message,
      subject: decryptedSubject,
      content: decryptedContent,
    );
  }

  /// Entschlüsselt einen Entwurf.
  Future<DecryptedDraft> _decryptDraft(MessageDraft draft) async {
    String? decryptedSubject;
    String? decryptedContent;

    if (draft.encryptedSubject != null) {
      try {
        decryptedSubject = await _pgpKeyService.decryptMessage(
          draft.encryptedSubject!,
        );
      } catch (e) {
        decryptedSubject = '[Entschlüsselung fehlgeschlagen]';
      }
    }

    if (draft.encryptedContent != null) {
      try {
        decryptedContent = await _pgpKeyService.decryptMessage(
          draft.encryptedContent!,
        );
      } catch (e) {
        decryptedContent = '[Entschlüsselung fehlgeschlagen]';
      }
    }

    return DecryptedDraft(
      draft: draft,
      subject: decryptedSubject,
      content: decryptedContent,
    );
  }

  // === Hilfsmethoden ===

  /// Holt den Benutzernamen für eine User-ID (mit Cache).
  Future<String?> getUsername(int userId) async {
    if (_usernameCache.containsKey(userId)) {
      return _usernameCache[userId];
    }

    // Versuche über eine Nachricht den Namen zu bekommen
    // oder lade direkt vom Server
    try {
      final messages = await _client.message.getInbox(
        limit: 100,
        offset: 0,
        includeDeleted: false,
      );
      for (final msg in messages) {
        if (msg.senderId == userId) {
          final username = await _client.message.getSenderUsername(msg.id!);
          if (username != null) {
            _usernameCache[userId] = username;
            return username;
          }
        }
      }
    } catch (e) {
      // Ignore
    }

    return null;
  }

  /// Prüft ob der Empfänger einen PGP-Key hat.
  Future<bool> recipientHasKey(int userId) async {
    final key = await _client.pgpKey.getPublicKey(userId);
    return key != null;
  }

  /// Sucht einen Benutzer nach Username.
  Future<UserPublicKey?> findUserByUsername(String username) async {
    return await _client.pgpKey.getPublicKeyByUsername(username);
  }
}

/// Entschlüsselte Nachricht.
class DecryptedMessage {
  final Message message;
  final String subject;
  final String content;

  DecryptedMessage({
    required this.message,
    required this.subject,
    required this.content,
  });
}

/// Entschlüsselter Entwurf.
class DecryptedDraft {
  final MessageDraft draft;
  final String? subject;
  final String? content;

  DecryptedDraft({
    required this.draft,
    this.subject,
    this.content,
  });
}
