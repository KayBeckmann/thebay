BEGIN;

--
-- Class Category as table categories
--
CREATE TABLE "categories" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "parentId" bigint,
    "sortOrder" bigint NOT NULL,
    "isActive" boolean NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "categories_parent_idx" ON "categories" USING btree ("parentId");
CREATE UNIQUE INDEX "categories_name_parent_idx" ON "categories" USING btree ("name", "parentId");

--
-- Class CurrencyRate as table currency_rates
--
CREATE TABLE "currency_rates" (
    "id" bigserial PRIMARY KEY,
    "baseCurrency" text NOT NULL,
    "targetCurrency" text NOT NULL,
    "rate" double precision NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "currency_pair_idx" ON "currency_rates" USING btree ("baseCurrency", "targetCurrency");

--
-- Class Dispute as table disputes
--
CREATE TABLE "disputes" (
    "id" bigserial PRIMARY KEY,
    "transactionId" bigint NOT NULL,
    "openedByUserId" bigint NOT NULL,
    "reason" text NOT NULL,
    "status" bigint NOT NULL DEFAULT 0,
    "resolution" text,
    "moderatorId" bigint,
    "createdAt" timestamp without time zone NOT NULL,
    "resolvedAt" timestamp without time zone
);

-- Indexes
CREATE INDEX "dispute_transaction_idx" ON "disputes" USING btree ("transactionId");
CREATE INDEX "dispute_opened_by_idx" ON "disputes" USING btree ("openedByUserId");
CREATE INDEX "dispute_status_idx" ON "disputes" USING btree ("status");
CREATE INDEX "dispute_moderator_idx" ON "disputes" USING btree ("moderatorId");

--
-- Class EncryptedKeyBackup as table encrypted_key_backups
--
CREATE TABLE "encrypted_key_backups" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "encryptedPrivateKey" text NOT NULL,
    "fingerprint" text NOT NULL,
    "encryptionSalt" text NOT NULL,
    "kdfParams" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "isActive" boolean NOT NULL DEFAULT true
);

-- Indexes
CREATE INDEX "backup_user_idx" ON "encrypted_key_backups" USING btree ("userId");
CREATE INDEX "backup_fingerprint_idx" ON "encrypted_key_backups" USING btree ("fingerprint");
CREATE INDEX "backup_user_active_idx" ON "encrypted_key_backups" USING btree ("userId", "isActive");

--
-- Class Favorite as table favorites
--
CREATE TABLE "favorites" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "listingId" bigint NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "favorite_user_idx" ON "favorites" USING btree ("userId");
CREATE INDEX "favorite_listing_idx" ON "favorites" USING btree ("listingId");
CREATE UNIQUE INDEX "favorite_user_listing_idx" ON "favorites" USING btree ("userId", "listingId");

--
-- Class ListingImage as table listing_images
--
CREATE TABLE "listing_images" (
    "id" bigserial PRIMARY KEY,
    "listingId" bigint NOT NULL,
    "fileName" text NOT NULL,
    "originalName" text NOT NULL,
    "mimeType" text NOT NULL,
    "sizeBytes" bigint NOT NULL,
    "sortOrder" bigint NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "listing_image_listing_idx" ON "listing_images" USING btree ("listingId");
CREATE INDEX "listing_image_sort_idx" ON "listing_images" USING btree ("listingId", "sortOrder");

--
-- Class Listing as table listings
--
CREATE TABLE "listings" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "categoryId" bigint NOT NULL,
    "title" text NOT NULL,
    "description" text NOT NULL,
    "quantity" double precision NOT NULL,
    "quantityUnit" bigint NOT NULL,
    "pricePerUnit" bigint NOT NULL,
    "acceptsPaypal" boolean NOT NULL,
    "acceptsBitcoin" boolean NOT NULL,
    "hasShipping" boolean NOT NULL,
    "shippingMethod" text,
    "shippingCostCents" bigint,
    "isActive" boolean NOT NULL,
    "expiresAt" timestamp without time zone,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "listing_user_idx" ON "listings" USING btree ("userId");
CREATE INDEX "listing_category_idx" ON "listings" USING btree ("categoryId");
CREATE INDEX "listing_active_idx" ON "listings" USING btree ("isActive");
CREATE INDEX "listing_expires_idx" ON "listings" USING btree ("expiresAt");

--
-- Class MessageDraft as table message_drafts
--
CREATE TABLE "message_drafts" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "recipientId" bigint,
    "recipientUsername" text,
    "encryptedSubject" text,
    "encryptedContent" text,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL,
    "expiresAt" timestamp without time zone NOT NULL,
    "listingId" bigint
);

-- Indexes
CREATE INDEX "draft_user_idx" ON "message_drafts" USING btree ("userId");
CREATE INDEX "draft_expires_idx" ON "message_drafts" USING btree ("expiresAt");
CREATE INDEX "draft_listing_idx" ON "message_drafts" USING btree ("listingId");

--
-- Class Message as table messages
--
CREATE TABLE "messages" (
    "id" bigserial PRIMARY KEY,
    "senderId" bigint NOT NULL,
    "recipientId" bigint NOT NULL,
    "encryptedSubject" text NOT NULL,
    "encryptedContent" text NOT NULL,
    "isRead" boolean NOT NULL DEFAULT false,
    "deletedBySender" boolean NOT NULL DEFAULT false,
    "deletedByRecipient" boolean NOT NULL DEFAULT false,
    "createdAt" timestamp without time zone NOT NULL,
    "listingId" bigint,
    "parentMessageId" bigint
);

-- Indexes
CREATE INDEX "message_sender_idx" ON "messages" USING btree ("senderId");
CREATE INDEX "message_recipient_idx" ON "messages" USING btree ("recipientId");
CREATE INDEX "message_recipient_read_idx" ON "messages" USING btree ("recipientId", "isRead");
CREATE INDEX "message_created_idx" ON "messages" USING btree ("createdAt");
CREATE INDEX "message_listing_idx" ON "messages" USING btree ("listingId");

--
-- Class News as table news
--
CREATE TABLE "news" (
    "id" bigserial PRIMARY KEY,
    "title" text NOT NULL,
    "content" text NOT NULL,
    "authorId" bigint NOT NULL,
    "isPublished" boolean NOT NULL,
    "publishedAt" timestamp without time zone,
    "expiresAt" timestamp without time zone,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "news_published_idx" ON "news" USING btree ("isPublished", "publishedAt");
CREATE INDEX "news_expires_idx" ON "news" USING btree ("expiresAt");

--
-- Class Rating as table ratings
--
CREATE TABLE "ratings" (
    "id" bigserial PRIMARY KEY,
    "transactionId" bigint NOT NULL,
    "fromUserId" bigint NOT NULL,
    "toUserId" bigint NOT NULL,
    "rating" bigint NOT NULL,
    "comment" text,
    "createdAt" timestamp without time zone NOT NULL,
    "isAutomatic" boolean NOT NULL DEFAULT false
);

-- Indexes
CREATE INDEX "rating_transaction_idx" ON "ratings" USING btree ("transactionId");
CREATE INDEX "rating_from_user_idx" ON "ratings" USING btree ("fromUserId");
CREATE INDEX "rating_to_user_idx" ON "ratings" USING btree ("toUserId");
CREATE UNIQUE INDEX "rating_transaction_from_unique" ON "ratings" USING btree ("transactionId", "fromUserId");

--
-- Class Settings as table settings
--
CREATE TABLE "settings" (
    "id" bigserial PRIMARY KEY,
    "key" text NOT NULL,
    "value" text NOT NULL,
    "description" text,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "settings_key_idx" ON "settings" USING btree ("key");

--
-- Class SlotOrder as table slot_orders
--
CREATE TABLE "slot_orders" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "slotVariantId" bigint NOT NULL,
    "paymentMethod" bigint NOT NULL,
    "amountCents" bigint NOT NULL,
    "transactionId" text,
    "status" bigint NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "paidAt" timestamp without time zone,
    "completedAt" timestamp without time zone
);

-- Indexes
CREATE INDEX "slot_order_user_idx" ON "slot_orders" USING btree ("userId");
CREATE INDEX "slot_order_status_idx" ON "slot_orders" USING btree ("status");
CREATE INDEX "slot_order_tx_idx" ON "slot_orders" USING btree ("transactionId");

--
-- Class SlotVariant as table slot_variants
--
CREATE TABLE "slot_variants" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "description" text,
    "priceUsdCents" bigint NOT NULL,
    "durationDays" bigint NOT NULL,
    "allowPaypal" boolean NOT NULL,
    "allowBitcoin" boolean NOT NULL,
    "isActive" boolean NOT NULL,
    "sortOrder" bigint NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "slot_variants_active_idx" ON "slot_variants" USING btree ("isActive", "sortOrder");
CREATE UNIQUE INDEX "slot_variants_name_idx" ON "slot_variants" USING btree ("name");

--
-- Class Transaction as table transactions
--
CREATE TABLE "transactions" (
    "id" bigserial PRIMARY KEY,
    "buyerId" bigint NOT NULL,
    "sellerId" bigint NOT NULL,
    "listingId" bigint NOT NULL,
    "status" bigint NOT NULL DEFAULT 0,
    "quantity" double precision NOT NULL,
    "totalPriceCents" bigint NOT NULL,
    "paymentMethod" bigint NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL,
    "shippedAt" timestamp without time zone,
    "receivedAt" timestamp without time zone,
    "completedAt" timestamp without time zone,
    "autoCompleteAt" timestamp without time zone,
    "buyerNote" text
);

-- Indexes
CREATE INDEX "transaction_buyer_idx" ON "transactions" USING btree ("buyerId");
CREATE INDEX "transaction_seller_idx" ON "transactions" USING btree ("sellerId");
CREATE INDEX "transaction_listing_idx" ON "transactions" USING btree ("listingId");
CREATE INDEX "transaction_status_idx" ON "transactions" USING btree ("status");
CREATE INDEX "transaction_auto_complete_idx" ON "transactions" USING btree ("autoCompleteAt");

--
-- Class UserPaymentInfo as table user_payment_info
--
CREATE TABLE "user_payment_info" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "paypalAddress" text,
    "bitcoinWallet" text,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "user_payment_info_user_idx" ON "user_payment_info" USING btree ("userId");

--
-- Class UserPublicKey as table user_public_keys
--
CREATE TABLE "user_public_keys" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "publicKeyArmored" text NOT NULL,
    "fingerprint" text NOT NULL,
    "algorithm" text NOT NULL,
    "keySize" bigint NOT NULL,
    "keyIdentity" text NOT NULL,
    "isActive" boolean NOT NULL DEFAULT true,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "user_public_key_user_idx" ON "user_public_keys" USING btree ("userId");
CREATE UNIQUE INDEX "user_public_key_fingerprint_idx" ON "user_public_keys" USING btree ("fingerprint");
CREATE INDEX "user_public_key_active_idx" ON "user_public_keys" USING btree ("userId", "isActive");

--
-- Class UserSlot as table user_slots
--
CREATE TABLE "user_slots" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "slotVariantId" bigint NOT NULL,
    "listingId" bigint,
    "purchasedAt" timestamp without time zone NOT NULL,
    "expiresAt" timestamp without time zone NOT NULL,
    "isActive" boolean NOT NULL,
    "isUsed" boolean NOT NULL
);

-- Indexes
CREATE INDEX "user_slot_user_idx" ON "user_slots" USING btree ("userId");
CREATE INDEX "user_slot_listing_idx" ON "user_slots" USING btree ("listingId");
CREATE INDEX "user_slot_expires_idx" ON "user_slots" USING btree ("expiresAt");
CREATE INDEX "user_slot_active_idx" ON "user_slots" USING btree ("userId", "isActive");

--
-- Class User as table users
--
CREATE TABLE "users" (
    "id" bigserial PRIMARY KEY,
    "username" text NOT NULL,
    "passwordHash" text NOT NULL,
    "role" bigint NOT NULL DEFAULT 0,
    "createdAt" timestamp without time zone NOT NULL,
    "lastLoginAt" timestamp without time zone,
    "isActive" boolean NOT NULL DEFAULT true,
    "acceptedTerms" boolean NOT NULL DEFAULT false,
    "failedLoginAttempts" bigint NOT NULL DEFAULT 0,
    "lockedUntil" timestamp without time zone,
    "stayLoggedIn" boolean NOT NULL DEFAULT false
);

-- Indexes
CREATE UNIQUE INDEX "user_username_idx" ON "users" USING btree ("username");

--
-- Class CloudStorageEntry as table serverpod_cloud_storage
--
CREATE TABLE "serverpod_cloud_storage" (
    "id" bigserial PRIMARY KEY,
    "storageId" text NOT NULL,
    "path" text NOT NULL,
    "addedTime" timestamp without time zone NOT NULL,
    "expiration" timestamp without time zone,
    "byteData" bytea NOT NULL,
    "verified" boolean NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_cloud_storage_path_idx" ON "serverpod_cloud_storage" USING btree ("storageId", "path");
CREATE INDEX "serverpod_cloud_storage_expiration" ON "serverpod_cloud_storage" USING btree ("expiration");

--
-- Class CloudStorageDirectUploadEntry as table serverpod_cloud_storage_direct_upload
--
CREATE TABLE "serverpod_cloud_storage_direct_upload" (
    "id" bigserial PRIMARY KEY,
    "storageId" text NOT NULL,
    "path" text NOT NULL,
    "expiration" timestamp without time zone NOT NULL,
    "authKey" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_cloud_storage_direct_upload_storage_path" ON "serverpod_cloud_storage_direct_upload" USING btree ("storageId", "path");

--
-- Class FutureCallEntry as table serverpod_future_call
--
CREATE TABLE "serverpod_future_call" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "time" timestamp without time zone NOT NULL,
    "serializedObject" text,
    "serverId" text NOT NULL,
    "identifier" text
);

-- Indexes
CREATE INDEX "serverpod_future_call_time_idx" ON "serverpod_future_call" USING btree ("time");
CREATE INDEX "serverpod_future_call_serverId_idx" ON "serverpod_future_call" USING btree ("serverId");
CREATE INDEX "serverpod_future_call_identifier_idx" ON "serverpod_future_call" USING btree ("identifier");

--
-- Class ServerHealthConnectionInfo as table serverpod_health_connection_info
--
CREATE TABLE "serverpod_health_connection_info" (
    "id" bigserial PRIMARY KEY,
    "serverId" text NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    "active" bigint NOT NULL,
    "closing" bigint NOT NULL,
    "idle" bigint NOT NULL,
    "granularity" bigint NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_health_connection_info_timestamp_idx" ON "serverpod_health_connection_info" USING btree ("timestamp", "serverId", "granularity");

--
-- Class ServerHealthMetric as table serverpod_health_metric
--
CREATE TABLE "serverpod_health_metric" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "serverId" text NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    "isHealthy" boolean NOT NULL,
    "value" double precision NOT NULL,
    "granularity" bigint NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_health_metric_timestamp_idx" ON "serverpod_health_metric" USING btree ("timestamp", "serverId", "name", "granularity");

--
-- Class LogEntry as table serverpod_log
--
CREATE TABLE "serverpod_log" (
    "id" bigserial PRIMARY KEY,
    "sessionLogId" bigint NOT NULL,
    "messageId" bigint,
    "reference" text,
    "serverId" text NOT NULL,
    "time" timestamp without time zone NOT NULL,
    "logLevel" bigint NOT NULL,
    "message" text NOT NULL,
    "error" text,
    "stackTrace" text,
    "order" bigint NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_log_sessionLogId_idx" ON "serverpod_log" USING btree ("sessionLogId");

--
-- Class MessageLogEntry as table serverpod_message_log
--
CREATE TABLE "serverpod_message_log" (
    "id" bigserial PRIMARY KEY,
    "sessionLogId" bigint NOT NULL,
    "serverId" text NOT NULL,
    "messageId" bigint NOT NULL,
    "endpoint" text NOT NULL,
    "messageName" text NOT NULL,
    "duration" double precision NOT NULL,
    "error" text,
    "stackTrace" text,
    "slow" boolean NOT NULL,
    "order" bigint NOT NULL
);

--
-- Class MethodInfo as table serverpod_method
--
CREATE TABLE "serverpod_method" (
    "id" bigserial PRIMARY KEY,
    "endpoint" text NOT NULL,
    "method" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_method_endpoint_method_idx" ON "serverpod_method" USING btree ("endpoint", "method");

--
-- Class DatabaseMigrationVersion as table serverpod_migrations
--
CREATE TABLE "serverpod_migrations" (
    "id" bigserial PRIMARY KEY,
    "module" text NOT NULL,
    "version" text NOT NULL,
    "timestamp" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_migrations_ids" ON "serverpod_migrations" USING btree ("module");

--
-- Class QueryLogEntry as table serverpod_query_log
--
CREATE TABLE "serverpod_query_log" (
    "id" bigserial PRIMARY KEY,
    "serverId" text NOT NULL,
    "sessionLogId" bigint NOT NULL,
    "messageId" bigint,
    "query" text NOT NULL,
    "duration" double precision NOT NULL,
    "numRows" bigint,
    "error" text,
    "stackTrace" text,
    "slow" boolean NOT NULL,
    "order" bigint NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_query_log_sessionLogId_idx" ON "serverpod_query_log" USING btree ("sessionLogId");

--
-- Class ReadWriteTestEntry as table serverpod_readwrite_test
--
CREATE TABLE "serverpod_readwrite_test" (
    "id" bigserial PRIMARY KEY,
    "number" bigint NOT NULL
);

--
-- Class RuntimeSettings as table serverpod_runtime_settings
--
CREATE TABLE "serverpod_runtime_settings" (
    "id" bigserial PRIMARY KEY,
    "logSettings" json NOT NULL,
    "logSettingsOverrides" json NOT NULL,
    "logServiceCalls" boolean NOT NULL,
    "logMalformedCalls" boolean NOT NULL
);

--
-- Class SessionLogEntry as table serverpod_session_log
--
CREATE TABLE "serverpod_session_log" (
    "id" bigserial PRIMARY KEY,
    "serverId" text NOT NULL,
    "time" timestamp without time zone NOT NULL,
    "module" text,
    "endpoint" text,
    "method" text,
    "duration" double precision,
    "numQueries" bigint,
    "slow" boolean,
    "error" text,
    "stackTrace" text,
    "authenticatedUserId" bigint,
    "isOpen" boolean,
    "touched" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_session_log_serverid_idx" ON "serverpod_session_log" USING btree ("serverId");
CREATE INDEX "serverpod_session_log_touched_idx" ON "serverpod_session_log" USING btree ("touched");
CREATE INDEX "serverpod_session_log_isopen_idx" ON "serverpod_session_log" USING btree ("isOpen");

--
-- Class AuthKey as table serverpod_auth_key
--
CREATE TABLE "serverpod_auth_key" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "hash" text NOT NULL,
    "scopeNames" json NOT NULL,
    "method" text NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_auth_key_userId_idx" ON "serverpod_auth_key" USING btree ("userId");

--
-- Class EmailAuth as table serverpod_email_auth
--
CREATE TABLE "serverpod_email_auth" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "email" text NOT NULL,
    "hash" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_email_auth_email" ON "serverpod_email_auth" USING btree ("email");

--
-- Class EmailCreateAccountRequest as table serverpod_email_create_request
--
CREATE TABLE "serverpod_email_create_request" (
    "id" bigserial PRIMARY KEY,
    "userName" text NOT NULL,
    "email" text NOT NULL,
    "hash" text NOT NULL,
    "verificationCode" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_email_auth_create_account_request_idx" ON "serverpod_email_create_request" USING btree ("email");

--
-- Class EmailFailedSignIn as table serverpod_email_failed_sign_in
--
CREATE TABLE "serverpod_email_failed_sign_in" (
    "id" bigserial PRIMARY KEY,
    "email" text NOT NULL,
    "time" timestamp without time zone NOT NULL,
    "ipAddress" text NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_email_failed_sign_in_email_idx" ON "serverpod_email_failed_sign_in" USING btree ("email");
CREATE INDEX "serverpod_email_failed_sign_in_time_idx" ON "serverpod_email_failed_sign_in" USING btree ("time");

--
-- Class EmailReset as table serverpod_email_reset
--
CREATE TABLE "serverpod_email_reset" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "verificationCode" text NOT NULL,
    "expiration" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_email_reset_verification_idx" ON "serverpod_email_reset" USING btree ("verificationCode");

--
-- Class GoogleRefreshToken as table serverpod_google_refresh_token
--
CREATE TABLE "serverpod_google_refresh_token" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "refreshToken" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_google_refresh_token_userId_idx" ON "serverpod_google_refresh_token" USING btree ("userId");

--
-- Class UserImage as table serverpod_user_image
--
CREATE TABLE "serverpod_user_image" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "version" bigint NOT NULL,
    "url" text NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_user_image_user_id" ON "serverpod_user_image" USING btree ("userId", "version");

--
-- Class UserInfo as table serverpod_user_info
--
CREATE TABLE "serverpod_user_info" (
    "id" bigserial PRIMARY KEY,
    "userIdentifier" text NOT NULL,
    "userName" text,
    "fullName" text,
    "email" text,
    "created" timestamp without time zone NOT NULL,
    "imageUrl" text,
    "scopeNames" json NOT NULL,
    "blocked" boolean NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_user_info_user_identifier" ON "serverpod_user_info" USING btree ("userIdentifier");
CREATE INDEX "serverpod_user_info_email" ON "serverpod_user_info" USING btree ("email");

--
-- Foreign relations for "serverpod_log" table
--
ALTER TABLE ONLY "serverpod_log"
    ADD CONSTRAINT "serverpod_log_fk_0"
    FOREIGN KEY("sessionLogId")
    REFERENCES "serverpod_session_log"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_message_log" table
--
ALTER TABLE ONLY "serverpod_message_log"
    ADD CONSTRAINT "serverpod_message_log_fk_0"
    FOREIGN KEY("sessionLogId")
    REFERENCES "serverpod_session_log"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_query_log" table
--
ALTER TABLE ONLY "serverpod_query_log"
    ADD CONSTRAINT "serverpod_query_log_fk_0"
    FOREIGN KEY("sessionLogId")
    REFERENCES "serverpod_session_log"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR bay
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('bay', '20251218123313074', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251218123313074', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240516151843329', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240516151843329', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth', '20240520102713718', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240520102713718', "timestamp" = now();


COMMIT;
