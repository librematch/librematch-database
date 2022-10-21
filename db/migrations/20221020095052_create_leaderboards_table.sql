-- migrate:up
CREATE TABLE "leaderboards" (
    "ulid" TEXT(26) NOT NULL,
    "leaderboard_id" INTEGER NOT NULL, -- original id from Relic Link API
    "game_ulid_ref" TEXT(26) NOT NULL, -- each leaderboard can only exist in one game
    "name" TEXT NOT NULL,
    PRIMARY KEY ("ulid", "game_ulid_ref"),
    CONSTRAINT "leaderboards_game_ulid_ref_fkey" FOREIGN KEY ("game_ulid_ref") REFERENCES "games" ("ulid")
);

-- migrate:down
drop table "leaderboards";
