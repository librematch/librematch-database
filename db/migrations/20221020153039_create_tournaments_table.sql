-- migrate:up
CREATE TABLE "tbl_tournaments" (
    "tournament_ulid" TEXT(26) NOT NULL PRIMARY KEY,
    "name_long" TEXT(50) NOT NULL,
    "name_short" TEXT(10),
    "url_liquipedia" TEXT NULL,
    "liquipedia_tier" SMALLINT NULL,
    "datetime_start" DATETIME NULL,
    "datetime_end" DATETIME NULL,
    "prizepool" FLOAT NULL,
    "player_amount" INTEGER NULL,
    "location" TEXT NULL
    -- TODO: Add more table columns
);

-- migrate:down
DROP TABLE "tbl_tournaments";
