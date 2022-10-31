-- migrate:up
CREATE TABLE IF NOT EXISTS "tbl_maps_leaderboards_relations" (
	"leaderboard_ulid_ref" TEXT(26) NOT NULL,
	"map_ulid_ref" TEXT(26) NOT NULL,
    FOREIGN KEY ("leaderboard_ulid_ref") REFERENCES "tbl_leaderboards" ("leaderboard_ulid") ON UPDATE CASCADE,
    FOREIGN KEY ("map_ulid_ref") REFERENCES "tbl_maps" ("map_ulid") ON UPDATE CASCADE,
	PRIMARY KEY ("leaderboard_ulid_ref", "map_ulid_ref")
);

-- migrate:down
DROP TABLE "tbl_maps_leaderboards_relations";