/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

/// User payment information for profile display
abstract class UserPaymentInfo implements _i1.SerializableModel {
  UserPaymentInfo._({
    this.id,
    required this.userId,
    this.paypalAddress,
    this.bitcoinWallet,
    required this.updatedAt,
  });

  factory UserPaymentInfo({
    int? id,
    required int userId,
    String? paypalAddress,
    String? bitcoinWallet,
    required DateTime updatedAt,
  }) = _UserPaymentInfoImpl;

  factory UserPaymentInfo.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserPaymentInfo(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      paypalAddress: jsonSerialization['paypalAddress'] as String?,
      bitcoinWallet: jsonSerialization['bitcoinWallet'] as String?,
      updatedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  /// Reference to user
  int userId;

  /// PayPal email address (optional)
  String? paypalAddress;

  /// Bitcoin wallet address (optional)
  String? bitcoinWallet;

  /// Last modification timestamp
  DateTime updatedAt;

  /// Returns a shallow copy of this [UserPaymentInfo]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UserPaymentInfo copyWith({
    int? id,
    int? userId,
    String? paypalAddress,
    String? bitcoinWallet,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      if (paypalAddress != null) 'paypalAddress': paypalAddress,
      if (bitcoinWallet != null) 'bitcoinWallet': bitcoinWallet,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserPaymentInfoImpl extends UserPaymentInfo {
  _UserPaymentInfoImpl({
    int? id,
    required int userId,
    String? paypalAddress,
    String? bitcoinWallet,
    required DateTime updatedAt,
  }) : super._(
          id: id,
          userId: userId,
          paypalAddress: paypalAddress,
          bitcoinWallet: bitcoinWallet,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [UserPaymentInfo]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UserPaymentInfo copyWith({
    Object? id = _Undefined,
    int? userId,
    Object? paypalAddress = _Undefined,
    Object? bitcoinWallet = _Undefined,
    DateTime? updatedAt,
  }) {
    return UserPaymentInfo(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      paypalAddress:
          paypalAddress is String? ? paypalAddress : this.paypalAddress,
      bitcoinWallet:
          bitcoinWallet is String? ? bitcoinWallet : this.bitcoinWallet,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
