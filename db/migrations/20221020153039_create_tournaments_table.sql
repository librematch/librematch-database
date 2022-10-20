-- migrate:up
CREATE TABLE "tournaments" (
    "ulid" TEXT(26) NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "short" TEXT(10),
    "liquipedia_url" TEXT,
    "liquipedia_tier" SMALLINT,
    "start_dt" DATETIME,
    "end_dt" DATETIME,
    "prizepool" FLOAT,
    "player_amount" INTEGER,
    "location" TEXT
    -- TODO: Add more table columns
);

-- migrate:down
drop table "tournaments";
