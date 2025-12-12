BEGIN;

--
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
-- MIGRATION VERSION FOR bay
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('bay', '20251212174714756', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251212174714756', "timestamp" = now();

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
