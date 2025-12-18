BEGIN;

--
-- ACTION CREATE TABLE
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
