-- migrate:up
CREATE TABLE "tbl_statistics" (
	"statistic_ulid" TEXT(26) NOT NULL PRIMARY KEY,
    "game_ulid_ref" TEXT(26),
    "leaderboard_ulid_ref" TEXT(26),
	"timestamp_dt" DATETIME NOT NULL,
    "interval_days" INTEGER,
    "playerbase_size" INTEGER,
    -- TODO: Check how the values of different intervals fit in here
    -- TODO: Talk to Coolio on Discord
    -- - interesting might be to make more obvious how many new multiplayers players are there (metric like first game on any leaderboard)
    --   - we could even chose top5 (activity, rating) from them and make them queryable, to be e.g. greeted on community resources
    --     - something like "We welcome @<username> as a new multiplayer to our community!"
    --   - also how many people left the game (metric might be how many _new_ people haven't played the game in 1/1,5/2/3 months)
	CONSTRAINT "statistics_game_ulid_ref_fkey" FOREIGN KEY ("game_ulid_ref") REFERENCES "tbl_games" ("game_ulid"),
	CONSTRAINT "statistics_leaderboard_ulid_ref_fkey" FOREIGN KEY ("leaderboard_ulid_ref") REFERENCES "tbl_leaderboards" ("leaderboard_ulid")
);

CREATE INDEX "statistics_timestamp_dt_IDX" ON "tbl_statistics" ("timestamp_dt");
CREATE INDEX "statistics_game_ulid_ref_IDX" ON "tbl_statistics" ("game_ulid_ref");
CREATE INDEX "statistics_leaderboard_ulid_ref_IDX" ON "tbl_statistics" ("leaderboard_ulid_ref");

-- migrate:down
DROP TABLE "tbl_statistics";