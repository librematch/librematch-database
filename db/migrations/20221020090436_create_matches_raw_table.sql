-- migrate:up
CREATE TABLE "matches_raw" (
    "match_id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "json" TEXT NOT NULL,
    "version" INTEGER,
    "error" BOOLEAN
);

CREATE INDEX "matches_raw_version_IDX" ON "matches_raw" ("version");
CREATE INDEX "matches_raw_error_IDX" ON "matches_raw" ("error");

-- migrate:down
drop table "matches_raw";
