-- migrate:up
CREATE TABLE "database_dumps" (
	"ulid" TEXT(26) NOT NULL PRIMARY KEY,
    "game_ulid_ref" TEXT(26) NOT NULL, -- database dumps contain always all leaderboards of a game
	"timestamp_dt" DATETIME NOT NULL,
	-- "type" INTEGER NOT NULL, -- TODO: do we want to categorize DB dumps? 
	"uploaded_at_dt" DATETIME NOT NULL,
	"size" INTEGER NOT NULL,
	"item_count" INTEGER NOT NULL, -- overall rows contained
	"storage_url" TEXT NOT NULL,
    CONSTRAINT "database_dumps_game_ulid_ref_fkey" FOREIGN KEY ("game_ulid_ref") REFERENCES "games" ("ulid")
);

CREATE INDEX "database_dumps_timestamp_dt_IDX" ON "database_dumps" ("timestamp_dt");
CREATE INDEX "database_dumps_uploaded_at_dt_IDX" ON "database_dumps" ("uploaded_at_dt");

-- migrate:down
drop table "database_dumps";
