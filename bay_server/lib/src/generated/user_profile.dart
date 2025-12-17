/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;

/// Public user profile data (no table, used for API responses)
abstract class UserProfile
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  UserProfile._({
    required this.userId,
    required this.username,
    required this.memberSince,
    required this.activeListingsCount,
    this.ratingAverage,
    required this.ratingCount,
    required this.hasContact,
    this.paypalAddress,
    this.bitcoinWallet,
    required this.hasPgpKey,
  });

  factory UserProfile({
    required int userId,
    required String username,
    required DateTime memberSince,
    required int activeListingsCount,
    int? ratingAverage,
    required int ratingCount,
    required bool hasContact,
    String? paypalAddress,
    String? bitcoinWallet,
    required bool hasPgpKey,
  }) = _UserProfileImpl;

  factory UserProfile.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserProfile(
      userId: jsonSerialization['userId'] as int,
      username: jsonSerialization['username'] as String,
      memberSince:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['memberSince']),
      activeListingsCount: jsonSerialization['activeListingsCount'] as int,
      ratingAverage: jsonSerialization['ratingAverage'] as int?,
      ratingCount: jsonSerialization['ratingCount'] as int,
      hasContact: jsonSerialization['hasContact'] as bool,
      paypalAddress: jsonSerialization['paypalAddress'] as String?,
      bitcoinWallet: jsonSerialization['bitcoinWallet'] as String?,
      hasPgpKey: jsonSerialization['hasPgpKey'] as bool,
    );
  }

  /// User ID
  int userId;

  /// Username
  String username;

  /// Account creation date
  DateTime memberSince;

  /// Number of active listings
  int activeListingsCount;

  /// Rating average (0-100, null if no ratings yet)
  int? ratingAverage;

  /// Total number of ratings received
  int ratingCount;

  /// Whether the viewing user has exchanged messages with this user
  bool hasContact;

  /// PayPal address (only visible if hasContact is true)
  String? paypalAddress;

  /// Bitcoin wallet (only visible if hasContact is true)
  String? bitcoinWallet;

  /// Whether user has an active PGP key (for messaging)
  bool hasPgpKey;

  /// Returns a shallow copy of this [UserProfile]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UserProfile copyWith({
    int? userId,
    String? username,
    DateTime? memberSince,
    int? activeListingsCount,
    int? ratingAverage,
    int? ratingCount,
    bool? hasContact,
    String? paypalAddress,
    String? bitcoinWallet,
    bool? hasPgpKey,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'username': username,
      'memberSince': memberSince.toJson(),
      'activeListingsCount': activeListingsCount,
      if (ratingAverage != null) 'ratingAverage': ratingAverage,
      'ratingCount': ratingCount,
      'hasContact': hasContact,
      if (paypalAddress != null) 'paypalAddress': paypalAddress,
      if (bitcoinWallet != null) 'bitcoinWallet': bitcoinWallet,
      'hasPgpKey': hasPgpKey,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      'userId': userId,
      'username': username,
      'memberSince': memberSince.toJson(),
      'activeListingsCount': activeListingsCount,
      if (ratingAverage != null) 'ratingAverage': ratingAverage,
      'ratingCount': ratingCount,
      'hasContact': hasContact,
      if (paypalAddress != null) 'paypalAddress': paypalAddress,
      if (bitcoinWallet != null) 'bitcoinWallet': bitcoinWallet,
      'hasPgpKey': hasPgpKey,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserProfileImpl extends UserProfile {
  _UserProfileImpl({
    required int userId,
    required String username,
    required DateTime memberSince,
    required int activeListingsCount,
    int? ratingAverage,
    required int ratingCount,
    required bool hasContact,
    String? paypalAddress,
    String? bitcoinWallet,
    required bool hasPgpKey,
  }) : super._(
          userId: userId,
          username: username,
          memberSince: memberSince,
          activeListingsCount: activeListingsCount,
          ratingAverage: ratingAverage,
          ratingCount: ratingCount,
          hasContact: hasContact,
          paypalAddress: paypalAddress,
          bitcoinWallet: bitcoinWallet,
          hasPgpKey: hasPgpKey,
        );

  /// Returns a shallow copy of this [UserProfile]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UserProfile copyWith({
    int? userId,
    String? username,
    DateTime? memberSince,
    int? activeListingsCount,
    Object? ratingAverage = _Undefined,
    int? ratingCount,
    bool? hasContact,
    Object? paypalAddress = _Undefined,
    Object? bitcoinWallet = _Undefined,
    bool? hasPgpKey,
  }) {
    return UserProfile(
      userId: userId ?? this.userId,
      username: username ?? this.username,
      memberSince: memberSince ?? this.memberSince,
      activeListingsCount: activeListingsCount ?? this.activeListingsCount,
      ratingAverage: ratingAverage is int? ? ratingAverage : this.ratingAverage,
      ratingCount: ratingCount ?? this.ratingCount,
      hasContact: hasContact ?? this.hasContact,
      paypalAddress:
          paypalAddress is String? ? paypalAddress : this.paypalAddress,
      bitcoinWallet:
          bitcoinWallet is String? ? bitcoinWallet : this.bitcoinWallet,
      hasPgpKey: hasPgpKey ?? this.hasPgpKey,
    );
  }
}
