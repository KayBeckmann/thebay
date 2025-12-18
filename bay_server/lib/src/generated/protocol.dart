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
import 'package:serverpod/protocol.dart' as _i2;
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as _i3;
import 'message_draft.dart' as _i4;
import 'auth_response.dart' as _i5;
import 'category.dart' as _i6;
import 'currency_rate.dart' as _i7;
import 'dispute.dart' as _i8;
import 'dispute_status.dart' as _i9;
import 'encrypted_key_backup.dart' as _i10;
import 'favorite.dart' as _i11;
import 'listing.dart' as _i12;
import 'listing_image.dart' as _i13;
import 'login_request.dart' as _i14;
import 'message.dart' as _i15;
import 'greeting.dart' as _i16;
import 'news.dart' as _i17;
import 'order_status.dart' as _i18;
import 'payment_method.dart' as _i19;
import 'quantity_unit.dart' as _i20;
import 'rating.dart' as _i21;
import 'rating_stats.dart' as _i22;
import 'rating_value.dart' as _i23;
import 'registration_request.dart' as _i24;
import 'report.dart' as _i25;
import 'report_reason.dart' as _i26;
import 'report_status.dart' as _i27;
import 'user_slot.dart' as _i28;
import 'search_result.dart' as _i29;
import 'settings.dart' as _i30;
import 'slot_order.dart' as _i31;
import 'slot_variant.dart' as _i32;
import 'transaction.dart' as _i33;
import 'transaction_status.dart' as _i34;
import 'user.dart' as _i35;
import 'user_payment_info.dart' as _i36;
import 'user_profile.dart' as _i37;
import 'user_public_key.dart' as _i38;
import 'user_role.dart' as _i39;
import 'report_target_type.dart' as _i40;
import 'package:bay_server/src/generated/category.dart' as _i41;
import 'package:bay_server/src/generated/dispute.dart' as _i42;
import 'package:bay_server/src/generated/message_draft.dart' as _i43;
import 'package:bay_server/src/generated/listing.dart' as _i44;
import 'package:bay_server/src/generated/listing_image.dart' as _i45;
import 'package:bay_server/src/generated/message.dart' as _i46;
import 'package:bay_server/src/generated/news.dart' as _i47;
import 'package:bay_server/src/generated/encrypted_key_backup.dart' as _i48;
import 'package:bay_server/src/generated/rating.dart' as _i49;
import 'package:bay_server/src/generated/transaction.dart' as _i50;
import 'package:bay_server/src/generated/report.dart' as _i51;
import 'package:bay_server/src/generated/slot_order.dart' as _i52;
import 'package:bay_server/src/generated/slot_variant.dart' as _i53;
import 'package:bay_server/src/generated/user_slot.dart' as _i54;
export 'greeting.dart';
export 'auth_response.dart';
export 'category.dart';
export 'currency_rate.dart';
export 'dispute.dart';
export 'dispute_status.dart';
export 'encrypted_key_backup.dart';
export 'favorite.dart';
export 'listing.dart';
export 'listing_image.dart';
export 'login_request.dart';
export 'message.dart';
export 'message_draft.dart';
export 'news.dart';
export 'order_status.dart';
export 'payment_method.dart';
export 'quantity_unit.dart';
export 'rating.dart';
export 'rating_stats.dart';
export 'rating_value.dart';
export 'registration_request.dart';
export 'report.dart';
export 'report_reason.dart';
export 'report_status.dart';
export 'report_target_type.dart';
export 'search_result.dart';
export 'settings.dart';
export 'slot_order.dart';
export 'slot_variant.dart';
export 'transaction.dart';
export 'transaction_status.dart';
export 'user.dart';
export 'user_payment_info.dart';
export 'user_profile.dart';
export 'user_public_key.dart';
export 'user_role.dart';
export 'user_slot.dart';

class Protocol extends _i1.SerializationManagerServer {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  static final List<_i2.TableDefinition> targetTableDefinitions = [
    _i2.TableDefinition(
      name: 'categories',
      dartName: 'Category',
      schema: 'public',
      module: 'bay',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'categories_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'parentId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'sortOrder',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'isActive',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'categories_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'categories_parent_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'parentId',
            )
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'categories_name_parent_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'name',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'parentId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'currency_rates',
      dartName: 'CurrencyRate',
      schema: 'public',
      module: 'bay',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'currency_rates_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'baseCurrency',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'targetCurrency',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'rate',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'currency_rates_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'currency_pair_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'baseCurrency',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'targetCurrency',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'disputes',
      dartName: 'Dispute',
      schema: 'public',
      module: 'bay',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'disputes_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'transactionId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'openedByUserId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'reason',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'protocol:DisputeStatus',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'resolution',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'moderatorId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'resolvedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'disputes_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'dispute_transaction_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'transactionId',
            )
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'dispute_opened_by_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'openedByUserId',
            )
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'dispute_status_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'status',
            )
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'dispute_moderator_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'moderatorId',
            )
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'encrypted_key_backups',
      dartName: 'EncryptedKeyBackup',
      schema: 'public',
      module: 'bay',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'encrypted_key_backups_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'encryptedPrivateKey',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'fingerprint',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'encryptionSalt',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'kdfParams',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'isActive',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'encrypted_key_backups_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'backup_user_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            )
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'backup_fingerprint_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'fingerprint',
            )
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'backup_user_active_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'isActive',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'favorites',
      dartName: 'Favorite',
      schema: 'public',
      module: 'bay',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'favorites_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'listingId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'favorites_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'favorite_user_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            )
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'favorite_listing_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'listingId',
            )
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'favorite_user_listing_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'listingId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'listing_images',
      dartName: 'ListingImage',
      schema: 'public',
      module: 'bay',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'listing_images_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'listingId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'fileName',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'originalName',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'mimeType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'sizeBytes',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'sortOrder',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'listing_images_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'listing_image_listing_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'listingId',
            )
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'listing_image_sort_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'listingId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'sortOrder',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'listings',
      dartName: 'Listing',
      schema: 'public',
      module: 'bay',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'listings_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'categoryId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'title',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'quantity',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'quantityUnit',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'protocol:QuantityUnit',
        ),
        _i2.ColumnDefinition(
          name: 'pricePerUnit',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'acceptsPaypal',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _i2.ColumnDefinition(
          name: 'acceptsBitcoin',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _i2.ColumnDefinition(
          name: 'hasShipping',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _i2.ColumnDefinition(
          name: 'shippingMethod',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'shippingCostCents',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'isActive',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _i2.ColumnDefinition(
          name: 'expiresAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'listings_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'listing_user_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            )
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'listing_category_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'categoryId',
            )
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'listing_active_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'isActive',
            )
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'listing_expires_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'expiresAt',
            )
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'message_drafts',
      dartName: 'MessageDraft',
      schema: 'public',
      module: 'bay',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'message_drafts_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'recipientId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'recipientUsername',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'encryptedSubject',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'encryptedContent',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'expiresAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'listingId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'message_drafts_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'draft_user_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            )
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'draft_expires_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'expiresAt',
            )
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'draft_listing_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'listingId',
            )
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'messages',
      dartName: 'Message',
      schema: 'public',
      module: 'bay',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'messages_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'senderId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'recipientId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'encryptedSubject',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'encryptedContent',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'isRead',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'deletedBySender',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'deletedByRecipient',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'listingId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'parentMessageId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'messages_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'message_sender_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'senderId',
            )
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'message_recipient_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'recipientId',
            )
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'message_recipient_read_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'recipientId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'isRead',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'message_created_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'createdAt',
            )
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'message_listing_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'listingId',
            )
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'news',
      dartName: 'News',
      schema: 'public',
      module: 'bay',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'news_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'title',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'content',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'authorId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'isPublished',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _i2.ColumnDefinition(
          name: 'publishedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'expiresAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'news_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'news_published_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'isPublished',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'publishedAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'news_expires_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'expiresAt',
            )
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'ratings',
      dartName: 'Rating',
      schema: 'public',
      module: 'bay',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'ratings_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'transactionId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'fromUserId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'toUserId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'rating',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'protocol:RatingValue',
        ),
        _i2.ColumnDefinition(
          name: 'comment',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'isAutomatic',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'ratings_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'rating_transaction_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'transactionId',
            )
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'rating_from_user_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'fromUserId',
            )
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'rating_to_user_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'toUserId',
            )
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'rating_transaction_from_unique',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'transactionId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'fromUserId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'reports',
      dartName: 'Report',
      schema: 'public',
      module: 'bay',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'reports_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'reporterId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'targetType',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'protocol:ReportTargetType',
        ),
        _i2.ColumnDefinition(
          name: 'targetId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'reason',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'protocol:ReportReason',
        ),
        _i2.ColumnDefinition(
          name: 'details',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'protocol:ReportStatus',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'assignedModeratorId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'moderatorNotes',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'resolvedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'reports_fk_0',
          columns: ['reporterId'],
          referenceTable: 'users',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'reports_fk_1',
          columns: ['assignedModeratorId'],
          referenceTable: 'users',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.setNull,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'reports_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'reports_reporter_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'reporterId',
            )
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'reports_target_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'targetType',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'targetId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'reports_status_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'status',
            )
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'reports_unique_target_per_user',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'reporterId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'targetType',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'targetId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'settings',
      dartName: 'Settings',
      schema: 'public',
      module: 'bay',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'settings_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'key',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'value',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'settings_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'settings_key_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'key',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'slot_orders',
      dartName: 'SlotOrder',
      schema: 'public',
      module: 'bay',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'slot_orders_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'slotVariantId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'paymentMethod',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'protocol:PaymentMethod',
        ),
        _i2.ColumnDefinition(
          name: 'amountCents',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'transactionId',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'protocol:OrderStatus',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'paidAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'completedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'slot_orders_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'slot_order_user_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            )
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'slot_order_status_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'status',
            )
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'slot_order_tx_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'transactionId',
            )
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'slot_variants',
      dartName: 'SlotVariant',
      schema: 'public',
      module: 'bay',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'slot_variants_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'priceUsdCents',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'durationDays',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'allowPaypal',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _i2.ColumnDefinition(
          name: 'allowBitcoin',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _i2.ColumnDefinition(
          name: 'isActive',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _i2.ColumnDefinition(
          name: 'sortOrder',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'slot_variants_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'slot_variants_active_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'isActive',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'sortOrder',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'slot_variants_name_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'name',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'transactions',
      dartName: 'Transaction',
      schema: 'public',
      module: 'bay',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'transactions_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'buyerId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'sellerId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'listingId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'protocol:TransactionStatus',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'quantity',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'totalPriceCents',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'paymentMethod',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'protocol:PaymentMethod',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'shippedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'receivedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'completedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'autoCompleteAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'buyerNote',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'transactions_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'transaction_buyer_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'buyerId',
            )
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'transaction_seller_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'sellerId',
            )
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'transaction_listing_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'listingId',
            )
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'transaction_status_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'status',
            )
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'transaction_auto_complete_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'autoCompleteAt',
            )
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'user_payment_info',
      dartName: 'UserPaymentInfo',
      schema: 'public',
      module: 'bay',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'user_payment_info_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'paypalAddress',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'bitcoinWallet',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'user_payment_info_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'user_payment_info_user_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'user_public_keys',
      dartName: 'UserPublicKey',
      schema: 'public',
      module: 'bay',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'user_public_keys_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'publicKeyArmored',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'fingerprint',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'algorithm',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'keySize',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'keyIdentity',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'isActive',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'user_public_keys_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'user_public_key_user_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            )
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'user_public_key_fingerprint_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'fingerprint',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'user_public_key_active_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'isActive',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'user_slots',
      dartName: 'UserSlot',
      schema: 'public',
      module: 'bay',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'user_slots_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'slotVariantId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'listingId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'purchasedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'expiresAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'isActive',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _i2.ColumnDefinition(
          name: 'isUsed',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'user_slots_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'user_slot_user_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            )
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'user_slot_listing_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'listingId',
            )
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'user_slot_expires_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'expiresAt',
            )
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'user_slot_active_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'isActive',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'users',
      dartName: 'User',
      schema: 'public',
      module: 'bay',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'users_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'username',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'passwordHash',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'role',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'protocol:UserRole',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'lastLoginAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'isActive',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _i2.ColumnDefinition(
          name: 'acceptedTerms',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'failedLoginAttempts',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'lockedUntil',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'stayLoggedIn',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'users_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'user_username_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'username',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    ..._i3.Protocol.targetTableDefinitions,
    ..._i2.Protocol.targetTableDefinitions,
  ];

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;
    if (t == _i4.MessageDraft) {
      return _i4.MessageDraft.fromJson(data) as T;
    }
    if (t == _i5.AuthResponse) {
      return _i5.AuthResponse.fromJson(data) as T;
    }
    if (t == _i6.Category) {
      return _i6.Category.fromJson(data) as T;
    }
    if (t == _i7.CurrencyRate) {
      return _i7.CurrencyRate.fromJson(data) as T;
    }
    if (t == _i8.Dispute) {
      return _i8.Dispute.fromJson(data) as T;
    }
    if (t == _i9.DisputeStatus) {
      return _i9.DisputeStatus.fromJson(data) as T;
    }
    if (t == _i10.EncryptedKeyBackup) {
      return _i10.EncryptedKeyBackup.fromJson(data) as T;
    }
    if (t == _i11.Favorite) {
      return _i11.Favorite.fromJson(data) as T;
    }
    if (t == _i12.Listing) {
      return _i12.Listing.fromJson(data) as T;
    }
    if (t == _i13.ListingImage) {
      return _i13.ListingImage.fromJson(data) as T;
    }
    if (t == _i14.LoginRequest) {
      return _i14.LoginRequest.fromJson(data) as T;
    }
    if (t == _i15.Message) {
      return _i15.Message.fromJson(data) as T;
    }
    if (t == _i16.Greeting) {
      return _i16.Greeting.fromJson(data) as T;
    }
    if (t == _i17.News) {
      return _i17.News.fromJson(data) as T;
    }
    if (t == _i18.OrderStatus) {
      return _i18.OrderStatus.fromJson(data) as T;
    }
    if (t == _i19.PaymentMethod) {
      return _i19.PaymentMethod.fromJson(data) as T;
    }
    if (t == _i20.QuantityUnit) {
      return _i20.QuantityUnit.fromJson(data) as T;
    }
    if (t == _i21.Rating) {
      return _i21.Rating.fromJson(data) as T;
    }
    if (t == _i22.RatingStats) {
      return _i22.RatingStats.fromJson(data) as T;
    }
    if (t == _i23.RatingValue) {
      return _i23.RatingValue.fromJson(data) as T;
    }
    if (t == _i24.RegistrationRequest) {
      return _i24.RegistrationRequest.fromJson(data) as T;
    }
    if (t == _i25.Report) {
      return _i25.Report.fromJson(data) as T;
    }
    if (t == _i26.ReportReason) {
      return _i26.ReportReason.fromJson(data) as T;
    }
    if (t == _i27.ReportStatus) {
      return _i27.ReportStatus.fromJson(data) as T;
    }
    if (t == _i28.UserSlot) {
      return _i28.UserSlot.fromJson(data) as T;
    }
    if (t == _i29.SearchResult) {
      return _i29.SearchResult.fromJson(data) as T;
    }
    if (t == _i30.Settings) {
      return _i30.Settings.fromJson(data) as T;
    }
    if (t == _i31.SlotOrder) {
      return _i31.SlotOrder.fromJson(data) as T;
    }
    if (t == _i32.SlotVariant) {
      return _i32.SlotVariant.fromJson(data) as T;
    }
    if (t == _i33.Transaction) {
      return _i33.Transaction.fromJson(data) as T;
    }
    if (t == _i34.TransactionStatus) {
      return _i34.TransactionStatus.fromJson(data) as T;
    }
    if (t == _i35.User) {
      return _i35.User.fromJson(data) as T;
    }
    if (t == _i36.UserPaymentInfo) {
      return _i36.UserPaymentInfo.fromJson(data) as T;
    }
    if (t == _i37.UserProfile) {
      return _i37.UserProfile.fromJson(data) as T;
    }
    if (t == _i38.UserPublicKey) {
      return _i38.UserPublicKey.fromJson(data) as T;
    }
    if (t == _i39.UserRole) {
      return _i39.UserRole.fromJson(data) as T;
    }
    if (t == _i40.ReportTargetType) {
      return _i40.ReportTargetType.fromJson(data) as T;
    }
    if (t == _i1.getType<_i4.MessageDraft?>()) {
      return (data != null ? _i4.MessageDraft.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.AuthResponse?>()) {
      return (data != null ? _i5.AuthResponse.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.Category?>()) {
      return (data != null ? _i6.Category.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.CurrencyRate?>()) {
      return (data != null ? _i7.CurrencyRate.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.Dispute?>()) {
      return (data != null ? _i8.Dispute.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.DisputeStatus?>()) {
      return (data != null ? _i9.DisputeStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.EncryptedKeyBackup?>()) {
      return (data != null ? _i10.EncryptedKeyBackup.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i11.Favorite?>()) {
      return (data != null ? _i11.Favorite.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.Listing?>()) {
      return (data != null ? _i12.Listing.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.ListingImage?>()) {
      return (data != null ? _i13.ListingImage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.LoginRequest?>()) {
      return (data != null ? _i14.LoginRequest.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.Message?>()) {
      return (data != null ? _i15.Message.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.Greeting?>()) {
      return (data != null ? _i16.Greeting.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.News?>()) {
      return (data != null ? _i17.News.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.OrderStatus?>()) {
      return (data != null ? _i18.OrderStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i19.PaymentMethod?>()) {
      return (data != null ? _i19.PaymentMethod.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i20.QuantityUnit?>()) {
      return (data != null ? _i20.QuantityUnit.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i21.Rating?>()) {
      return (data != null ? _i21.Rating.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i22.RatingStats?>()) {
      return (data != null ? _i22.RatingStats.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i23.RatingValue?>()) {
      return (data != null ? _i23.RatingValue.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i24.RegistrationRequest?>()) {
      return (data != null ? _i24.RegistrationRequest.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i25.Report?>()) {
      return (data != null ? _i25.Report.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i26.ReportReason?>()) {
      return (data != null ? _i26.ReportReason.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i27.ReportStatus?>()) {
      return (data != null ? _i27.ReportStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i28.UserSlot?>()) {
      return (data != null ? _i28.UserSlot.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i29.SearchResult?>()) {
      return (data != null ? _i29.SearchResult.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i30.Settings?>()) {
      return (data != null ? _i30.Settings.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i31.SlotOrder?>()) {
      return (data != null ? _i31.SlotOrder.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i32.SlotVariant?>()) {
      return (data != null ? _i32.SlotVariant.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i33.Transaction?>()) {
      return (data != null ? _i33.Transaction.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i34.TransactionStatus?>()) {
      return (data != null ? _i34.TransactionStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i35.User?>()) {
      return (data != null ? _i35.User.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i36.UserPaymentInfo?>()) {
      return (data != null ? _i36.UserPaymentInfo.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i37.UserProfile?>()) {
      return (data != null ? _i37.UserProfile.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i38.UserPublicKey?>()) {
      return (data != null ? _i38.UserPublicKey.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i39.UserRole?>()) {
      return (data != null ? _i39.UserRole.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i40.ReportTargetType?>()) {
      return (data != null ? _i40.ReportTargetType.fromJson(data) : null) as T;
    }
    if (t == List<_i12.Listing>) {
      return (data as List).map((e) => deserialize<_i12.Listing>(e)).toList()
          as T;
    }
    if (t == List<_i41.Category>) {
      return (data as List).map((e) => deserialize<_i41.Category>(e)).toList()
          as T;
    }
    if (t == Map<String, double>) {
      return (data as Map).map((k, v) =>
          MapEntry(deserialize<String>(k), deserialize<double>(v))) as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i42.Dispute>) {
      return (data as List).map((e) => deserialize<_i42.Dispute>(e)).toList()
          as T;
    }
    if (t == List<_i43.MessageDraft>) {
      return (data as List)
          .map((e) => deserialize<_i43.MessageDraft>(e))
          .toList() as T;
    }
    if (t == List<_i44.Listing>) {
      return (data as List).map((e) => deserialize<_i44.Listing>(e)).toList()
          as T;
    }
    if (t == Map<int, bool>) {
      return Map.fromEntries((data as List).map((e) =>
          MapEntry(deserialize<int>(e['k']), deserialize<bool>(e['v'])))) as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == List<_i45.ListingImage>) {
      return (data as List)
          .map((e) => deserialize<_i45.ListingImage>(e))
          .toList() as T;
    }
    if (t == List<_i46.Message>) {
      return (data as List).map((e) => deserialize<_i46.Message>(e)).toList()
          as T;
    }
    if (t == List<Map<String, dynamic>>) {
      return (data as List)
          .map((e) => deserialize<Map<String, dynamic>>(e))
          .toList() as T;
    }
    if (t == Map<String, dynamic>) {
      return (data as Map).map((k, v) =>
          MapEntry(deserialize<String>(k), deserialize<dynamic>(v))) as T;
    }
    if (t == List<_i47.News>) {
      return (data as List).map((e) => deserialize<_i47.News>(e)).toList() as T;
    }
    if (t == Map<String, String>) {
      return (data as Map).map((k, v) =>
          MapEntry(deserialize<String>(k), deserialize<String>(v))) as T;
    }
    if (t == _i1.getType<Map<String, dynamic>?>()) {
      return (data != null
          ? (data as Map).map((k, v) =>
              MapEntry(deserialize<String>(k), deserialize<dynamic>(v)))
          : null) as T;
    }
    if (t == List<_i48.EncryptedKeyBackup>) {
      return (data as List)
          .map((e) => deserialize<_i48.EncryptedKeyBackup>(e))
          .toList() as T;
    }
    if (t == List<_i49.Rating>) {
      return (data as List).map((e) => deserialize<_i49.Rating>(e)).toList()
          as T;
    }
    if (t == List<_i50.Transaction>) {
      return (data as List)
          .map((e) => deserialize<_i50.Transaction>(e))
          .toList() as T;
    }
    if (t == List<_i51.Report>) {
      return (data as List).map((e) => deserialize<_i51.Report>(e)).toList()
          as T;
    }
    if (t == List<_i52.SlotOrder>) {
      return (data as List).map((e) => deserialize<_i52.SlotOrder>(e)).toList()
          as T;
    }
    if (t == List<_i53.SlotVariant>) {
      return (data as List)
          .map((e) => deserialize<_i53.SlotVariant>(e))
          .toList() as T;
    }
    if (t == List<_i54.UserSlot>) {
      return (data as List).map((e) => deserialize<_i54.UserSlot>(e)).toList()
          as T;
    }
    if (t == Map<String, int>) {
      return (data as Map).map(
          (k, v) => MapEntry(deserialize<String>(k), deserialize<int>(v))) as T;
    }
    try {
      return _i3.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i2.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;
    if (data is _i4.MessageDraft) {
      return 'MessageDraft';
    }
    if (data is _i5.AuthResponse) {
      return 'AuthResponse';
    }
    if (data is _i6.Category) {
      return 'Category';
    }
    if (data is _i7.CurrencyRate) {
      return 'CurrencyRate';
    }
    if (data is _i8.Dispute) {
      return 'Dispute';
    }
    if (data is _i9.DisputeStatus) {
      return 'DisputeStatus';
    }
    if (data is _i10.EncryptedKeyBackup) {
      return 'EncryptedKeyBackup';
    }
    if (data is _i11.Favorite) {
      return 'Favorite';
    }
    if (data is _i12.Listing) {
      return 'Listing';
    }
    if (data is _i13.ListingImage) {
      return 'ListingImage';
    }
    if (data is _i14.LoginRequest) {
      return 'LoginRequest';
    }
    if (data is _i15.Message) {
      return 'Message';
    }
    if (data is _i16.Greeting) {
      return 'Greeting';
    }
    if (data is _i17.News) {
      return 'News';
    }
    if (data is _i18.OrderStatus) {
      return 'OrderStatus';
    }
    if (data is _i19.PaymentMethod) {
      return 'PaymentMethod';
    }
    if (data is _i20.QuantityUnit) {
      return 'QuantityUnit';
    }
    if (data is _i21.Rating) {
      return 'Rating';
    }
    if (data is _i22.RatingStats) {
      return 'RatingStats';
    }
    if (data is _i23.RatingValue) {
      return 'RatingValue';
    }
    if (data is _i24.RegistrationRequest) {
      return 'RegistrationRequest';
    }
    if (data is _i25.Report) {
      return 'Report';
    }
    if (data is _i26.ReportReason) {
      return 'ReportReason';
    }
    if (data is _i27.ReportStatus) {
      return 'ReportStatus';
    }
    if (data is _i28.UserSlot) {
      return 'UserSlot';
    }
    if (data is _i29.SearchResult) {
      return 'SearchResult';
    }
    if (data is _i30.Settings) {
      return 'Settings';
    }
    if (data is _i31.SlotOrder) {
      return 'SlotOrder';
    }
    if (data is _i32.SlotVariant) {
      return 'SlotVariant';
    }
    if (data is _i33.Transaction) {
      return 'Transaction';
    }
    if (data is _i34.TransactionStatus) {
      return 'TransactionStatus';
    }
    if (data is _i35.User) {
      return 'User';
    }
    if (data is _i36.UserPaymentInfo) {
      return 'UserPaymentInfo';
    }
    if (data is _i37.UserProfile) {
      return 'UserProfile';
    }
    if (data is _i38.UserPublicKey) {
      return 'UserPublicKey';
    }
    if (data is _i39.UserRole) {
      return 'UserRole';
    }
    if (data is _i40.ReportTargetType) {
      return 'ReportTargetType';
    }
    className = _i2.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod.$className';
    }
    className = _i3.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'MessageDraft') {
      return deserialize<_i4.MessageDraft>(data['data']);
    }
    if (dataClassName == 'AuthResponse') {
      return deserialize<_i5.AuthResponse>(data['data']);
    }
    if (dataClassName == 'Category') {
      return deserialize<_i6.Category>(data['data']);
    }
    if (dataClassName == 'CurrencyRate') {
      return deserialize<_i7.CurrencyRate>(data['data']);
    }
    if (dataClassName == 'Dispute') {
      return deserialize<_i8.Dispute>(data['data']);
    }
    if (dataClassName == 'DisputeStatus') {
      return deserialize<_i9.DisputeStatus>(data['data']);
    }
    if (dataClassName == 'EncryptedKeyBackup') {
      return deserialize<_i10.EncryptedKeyBackup>(data['data']);
    }
    if (dataClassName == 'Favorite') {
      return deserialize<_i11.Favorite>(data['data']);
    }
    if (dataClassName == 'Listing') {
      return deserialize<_i12.Listing>(data['data']);
    }
    if (dataClassName == 'ListingImage') {
      return deserialize<_i13.ListingImage>(data['data']);
    }
    if (dataClassName == 'LoginRequest') {
      return deserialize<_i14.LoginRequest>(data['data']);
    }
    if (dataClassName == 'Message') {
      return deserialize<_i15.Message>(data['data']);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_i16.Greeting>(data['data']);
    }
    if (dataClassName == 'News') {
      return deserialize<_i17.News>(data['data']);
    }
    if (dataClassName == 'OrderStatus') {
      return deserialize<_i18.OrderStatus>(data['data']);
    }
    if (dataClassName == 'PaymentMethod') {
      return deserialize<_i19.PaymentMethod>(data['data']);
    }
    if (dataClassName == 'QuantityUnit') {
      return deserialize<_i20.QuantityUnit>(data['data']);
    }
    if (dataClassName == 'Rating') {
      return deserialize<_i21.Rating>(data['data']);
    }
    if (dataClassName == 'RatingStats') {
      return deserialize<_i22.RatingStats>(data['data']);
    }
    if (dataClassName == 'RatingValue') {
      return deserialize<_i23.RatingValue>(data['data']);
    }
    if (dataClassName == 'RegistrationRequest') {
      return deserialize<_i24.RegistrationRequest>(data['data']);
    }
    if (dataClassName == 'Report') {
      return deserialize<_i25.Report>(data['data']);
    }
    if (dataClassName == 'ReportReason') {
      return deserialize<_i26.ReportReason>(data['data']);
    }
    if (dataClassName == 'ReportStatus') {
      return deserialize<_i27.ReportStatus>(data['data']);
    }
    if (dataClassName == 'UserSlot') {
      return deserialize<_i28.UserSlot>(data['data']);
    }
    if (dataClassName == 'SearchResult') {
      return deserialize<_i29.SearchResult>(data['data']);
    }
    if (dataClassName == 'Settings') {
      return deserialize<_i30.Settings>(data['data']);
    }
    if (dataClassName == 'SlotOrder') {
      return deserialize<_i31.SlotOrder>(data['data']);
    }
    if (dataClassName == 'SlotVariant') {
      return deserialize<_i32.SlotVariant>(data['data']);
    }
    if (dataClassName == 'Transaction') {
      return deserialize<_i33.Transaction>(data['data']);
    }
    if (dataClassName == 'TransactionStatus') {
      return deserialize<_i34.TransactionStatus>(data['data']);
    }
    if (dataClassName == 'User') {
      return deserialize<_i35.User>(data['data']);
    }
    if (dataClassName == 'UserPaymentInfo') {
      return deserialize<_i36.UserPaymentInfo>(data['data']);
    }
    if (dataClassName == 'UserProfile') {
      return deserialize<_i37.UserProfile>(data['data']);
    }
    if (dataClassName == 'UserPublicKey') {
      return deserialize<_i38.UserPublicKey>(data['data']);
    }
    if (dataClassName == 'UserRole') {
      return deserialize<_i39.UserRole>(data['data']);
    }
    if (dataClassName == 'ReportTargetType') {
      return deserialize<_i40.ReportTargetType>(data['data']);
    }
    if (dataClassName.startsWith('serverpod.')) {
      data['className'] = dataClassName.substring(10);
      return _i2.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth.')) {
      data['className'] = dataClassName.substring(15);
      return _i3.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  @override
  _i1.Table? getTableForType(Type t) {
    {
      var table = _i3.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _i2.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _i6.Category:
        return _i6.Category.t;
      case _i7.CurrencyRate:
        return _i7.CurrencyRate.t;
      case _i8.Dispute:
        return _i8.Dispute.t;
      case _i10.EncryptedKeyBackup:
        return _i10.EncryptedKeyBackup.t;
      case _i11.Favorite:
        return _i11.Favorite.t;
      case _i12.Listing:
        return _i12.Listing.t;
      case _i13.ListingImage:
        return _i13.ListingImage.t;
      case _i15.Message:
        return _i15.Message.t;
      case _i4.MessageDraft:
        return _i4.MessageDraft.t;
      case _i17.News:
        return _i17.News.t;
      case _i21.Rating:
        return _i21.Rating.t;
      case _i25.Report:
        return _i25.Report.t;
      case _i30.Settings:
        return _i30.Settings.t;
      case _i31.SlotOrder:
        return _i31.SlotOrder.t;
      case _i32.SlotVariant:
        return _i32.SlotVariant.t;
      case _i33.Transaction:
        return _i33.Transaction.t;
      case _i35.User:
        return _i35.User.t;
      case _i36.UserPaymentInfo:
        return _i36.UserPaymentInfo.t;
      case _i38.UserPublicKey:
        return _i38.UserPublicKey.t;
      case _i28.UserSlot:
        return _i28.UserSlot.t;
    }
    return null;
  }

  @override
  List<_i2.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

  @override
  String getModuleName() => 'bay';
}
