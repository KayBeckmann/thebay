BEGIN;

--
-- ACTION CREATE TABLE
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
-- MIGRATION VERSION FOR bay
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('bay', '20251217145623978', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251217145623978', "timestamp" = now();

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
