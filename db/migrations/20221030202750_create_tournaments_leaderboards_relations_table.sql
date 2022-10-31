-- migrate:up
CREATE TABLE "tbl_tournaments_leaderboards_relations" (
	"tournament_ulid_ref" TEXT(36) NOT NULL,
	"leaderboard_ulid_ref" TEXT(26) NOT NULL,
    "url_bracket" TEXT NULL,
    FOREIGN KEY ("leaderboard_ulid_ref") REFERENCES "tbl_leaderboards" ("leaderboard_ulid") ON UPDATE CASCADE,
    FOREIGN KEY ("tournament_ulid_ref") REFERENCES "tbl_tournaments" ("tournament_ulid") ON UPDATE CASCADE,
	PRIMARY KEY ("tournament_ulid_ref", "leaderboard_ulid_ref")
);

-- migrate:down
DROP TABLE "tbl_tournaments_leaderboards_relations";
