-- migrate:up
CREATE TABLE "workflow_matches_import_pending" (
    "profile_id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "priority" INTEGER NOT NULL
);

-- migrate:down
drop table "workflow_matches_import_pending";
