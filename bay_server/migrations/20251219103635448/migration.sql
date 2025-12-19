BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "user_ban_log" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "adminId" bigint NOT NULL,
    "action" text NOT NULL,
    "reason" text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "user_ban_log_user_idx" ON "user_ban_log" USING btree ("userId");

--
-- ACTION ALTER TABLE
--
ALTER TABLE "users" ADD COLUMN "isBanned" boolean NOT NULL DEFAULT false;
ALTER TABLE "users" ADD COLUMN "bannedAt" timestamp without time zone;
ALTER TABLE "users" ADD COLUMN "bannedReason" text;
ALTER TABLE "users" ADD COLUMN "bannedBy" bigint;
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "user_ban_log"
    ADD CONSTRAINT "user_ban_log_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "users"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "user_ban_log"
    ADD CONSTRAINT "user_ban_log_fk_1"
    FOREIGN KEY("adminId")
    REFERENCES "users"("id")
    ON DELETE SET NULL
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "users"
    ADD CONSTRAINT "users_fk_0"
    FOREIGN KEY("bannedBy")
    REFERENCES "users"("id")
    ON DELETE SET NULL
    ON UPDATE NO ACTION;

--
-- MIGRATION VERSION FOR bay
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('bay', '20251219103635448', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251219103635448', "timestamp" = now();

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
