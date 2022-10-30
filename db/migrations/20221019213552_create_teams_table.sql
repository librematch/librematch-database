-- migrate:up
CREATE TABLE "tbl_teams" (
	"team_ulid" TEXT(26) NOT NULL PRIMARY KEY,
	"name" TEXT(255) NOT NULL,
	"in_game_tag" TEXT(15) NULL,
	"is_inactive" BOOLEAN DEFAULT FALSE NOT NULL,
	"liquipedia_id" TEXT(50) NULL,
	"discord_invite" TEXT(50) NULL,
	"twitch_id" TEXT(50) NULL,
	"twitter_id" TEXT(50) NULL,
	"youtube_url" TEXT(50) NULL,
	"fbgaming_id" TEXT(50) NULL
);

CREATE INDEX "teams_is_inactive_IDX" ON "tbl_teams" ("is_inactive"); -- inactive teams

-- migrate:down
DROP TABLE "tbl_teams";
