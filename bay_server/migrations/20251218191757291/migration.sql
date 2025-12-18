BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "reports" (
    "id" bigserial PRIMARY KEY,
    "reporterId" bigint NOT NULL,
    "targetType" bigint NOT NULL,
    "targetId" bigint NOT NULL,
    "reason" bigint NOT NULL,
    "details" text,
    "status" bigint NOT NULL DEFAULT 0,
    "assignedModeratorId" bigint,
    "moderatorNotes" text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "resolvedAt" timestamp without time zone
);

-- Indexes
CREATE INDEX "reports_reporter_idx" ON "reports" USING btree ("reporterId");
CREATE INDEX "reports_target_idx" ON "reports" USING btree ("targetType", "targetId");
CREATE INDEX "reports_status_idx" ON "reports" USING btree ("status");
CREATE UNIQUE INDEX "reports_unique_target_per_user" ON "reports" USING btree ("reporterId", "targetType", "targetId");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "reports"
    ADD CONSTRAINT "reports_fk_0"
    FOREIGN KEY("reporterId")
    REFERENCES "users"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "reports"
    ADD CONSTRAINT "reports_fk_1"
    FOREIGN KEY("assignedModeratorId")
    REFERENCES "users"("id")
    ON DELETE SET NULL
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR bay
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('bay', '20251218191757291', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251218191757291', "timestamp" = now();

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
