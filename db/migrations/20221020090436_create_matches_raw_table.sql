-- migrate:up
CREATE TABLE "workflow_matches_raw" (
    "match_id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "json" TEXT NOT NULL,
    "version" INTEGER,
    "error" BOOLEAN
);

CREATE INDEX "workflow_matches_raw_version_IDX" ON "workflow_matches_raw" ("version");
CREATE INDEX "workflow_matches_raw_error_IDX" ON "workflow_matches_raw" ("error");

-- migrate:down
DROP TABLE "workflow_matches_raw";
