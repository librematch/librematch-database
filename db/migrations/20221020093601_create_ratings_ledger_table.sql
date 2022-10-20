-- migrate:up
CREATE TABLE "ratings_ledger" (
    "ulid" TEXT(26) NOT NULL,
    "profiles_ulid_ref" TEXT(26) NOT NULL,
    "leaderboards_ulid_ref" TEXT(26) NOT NULL,
    "match_players_ulid_ref" TEXT(26) NOT NULL,
    "datetime" DATETIME NOT NULL,
    "rating_diff" INTEGER,
    "overall_matches" INTEGER NOT NULL,
    "drops" INTEGER,
    "current_rank" INTEGER,
    "highest_rank" INTEGER,
    "lowest_rank" INTEGER,
    "rank_country" INTEGER,
    "current_rating" INTEGER NOT NULL,
    "highest_rating" INTEGER NOT NULL,
    "lowest_rating" INTEGER NOT NULL,
    "losses" INTEGER,
    "current_streak" INTEGER,
    "highest_streak" INTEGER,
    "lowest_streak" INTEGER,
    "wins" INTEGER,
    "last_match_time" DATETIME,
    "updated_at" DATETIME NOT NULL,
    PRIMARY KEY ("ulid", "profiles_ulid_ref", "leaderboards_ulid_ref", "match_players_ulid_ref"),
    CONSTRAINT "ratings_ledger_profiles_ulid_ref_fkey" FOREIGN KEY ("profiles_ulid_ref") REFERENCES "profiles" ("ulid") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "ratings_ledger_leaderboards_ulid_ref_fkey" FOREIGN KEY ("leaderboards_ulid_ref") REFERENCES "leaderboards" ("ulid") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "ratings_ledger_match_players_ulid_ref_fkey" FOREIGN KEY ("match_players_ulid_ref") REFERENCES "match_players" ("ulid") ON DELETE SET NULL ON UPDATE CASCADE
);

-- migrate:down
drop table "ratings_ledger";
