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

/// Status einer Transaktion im Handelsablauf
enum TransactionStatus implements _i1.SerializableModel {
  open,
  shipped,
  received,
  completed,
  disputed,
  cancelled;

  static TransactionStatus fromJson(int index) {
    switch (index) {
      case 0:
        return TransactionStatus.open;
      case 1:
        return TransactionStatus.shipped;
      case 2:
        return TransactionStatus.received;
      case 3:
        return TransactionStatus.completed;
      case 4:
        return TransactionStatus.disputed;
      case 5:
        return TransactionStatus.cancelled;
      default:
        throw ArgumentError(
            'Value "$index" cannot be converted to "TransactionStatus"');
    }
  }

  @override
  int toJson() => index;

  @override
  String toString() => name;
}
