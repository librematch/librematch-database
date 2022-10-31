-- migrate:up
CREATE TABLE "tbl_ratings_ledger" (
    "profile_ulid_ref" TEXT(26) NOT NULL,
    "leaderboard_ulid_ref" TEXT(26) NOT NULL,
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
    "datetime_rating_achieved" DATETIME NOT NULL,
    "datetime_updated_at" DATETIME NOT NULL,
    "datetime_last_match" DATETIME,
    "is_archived" BOOLEAN DEFAULT FALSE NOT NULL,
    FOREIGN KEY ("profile_ulid_ref") REFERENCES "tbl_profiles" ("profile_ulid") ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY ("leaderboard_ulid_ref") REFERENCES "tbl_leaderboards" ("leaderboard_ulid") ON DELETE SET NULL ON UPDATE CASCADE,
    PRIMARY KEY ("profile_ulid_ref", "leaderboard_ulid_ref", "datetime_rating_achieved")
);

CREATE INDEX "ratings_ledger_is_archived_IDX" ON "tbl_ratings_ledger" ("is_archived");

-- migrate:down
DROP TABLE "tbl_ratings_ledger";
