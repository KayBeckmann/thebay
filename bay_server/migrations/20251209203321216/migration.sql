BEGIN;

--
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
-- MIGRATION VERSION FOR bay
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('bay', '20251209203321216', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251209203321216', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240516151843329', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240516151843329', "timestamp" = now();


COMMIT;
