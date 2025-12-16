import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Endpoint für verschlüsselte Nachrichten.
class MessageEndpoint extends Endpoint {
  /// Prüft ob der Benutzer eingeloggt ist und gibt die User-ID zurück.
  Future<int?> _getAuthenticatedUserId(Session session) async {
    final authInfo = await session.authenticated;
    return authInfo?.userId;
  }

  /// Sendet eine verschlüsselte Nachricht.
  /// Die Nachricht muss bereits client-seitig verschlüsselt sein.
  Future<Message?> send(
    Session session, {
    required int recipientId,
    required String encryptedSubject,
    required String encryptedContent,
    int? listingId,
    int? parentMessageId,
  }) async {
    final senderId = await _getAuthenticatedUserId(session);
    if (senderId == null) {
      throw Exception('Nicht authentifiziert');
    }

    // Prüfe ob Empfänger existiert
    final recipient = await User.db.findById(session, recipientId);
    if (recipient == null || !recipient.isActive) {
      throw Exception('Empfänger nicht gefunden');
    }

    // Prüfe ob Empfänger einen Public Key hat
    final recipientKey = await UserPublicKey.db.findFirstRow(
      session,
      where: (t) => t.userId.equals(recipientId) & t.isActive.equals(true),
    );
    if (recipientKey == null) {
      throw Exception('Empfänger hat keinen PGP-Schlüssel');
    }

    // Optional: Prüfe ob Listing existiert
    if (listingId != null) {
      final listing = await Listing.db.findById(session, listingId);
      if (listing == null) {
        throw Exception('Angebot nicht gefunden');
      }
    }

    // Optional: Prüfe ob Parent-Nachricht existiert und zum Thread gehört
    if (parentMessageId != null) {
      final parentMessage = await Message.db.findById(session, parentMessageId);
      if (parentMessage == null) {
        throw Exception('Ursprüngliche Nachricht nicht gefunden');
      }
    }

    // Erstelle Nachricht
    final message = Message(
      senderId: senderId,
      recipientId: recipientId,
      encryptedSubject: encryptedSubject,
      encryptedContent: encryptedContent,
      isRead: false,
      deletedBySender: false,
      deletedByRecipient: false,
      createdAt: DateTime.now(),
      listingId: listingId,
      parentMessageId: parentMessageId,
    );

    return await Message.db.insertRow(session, message);
  }

  /// Ruft den Posteingang des Benutzers ab (empfangene Nachrichten).
  Future<List<Message>> getInbox(
    Session session, {
    int limit = 25,
    int offset = 0,
    bool includeDeleted = false,
  }) async {
    final userId = await _getAuthenticatedUserId(session);
    if (userId == null) {
      throw Exception('Nicht authentifiziert');
    }

    if (includeDeleted) {
      return await Message.db.find(
        session,
        where: (t) => t.recipientId.equals(userId),
        orderBy: (t) => t.createdAt,
        orderDescending: true,
        limit: limit,
        offset: offset,
      );
    }

    return await Message.db.find(
      session,
      where: (t) =>
          t.recipientId.equals(userId) & t.deletedByRecipient.equals(false),
      orderBy: (t) => t.createdAt,
      orderDescending: true,
      limit: limit,
      offset: offset,
    );
  }

  /// Ruft gesendete Nachrichten des Benutzers ab.
  Future<List<Message>> getSent(
    Session session, {
    int limit = 25,
    int offset = 0,
    bool includeDeleted = false,
  }) async {
    final userId = await _getAuthenticatedUserId(session);
    if (userId == null) {
      throw Exception('Nicht authentifiziert');
    }

    if (includeDeleted) {
      return await Message.db.find(
        session,
        where: (t) => t.senderId.equals(userId),
        orderBy: (t) => t.createdAt,
        orderDescending: true,
        limit: limit,
        offset: offset,
      );
    }

    return await Message.db.find(
      session,
      where: (t) =>
          t.senderId.equals(userId) & t.deletedBySender.equals(false),
      orderBy: (t) => t.createdAt,
      orderDescending: true,
      limit: limit,
      offset: offset,
    );
  }

  /// Ruft eine einzelne Nachricht ab.
  Future<Message?> getById(Session session, int messageId) async {
    final userId = await _getAuthenticatedUserId(session);
    if (userId == null) {
      throw Exception('Nicht authentifiziert');
    }

    final message = await Message.db.findById(session, messageId);
    if (message == null) {
      return null;
    }

    // Nur Sender oder Empfänger dürfen die Nachricht sehen
    if (message.senderId != userId && message.recipientId != userId) {
      throw Exception('Keine Berechtigung');
    }

    // Prüfe ob für den Benutzer gelöscht
    if (message.senderId == userId && message.deletedBySender) {
      return null;
    }
    if (message.recipientId == userId && message.deletedByRecipient) {
      return null;
    }

    return message;
  }

  /// Markiert eine Nachricht als gelesen.
  Future<bool> markAsRead(Session session, int messageId) async {
    final userId = await _getAuthenticatedUserId(session);
    if (userId == null) {
      throw Exception('Nicht authentifiziert');
    }

    final message = await Message.db.findById(session, messageId);
    if (message == null) {
      return false;
    }

    // Nur Empfänger kann als gelesen markieren
    if (message.recipientId != userId) {
      throw Exception('Keine Berechtigung');
    }

    if (message.isRead) {
      return true; // Bereits gelesen
    }

    message.isRead = true;
    await Message.db.updateRow(session, message);
    return true;
  }

  /// Markiert mehrere Nachrichten als gelesen.
  Future<int> markMultipleAsRead(Session session, List<int> messageIds) async {
    final userId = await _getAuthenticatedUserId(session);
    if (userId == null) {
      throw Exception('Nicht authentifiziert');
    }

    int count = 0;
    for (final messageId in messageIds) {
      final message = await Message.db.findById(session, messageId);
      if (message != null &&
          message.recipientId == userId &&
          !message.isRead) {
        message.isRead = true;
        await Message.db.updateRow(session, message);
        count++;
      }
    }
    return count;
  }

  /// Löscht eine Nachricht (Soft-Delete).
  /// Die Nachricht wird nur für den jeweiligen Benutzer als gelöscht markiert.
  Future<bool> delete(Session session, int messageId) async {
    final userId = await _getAuthenticatedUserId(session);
    if (userId == null) {
      throw Exception('Nicht authentifiziert');
    }

    final message = await Message.db.findById(session, messageId);
    if (message == null) {
      return false;
    }

    // Prüfe ob Benutzer Sender oder Empfänger ist
    if (message.senderId != userId && message.recipientId != userId) {
      throw Exception('Keine Berechtigung');
    }

    // Markiere als gelöscht für den jeweiligen Benutzer
    if (message.senderId == userId) {
      message.deletedBySender = true;
    }
    if (message.recipientId == userId) {
      message.deletedByRecipient = true;
    }

    await Message.db.updateRow(session, message);

    // Wenn beide gelöscht haben, endgültig löschen
    if (message.deletedBySender && message.deletedByRecipient) {
      await Message.db.deleteRow(session, message);
    }

    return true;
  }

  /// Zählt ungelesene Nachrichten im Posteingang.
  Future<int> getUnreadCount(Session session) async {
    final userId = await _getAuthenticatedUserId(session);
    if (userId == null) {
      throw Exception('Nicht authentifiziert');
    }

    final unread = await Message.db.find(
      session,
      where: (t) =>
          t.recipientId.equals(userId) &
          t.isRead.equals(false) &
          t.deletedByRecipient.equals(false),
    );

    return unread.length;
  }

  /// Ruft die Konversation zwischen zwei Benutzern ab.
  Future<List<Message>> getConversation(
    Session session,
    int otherUserId, {
    int limit = 50,
    int offset = 0,
  }) async {
    final userId = await _getAuthenticatedUserId(session);
    if (userId == null) {
      throw Exception('Nicht authentifiziert');
    }

    // Nachrichten in beide Richtungen
    return await Message.db.find(
      session,
      where: (t) =>
          ((t.senderId.equals(userId) & t.recipientId.equals(otherUserId)) |
              (t.senderId.equals(otherUserId) & t.recipientId.equals(userId))) &
          // Nur nicht gelöschte Nachrichten für den Benutzer
          ((t.senderId.equals(userId) & t.deletedBySender.equals(false)) |
              (t.recipientId.equals(userId) &
                  t.deletedByRecipient.equals(false))),
      orderBy: (t) => t.createdAt,
      orderDescending: true,
      limit: limit,
      offset: offset,
    );
  }

  /// Ruft den Thread einer Nachricht ab (Antworten).
  Future<List<Message>> getThread(
    Session session,
    int messageId, {
    int limit = 50,
  }) async {
    final userId = await _getAuthenticatedUserId(session);
    if (userId == null) {
      throw Exception('Nicht authentifiziert');
    }

    // Prüfe ob Zugriff auf die ursprüngliche Nachricht
    final rootMessage = await Message.db.findById(session, messageId);
    if (rootMessage == null) {
      throw Exception('Nachricht nicht gefunden');
    }
    if (rootMessage.senderId != userId && rootMessage.recipientId != userId) {
      throw Exception('Keine Berechtigung');
    }

    // Finde alle Antworten
    return await Message.db.find(
      session,
      where: (t) => t.parentMessageId.equals(messageId),
      orderBy: (t) => t.createdAt,
      orderDescending: false,
      limit: limit,
    );
  }

  /// Ruft eine Liste der Konversationspartner mit der letzten Nachricht ab.
  Future<List<Map<String, dynamic>>> getConversationList(
    Session session, {
    int limit = 25,
  }) async {
    final userId = await _getAuthenticatedUserId(session);
    if (userId == null) {
      throw Exception('Nicht authentifiziert');
    }

    // Alle Nachrichten des Benutzers (gesendet und empfangen)
    final messages = await Message.db.find(
      session,
      where: (t) =>
          (t.senderId.equals(userId) & t.deletedBySender.equals(false)) |
          (t.recipientId.equals(userId) & t.deletedByRecipient.equals(false)),
      orderBy: (t) => t.createdAt,
      orderDescending: true,
    );

    // Gruppiere nach Konversationspartner
    final conversations = <int, Message>{};
    for (final msg in messages) {
      final partnerId = msg.senderId == userId ? msg.recipientId : msg.senderId;
      if (!conversations.containsKey(partnerId)) {
        conversations[partnerId] = msg;
      }
    }

    // Lade Benutzerinformationen
    final result = <Map<String, dynamic>>[];
    var count = 0;
    for (final entry in conversations.entries) {
      if (count >= limit) break;

      final partner = await User.db.findById(session, entry.key);
      if (partner != null) {
        // Zähle ungelesene Nachrichten von diesem Partner
        final unreadCount = messages
            .where((m) =>
                m.senderId == entry.key &&
                m.recipientId == userId &&
                !m.isRead)
            .length;

        result.add({
          'partnerId': entry.key,
          'partnerUsername': partner.username,
          'lastMessage': entry.value,
          'unreadCount': unreadCount,
        });
        count++;
      }
    }

    return result;
  }

  /// Holt den Benutzernamen für eine Nachricht (für Anzeige).
  Future<String?> getSenderUsername(Session session, int messageId) async {
    final userId = await _getAuthenticatedUserId(session);
    if (userId == null) {
      throw Exception('Nicht authentifiziert');
    }

    final message = await Message.db.findById(session, messageId);
    if (message == null) {
      return null;
    }

    // Nur Sender oder Empfänger dürfen den Sender sehen
    if (message.senderId != userId && message.recipientId != userId) {
      throw Exception('Keine Berechtigung');
    }

    final sender = await User.db.findById(session, message.senderId);
    return sender?.username;
  }
}
