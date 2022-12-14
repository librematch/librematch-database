-- migrate:up
CREATE TABLE IF NOT EXISTS "tbl_profiles_statistics" (
	"profile_statistic_ulid" TEXT(26) PRIMARY KEY NOT NULL,
    -- "game_ulid_ref" TEXT(26), -- REL
    -- "leaderboards_ulid_ref" TEXT(26), -- REL
	"timestamp_dt" DATETIME NOT NULL,
    "interval_days" INTEGER
    -- TODO: Talk to Coolio on Discord
    -- IDEAS:
    -- - how many games per week
    -- - how many losses/wins
    -- - more chatty?
    -- - which games played most? how long?
    -- - most played civs (favourite civs)
    -- - most wins with which civs
    -- - most played map
    -- - most won map (which civ?)
    -- - how much time spent in queue
    -- - percentage of 1v1 vs TG (both ranked)
    -- - tends to pick civ (metric?)
    -- - "Player X has a YY.Z% winrate vs <civ_x> in <year>/<month> on <map>"
    -- - etc.
	-- CONSTRAINT "statistics_game_ulid_ref_fkey" FOREIGN KEY ("game_ulid_ref") REFERENCES "games" ("ulid"),
	-- CONSTRAINT "statistics_leaderboards_ulid_ref_fkey" FOREIGN KEY ("leaderboards_ulid_ref") REFERENCES "leaderboards" ("ulid")
);

-- CREATE INDEX "statistics_timestamp_dt_IDX" ON "statistics" ("timestamp_dt");
-- CREATE INDEX "statistics_game_ulid_ref_IDX" ON "statistics" ("game_ulid_ref");
-- CREATE INDEX "statistics_leaderboards_ulid_ref_IDX" ON "statistics" ("leaderboards_ulid_ref");

-- migrate:down
DROP TABLE "tbl_profiles_statistics";

