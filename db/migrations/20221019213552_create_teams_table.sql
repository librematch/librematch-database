-- migrate:up
CREATE TABLE IF NOT EXISTS "tbl_teams" (
	"team_ulid" TEXT(26) NOT NULL PRIMARY KEY,
	"name_long" TEXT(255) NOT NULL,
	"name_short" TEXT(15) NULL,
	"is_active" BOOLEAN DEFAULT TRUE NOT NULL,
	"liquipedia_id" TEXT(50) NULL,
	"discord_invite" TEXT(50) NULL,
	"twitch_id" TEXT(50) NULL,
	"twitter_id" TEXT(50) NULL,
	"url_youtube" TEXT(50) NULL,
	"fbgaming_id" TEXT(50) NULL
);

CREATE INDEX "teams_is_active_IDX" ON "tbl_teams" ("is_active"); -- active teams

-- migrate:down
DROP TABLE "tbl_teams";
