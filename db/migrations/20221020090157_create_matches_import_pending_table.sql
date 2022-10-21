-- migrate:up
CREATE TABLE "matches_import_pending" (
    "profile_id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "priority" INTEGER NOT NULL
);

-- migrate:down
drop table "matches_import_pending";
