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

/// Global application settings
abstract class Settings implements _i1.SerializableModel {
  Settings._({
    this.id,
    required this.key,
    required this.value,
    this.description,
    required this.updatedAt,
  });

  factory Settings({
    int? id,
    required String key,
    required String value,
    String? description,
    required DateTime updatedAt,
  }) = _SettingsImpl;

  factory Settings.fromJson(Map<String, dynamic> jsonSerialization) {
    return Settings(
      id: jsonSerialization['id'] as int?,
      key: jsonSerialization['key'] as String,
      value: jsonSerialization['value'] as String,
      description: jsonSerialization['description'] as String?,
      updatedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  /// Setting key (unique identifier)
  String key;

  /// Setting value (stored as JSON string for flexibility)
  String value;

  /// Human-readable description
  String? description;

  /// Last modification timestamp
  DateTime updatedAt;

  /// Returns a shallow copy of this [Settings]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Settings copyWith({
    int? id,
    String? key,
    String? value,
    String? description,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'key': key,
      'value': value,
      if (description != null) 'description': description,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SettingsImpl extends Settings {
  _SettingsImpl({
    int? id,
    required String key,
    required String value,
    String? description,
    required DateTime updatedAt,
  }) : super._(
          id: id,
          key: key,
          value: value,
          description: description,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [Settings]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Settings copyWith({
    Object? id = _Undefined,
    String? key,
    String? value,
    Object? description = _Undefined,
    DateTime? updatedAt,
  }) {
    return Settings(
      id: id is int? ? id : this.id,
      key: key ?? this.key,
      value: value ?? this.value,
      description: description is String? ? description : this.description,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
