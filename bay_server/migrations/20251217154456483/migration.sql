BEGIN;

--
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
-- MIGRATION VERSION FOR bay
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('bay', '20251217154456483', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251217154456483', "timestamp" = now();

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
