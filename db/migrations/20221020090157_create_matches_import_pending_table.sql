-- migrate:up
CREATE TABLE IF NOT EXISTS "workflow_matches_import_pending" (
    "profile_id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "priority" INTEGER NOT NULL
);

-- migrate:down
DROP TABLE "workflow_matches_import_pending";
