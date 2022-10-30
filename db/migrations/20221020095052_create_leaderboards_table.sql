-- migrate:up
CREATE TABLE "tbl_leaderboards" (
    "leaderboard_ulid" TEXT(26) PRIMARY KEY NOT NULL,
    "relic_link_leaderboard_id" INTEGER NOT NULL, -- original id from Relic Link API
    "game_ulid_ref" TEXT(26) NOT NULL, -- each leaderboard can only exist in one game
    "description" TEXT(50) NOT NULL,
    CONSTRAINT "leaderboards_game_ulid_ref_fkey" FOREIGN KEY ("game_ulid_ref") REFERENCES "tbl_games" ("game_ulid"),
    UNIQUE ("leaderboard_ulid", "game_ulid_ref")
);

-- migrate:down
DROP TABLE "tbl_leaderboards";
