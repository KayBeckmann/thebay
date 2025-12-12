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

/// Mengeneinheit für Angebote
enum QuantityUnit implements _i1.SerializableModel {
  piece,
  kg,
  gram,
  meter,
  liter,
  none;

  static QuantityUnit fromJson(int index) {
    switch (index) {
      case 0:
        return QuantityUnit.piece;
      case 1:
        return QuantityUnit.kg;
      case 2:
        return QuantityUnit.gram;
      case 3:
        return QuantityUnit.meter;
      case 4:
        return QuantityUnit.liter;
      case 5:
        return QuantityUnit.none;
      default:
        throw ArgumentError(
            'Value "$index" cannot be converted to "QuantityUnit"');
    }
  }

  @override
  int toJson() => index;

  @override
  String toString() => name;
}
