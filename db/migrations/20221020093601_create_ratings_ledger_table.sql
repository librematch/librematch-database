-- migrate:up
CREATE TABLE IF NOT EXISTS "tbl_ratings_ledger" (
    "profile_ulid_ref" TEXT(26) NOT NULL,
    "leaderboard_ulid_ref" TEXT(26) NOT NULL,
    "rating_diff" INTEGER NULL,
    "overall_matches" INTEGER NOT NULL,
    "drops" INTEGER DEFAULT 0 NOT NULL,
    "current_rank" INTEGER NOT NULL,
    "highest_rank" INTEGER NOT NULL,
    "lowest_rank" INTEGER NOT NULL,
    "rank_country" INTEGER NOT NULL,
    "current_rating" INTEGER NOT NULL,
    "highest_rating" INTEGER NOT NULL,
    "lowest_rating" INTEGER NOT NULL,
    "losses" INTEGER DEFAULT 0 NOT NULL,
    "current_streak" INTEGER DEFAULT 0 NOT NULL,
    "highest_streak" INTEGER DEFAULT 0 NOT NULL,
    "lowest_streak" INTEGER DEFAULT 0 NOT NULL,
    "wins" INTEGER DEFAULT 0 NOT NULL,
    "datetime_rating_achieved" DATETIME NOT NULL,
    "datetime_updated_at" DATETIME NOT NULL,
    "datetime_last_match" DATETIME NULL,
    "is_archived" BOOLEAN DEFAULT FALSE NOT NULL,
    FOREIGN KEY ("profile_ulid_ref") REFERENCES "tbl_profiles" ("profile_ulid") ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY ("leaderboard_ulid_ref") REFERENCES "tbl_leaderboards" ("leaderboard_ulid") ON DELETE SET NULL ON UPDATE CASCADE,
    PRIMARY KEY ("profile_ulid_ref", "leaderboard_ulid_ref", "datetime_rating_achieved")
);

CREATE INDEX "ratings_ledger_is_archived_IDX" ON "tbl_ratings_ledger" ("is_archived");

-- migrate:down
DROP TABLE "tbl_ratings_ledger";
