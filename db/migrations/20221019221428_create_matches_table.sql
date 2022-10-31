-- migrate:up
CREATE TABLE IF NOT EXISTS "tbl_matches" (
    "match_ulid" TEXT(26) PRIMARY KEY NOT NULL,
    "leaderboard_ulid_ref" TEXT(26) NOT NULL,
    "map_ulid_ref" TEXT(26) NOT NULL, -- originally "location", changed due to confusion in tournaments (geographical location)
    "relic_link_match_uuid" TEXT(36) NOT NULL UNIQUE,
    "relic_link_match_id" INTEGER NOT NULL UNIQUE,
    "name_lobby" TEXT NOT NULL,
    "server" TEXT NOT NULL,
    "datetime_started" DATETIME NULL,
    "datetime_finished" DATETIME NULL,
    "is_private" BOOLEAN DEFAULT FALSE NOT NULL,
    "is_rematch" BOOLEAN DEFAULT FALSE NOT NULL,
    "is_archived" BOOLEAN DEFAULT FALSE NOT NULL,
    FOREIGN KEY ("leaderboard_ulid_ref") REFERENCES "tbl_leaderboards" ("leaderboard_ulid") ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY ("map_ulid_ref") REFERENCES "tbl_maps" ("map_ulid") ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE INDEX "matches_same_settings_IDX" ON "tbl_matches" ("match_setting_ulid_ref"); -- FEATURE: SAME SETTINGS
CREATE INDEX "matches_rematch_IDX" ON "tbl_matches" ("is_rematch"); -- FEATURE: REMATCH
CREATE INDEX "matches_matches_on_leaderboard_IDX" ON "tbl_matches" ("leaderboard_ulid_ref");
CREATE INDEX "matches_relic_link_match_uuid_IDX" ON "tbl_matches" ("relic_link_match_uuid");
CREATE INDEX "matches_relic_link_match_id_IDX" ON "tbl_matches" ("relic_link_match_id");
CREATE INDEX "matches_datetime_finished_IDX" ON "tbl_matches" ("datetime_finished");
CREATE INDEX "matches_datetime_started_IDX" ON "tbl_matches" ("datetime_started");
CREATE INDEX "matches_is_private_IDX" ON "tbl_matches" ("is_private");
CREATE INDEX "matches_same_server_IDX" ON "tbl_matches" ("server");
CREATE INDEX "matches_patch_version_IDX" ON "tbl_matches" ("patch_version");
CREATE INDEX "matches_is_archived_IDX" ON "tbl_matches" ("is_archived");

-- migrate:down
DROP TABLE "tbl_matches";
