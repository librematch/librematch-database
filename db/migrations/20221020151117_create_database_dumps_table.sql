-- migrate:up
CREATE TABLE "tbl_database_dumps" (
	"database_dump_ulid" TEXT(26) NOT NULL PRIMARY KEY,
    "game_ulid_ref" TEXT(26) NOT NULL, -- database dumps contain always all leaderboards of a game
	"query_executed" TEXT NOT NULL,
	"timestamp_dt" DATETIME NOT NULL,
	-- "type" INTEGER NOT NULL, -- TODO: do we want to categorize DB dumps? 
	"uploaded_at_dt" DATETIME NOT NULL,
	"size" INTEGER NOT NULL,
	"item_count" INTEGER NOT NULL, -- overall rows contained
	"storage_url" TEXT NOT NULL,
    FOREIGN KEY ("game_ulid_ref") REFERENCES "tbl_games" ("game_ulid")
);

CREATE INDEX "database_dumps_timestamp_dt_IDX" ON "tbl_database_dumps" ("timestamp_dt");
CREATE INDEX "database_dumps_uploaded_at_dt_IDX" ON "tbl_database_dumps" ("uploaded_at_dt");

-- migrate:down
DROP TABLE "tbl_database_dumps";
