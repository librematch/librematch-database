-- migrate:up
CREATE TABLE "tbl_database_dumps" (
	"database_dump_ulid" TEXT(26) NOT NULL PRIMARY KEY,
    "game_ulid_ref" TEXT(26) NOT NULL, -- database dumps contain always all leaderboards of a game
	"query_executed" TEXT NOT NULL,
	"datetime_created_at" DATETIME NOT NULL,
	"datetime_uploaded_at" DATETIME NOT NULL,
	"size" INTEGER NOT NULL,
	"item_count" INTEGER NOT NULL, -- overall rows contained
	"url_storage" TEXT NOT NULL,
	-- "type" INTEGER NOT NULL, -- TODO: do we want to categorize DB dumps? 
    FOREIGN KEY ("game_ulid_ref") REFERENCES "tbl_games" ("game_ulid")
);

CREATE INDEX "database_dumps_datetime_created_at_IDX" ON "tbl_database_dumps" ("datetime_created_at");
CREATE INDEX "database_dumps_datetime_uploaded_at_IDX" ON "tbl_database_dumps" ("datetime_uploaded_at");

-- migrate:down
DROP TABLE "tbl_database_dumps";
