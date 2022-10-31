-- migrate:up
CREATE TABLE IF NOT EXISTS "tbl_leaderboards" (
    "leaderboard_ulid" TEXT(26) PRIMARY KEY NOT NULL,
    "relic_link_leaderboard_id" INTEGER NULL, -- original id from Relic Link API, can be NULL because tournaments and other also have leaderboards
    "game_ulid_ref" TEXT(26) NOT NULL, -- each leaderboard can only exist in one game
    "description" TEXT(50) NOT NULL,
    FOREIGN KEY ("game_ulid_ref") REFERENCES "tbl_games" ("game_ulid"),
    UNIQUE ("leaderboard_ulid", "game_ulid_ref")
);

-- migrate:down
DROP TABLE "tbl_leaderboards";
