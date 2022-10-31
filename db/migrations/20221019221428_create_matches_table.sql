-- migrate:up
CREATE TABLE "tbl_matches" (
    "match_ulid" TEXT(26) PRIMARY KEY NOT NULL,
    "leaderboard_ulid_ref" TEXT(26) NOT NULL,
    "relic_link_match_uuid" TEXT(36) NOT NULL UNIQUE,
    "relic_link_match_id" INTEGER NOT NULL UNIQUE,
    "name" TEXT,
    "server" TEXT,
    "map_id" INTEGER, -- originally "location", changed due to confusion in tournaments (geographical location)
    "started_dt" DATETIME,
    "finished_dt" DATETIME,
    "map_size" SMALLINT,
    "patch_version" FLOAT,
    "is_private" BOOLEAN DEFAULT FALSE NOT NULL,
    "is_rematch" BOOLEAN DEFAULT FALSE NOT NULL,
    "is_archived" BOOLEAN DEFAULT FALSE NOT NULL,
    FOREIGN KEY ("leaderboard_ulid_ref") REFERENCES "tbl_leaderboards" ("leaderboard_ulid") ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE INDEX "matches_same_settings_IDX" ON "tbl_matches" ("match_setting_ulid_ref"); -- FEATURE: SAME SETTINGS
CREATE INDEX "matches_same_map_IDX" ON "tbl_matches" ("map_id");  -- FEATURE: SAME MAP
CREATE INDEX "matches_rematch_IDX" ON "tbl_matches" ("is_rematch"); -- FEATURE: REMATCH
CREATE INDEX "matches_matches_on_leaderboard_IDX" ON "tbl_matches" ("leaderboard_ulid_ref");
CREATE INDEX "matches_relic_link_match_uuid_IDX" ON "tbl_matches" ("relic_link_match_uuid");
CREATE INDEX "matches_relic_link_match_id_IDX" ON "tbl_matches" ("relic_link_match_id");
CREATE INDEX "matches_finished_dt_IDX" ON "tbl_matches" ("finished_dt");
CREATE INDEX "matches_started_dt_IDX" ON "tbl_matches" ("started_dt");
CREATE INDEX "matches_is_private_IDX" ON "tbl_matches" ("is_private");
CREATE INDEX "matches_same_server_IDX" ON "tbl_matches" ("server");
CREATE INDEX "matches_version_IDX" ON "tbl_matches" ("version");

-- migrate:down
DROP TABLE "tbl_matches";
