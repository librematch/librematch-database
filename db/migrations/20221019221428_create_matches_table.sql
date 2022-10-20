-- migrate:up
CREATE TABLE "matches" (
    "ulid" TEXT(26) NOT NULL,
    "match_id" INTEGER NOT NULL,
    "leaderboards_ulid_ref" TEXT(26) NOT NULL,
    "name" TEXT,
    "server" TEXT,
    "started_dt" DATETIME,
    "finished_dt" DATETIME,
    "started_ts" INTEGER,
    "finished_ts" INTEGER,
    "location" INTEGER,
    "map_size" SMALLINT,
    "match_settings" TEXT NOT NULL,
    "rematch" BOOLEAN DEFAULT FALSE NOT NULL,
    "creator_profile_id" INTEGER,
    PRIMARY KEY ("ulid", "match_id", "leaderboards_ulid_ref"),
    CONSTRAINT "matches_creator_profile_id_fkey" FOREIGN KEY ("creator_profile_id") REFERENCES "profiles" ("profile_id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "matches_match_settings_fkey" FOREIGN KEY ("match_settings") REFERENCES "match_settings" ("sha256_hash")
);

CREATE INDEX "match_finished_dt_IDX" ON "matches" ("finished_dt");
CREATE INDEX "match_finished_ts_IDX" ON "matches" ("finished_ts");
CREATE INDEX "match_started_dt_IDX" ON "matches" ("started_dt");
CREATE INDEX "match_started_ts_IDX" ON "matches" ("started_ts");
CREATE INDEX "match_location_IDX" ON "matches" ("location");
CREATE INDEX "match_privacy_IDX" ON "matches" ("privacy");
CREATE INDEX "match_server_IDX" ON "matches" ("server");
CREATE INDEX "match_rematch_IDX" ON "matches" ("rematch");

-- migrate:down
drop table "matches";
