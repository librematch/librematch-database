-- migrate:up
CREATE TABLE "tbl_tournaments" (
    "tounament_ulid" TEXT(26) NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "short" TEXT(10),
    "liquipedia_url" TEXT NULL,
    "liquipedia_tier" SMALLINT NULL,
    "start_dt" DATETIME NULL,
    "end_dt" DATETIME NULL,
    "prizepool" FLOAT NULL,
    "player_amount" INTEGER NULL,
    "location" TEXT NULL
    -- TODO: Add more table columns
);

-- migrate:down
drop table "tbl_tournaments";
