BEGIN;

--
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
-- MIGRATION VERSION FOR bay
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('bay', '20251212194832698', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251212194832698', "timestamp" = now();

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
