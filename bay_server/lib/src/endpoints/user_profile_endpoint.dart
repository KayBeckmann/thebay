import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Endpoint für öffentliche Benutzerprofile und Zahlungsinformationen.
class UserProfileEndpoint extends Endpoint {
  /// Prüft ob der Benutzer eingeloggt ist und gibt die User-ID zurück.
  Future<int?> _getAuthenticatedUserId(Session session) async {
    final authInfo = await session.authenticated;
    return authInfo?.userId;
  }

  /// Prüft ob zwischen zwei Benutzern bereits Nachrichten ausgetauscht wurden.
  Future<bool> _hasContactBetweenUsers(
    Session session,
    int userId1,
    int userId2,
  ) async {
    // Prüfe ob jemals eine Nachricht zwischen den Benutzern ausgetauscht wurde
    final message = await Message.db.findFirstRow(
      session,
      where: (t) =>
          (t.senderId.equals(userId1) & t.recipientId.equals(userId2)) |
          (t.senderId.equals(userId2) & t.recipientId.equals(userId1)),
    );
    return message != null;
  }

  /// Ruft das öffentliche Profil eines Benutzers ab.
  Future<UserProfile?> getProfile(Session session, int userId) async {
    final viewerId = await _getAuthenticatedUserId(session);
    if (viewerId == null) {
      throw Exception('Nicht authentifiziert');
    }

    // Lade den Benutzer
    final user = await User.db.findById(session, userId);
    if (user == null || !user.isActive) {
      return null;
    }

    // Lade Angebote und filtere aktive
    final now = DateTime.now();
    final listings = await Listing.db.find(
      session,
      where: (t) => t.userId.equals(userId) & t.isActive.equals(true),
    );
    // Filtere abgelaufene Angebote
    final activeListings = listings.where((listing) {
      if (listing.expiresAt == null) return true;
      return listing.expiresAt!.isAfter(now);
    }).toList();

    // Prüfe ob Kontakt besteht (für Zahlungsinfo-Sichtbarkeit)
    final hasContact = viewerId == userId ||
        await _hasContactBetweenUsers(session, viewerId, userId);

    // Lade Zahlungsinformationen (nur wenn Kontakt besteht)
    String? paypalAddress;
    String? bitcoinWallet;
    if (hasContact) {
      final paymentInfo = await UserPaymentInfo.db.findFirstRow(
        session,
        where: (t) => t.userId.equals(userId),
      );
      if (paymentInfo != null) {
        paypalAddress = paymentInfo.paypalAddress;
        bitcoinWallet = paymentInfo.bitcoinWallet;
      }
    }

    // Prüfe ob Benutzer einen PGP-Schlüssel hat
    final pgpKey = await UserPublicKey.db.findFirstRow(
      session,
      where: (t) => t.userId.equals(userId) & t.isActive.equals(true),
    );

    // TODO: Bewertungen werden in Meilenstein 9 implementiert
    // Für jetzt: Platzhalter-Werte
    const ratingAverage = null;
    const ratingCount = 0;

    return UserProfile(
      userId: userId,
      username: user.username,
      memberSince: user.createdAt,
      activeListingsCount: activeListings.length,
      ratingAverage: ratingAverage,
      ratingCount: ratingCount,
      hasContact: hasContact,
      paypalAddress: paypalAddress,
      bitcoinWallet: bitcoinWallet,
      hasPgpKey: pgpKey != null,
    );
  }

  /// Ruft die aktiven Angebote eines Benutzers ab.
  Future<List<Listing>> getUserListings(
    Session session,
    int userId, {
    int limit = 25,
    int offset = 0,
  }) async {
    final viewerId = await _getAuthenticatedUserId(session);
    if (viewerId == null) {
      throw Exception('Nicht authentifiziert');
    }

    // Prüfe ob Benutzer existiert
    final user = await User.db.findById(session, userId);
    if (user == null || !user.isActive) {
      throw Exception('Benutzer nicht gefunden');
    }

    // Lade aktive Angebote
    final now = DateTime.now();
    final listings = await Listing.db.find(
      session,
      where: (t) => t.userId.equals(userId) & t.isActive.equals(true),
      orderBy: (t) => t.createdAt,
      orderDescending: true,
    );

    // Filtere abgelaufene Angebote und wende Pagination an
    final activeListings = listings.where((listing) {
      if (listing.expiresAt == null) return true;
      return listing.expiresAt!.isAfter(now);
    }).toList();

    // Pagination
    if (offset >= activeListings.length) {
      return [];
    }
    final end = (offset + limit) > activeListings.length
        ? activeListings.length
        : offset + limit;
    return activeListings.sublist(offset, end);
  }

  /// Ruft die eigenen Zahlungsinformationen ab.
  Future<UserPaymentInfo?> getMyPaymentInfo(Session session) async {
    final userId = await _getAuthenticatedUserId(session);
    if (userId == null) {
      throw Exception('Nicht authentifiziert');
    }

    return await UserPaymentInfo.db.findFirstRow(
      session,
      where: (t) => t.userId.equals(userId),
    );
  }

  /// Speichert die eigenen Zahlungsinformationen.
  Future<UserPaymentInfo> updateMyPaymentInfo(
    Session session, {
    String? paypalAddress,
    String? bitcoinWallet,
  }) async {
    final userId = await _getAuthenticatedUserId(session);
    if (userId == null) {
      throw Exception('Nicht authentifiziert');
    }

    // Lade vorhandene Zahlungsinformationen oder erstelle neue
    var paymentInfo = await UserPaymentInfo.db.findFirstRow(
      session,
      where: (t) => t.userId.equals(userId),
    );

    if (paymentInfo == null) {
      // Erstelle neue Zahlungsinformationen
      paymentInfo = UserPaymentInfo(
        userId: userId,
        paypalAddress: paypalAddress,
        bitcoinWallet: bitcoinWallet,
        updatedAt: DateTime.now(),
      );
      return await UserPaymentInfo.db.insertRow(session, paymentInfo);
    } else {
      // Aktualisiere vorhandene Zahlungsinformationen
      paymentInfo.paypalAddress = paypalAddress;
      paymentInfo.bitcoinWallet = bitcoinWallet;
      paymentInfo.updatedAt = DateTime.now();
      return await UserPaymentInfo.db.updateRow(session, paymentInfo);
    }
  }

  /// Holt den Benutzernamen für eine User-ID.
  Future<String?> getUsername(Session session, int userId) async {
    final viewerId = await _getAuthenticatedUserId(session);
    if (viewerId == null) {
      throw Exception('Nicht authentifiziert');
    }

    final user = await User.db.findById(session, userId);
    return user?.username;
  }

  /// Prüft ob zwischen dem eingeloggten Benutzer und einem anderen Kontakt besteht.
  Future<bool> hasContact(Session session, int otherUserId) async {
    final userId = await _getAuthenticatedUserId(session);
    if (userId == null) {
      throw Exception('Nicht authentifiziert');
    }

    if (userId == otherUserId) {
      return true; // Eigenes Profil
    }

    return await _hasContactBetweenUsers(session, userId, otherUserId);
  }
}
