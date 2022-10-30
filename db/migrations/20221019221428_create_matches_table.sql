-- migrate:up
CREATE TABLE "tbl_matches" (
    "match_ulid" TEXT(26) PRIMARY KEY NOT NULL,
    "match_id" INTEGER NOT NULL,
    "leaderboard_ulid_ref" TEXT(26) NOT NULL,
    "creator_profile_ulid_ref" TEXT(26),
    "match_setting_ulid_ref" TEXT NOT NULL,
    "name" TEXT,
    "server" TEXT,
    "started_dt" DATETIME,
    "finished_dt" DATETIME,
    "map_id" INTEGER, -- originally "location", changed due to confusion in tournaments
    "map_size" SMALLINT,
    "is_private" BOOLEAN DEFAULT FALSE NOT NULL,
    "is_rematch" BOOLEAN DEFAULT FALSE NOT NULL,
    "patch_version" FLOAT,
    CONSTRAINT "matches_creator_profile_ulid_fkey" FOREIGN KEY ("creator_profile_ulid_ref") REFERENCES "tbl_profiles" ("profile_ulid") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "matches_match_settings_ulid_ref_fkey" FOREIGN KEY ("match_setting_ulid_ref") REFERENCES "tbl_match_settings" ("match_setting_ulid")
);

CREATE INDEX "match_finished_dt_IDX" ON "tbl_matches" ("finished_dt");
CREATE INDEX "match_started_dt_IDX" ON "tbl_matches" ("started_dt");
CREATE INDEX "match_same_map_IDX" ON "tbl_matches" ("map_id");
CREATE INDEX "match_privacy_IDX" ON "tbl_matches" ("is_private");
CREATE INDEX "match_rematch_IDX" ON "tbl_matches" ("is_rematch");
CREATE INDEX "match_same_server_IDX" ON "tbl_matches" ("server");
CREATE INDEX "match_version_IDX" ON "tbl_matches" ("version");
CREATE INDEX "match_same_settings_IDX" ON "tbl_matches" ("match_setting_ulid_ref");

-- migrate:down
drop table "tbl_matches";
