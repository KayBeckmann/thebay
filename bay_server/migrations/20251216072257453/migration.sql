BEGIN;

--
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
-- MIGRATION VERSION FOR bay
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('bay', '20251216072257453', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251216072257453', "timestamp" = now();

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
