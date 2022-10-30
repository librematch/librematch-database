-- migrate:up
CREATE TABLE "tbl_teams" (
	"team_ulid" TEXT(26) NOT NULL PRIMARY KEY,
	"name" TEXT(255) NOT NULL,
	"is_archived" BOOLEAN DEFAULT FALSE NOT NULL,
	"in_game_tag" TEXT(15) NULL,
	"liquipedia_id" TEXT(50) NULL,
	"discord_invite" TEXT(50) NULL,
	"twitch_id" TEXT(50) NULL,
	"twitter_id" TEXT(50) NULL,
	"youtube_url" TEXT(50) NULL,
	"fbgaming_id" TEXT(50) NULL
);

CREATE INDEX "teams_is_archived_IDX" ON "tbl_teams" ("is_archived"); -- old entries


-- migrate:down
DROP TABLE "tbl_teams";
