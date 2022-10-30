-- migrate:up
CREATE TABLE "tbl_ratings_ledger" (
    "ratings_ledger_entry_ulid" TEXT(26) PRIMARY KEY NOT NULL,
    "profile_ulid_ref" TEXT(26) NOT NULL,
    "leaderboard_ulid_ref" TEXT(26) NOT NULL,
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
    CONSTRAINT "ratings_ledger_profile_ulid_ref_fkey" FOREIGN KEY ("profile_ulid_ref") REFERENCES "tbl_profiles" ("profile_ulid") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "ratings_ledger_leaderboard_ulid_ref_fkey" FOREIGN KEY ("leaderboard_ulid_ref") REFERENCES "tbl_leaderboards" ("leaderboard_ulid") ON DELETE SET NULL ON UPDATE CASCADE
);

-- migrate:down
drop table "tbl_ratings_ledger";
