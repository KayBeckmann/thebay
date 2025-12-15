BEGIN;

--
-- ACTION CREATE TABLE
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
-- MIGRATION VERSION FOR bay
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('bay', '20251215052323714', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251215052323714', "timestamp" = now();

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
