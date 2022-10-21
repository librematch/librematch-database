-- migrate:up
CREATE TABLE "teams" (
	"ulid" TEXT(26) NOT NULL PRIMARY KEY,
	"name" TEXT(255) NOT NULL,
	"is_archived" BOOLEAN DEFAULT FALSE NOT NULL,
	"in_game_tag" TEXT(15),
	"liquipedia_id" TEXT,
	"discord_invite" TEXT,
	"twitch_id" TEXT,
	"twitter_id" TEXT,
	"youtube_url" TEXT,
	"fbgaming_id" TEXT
);

CREATE INDEX "teams_is_archived_IDX" ON "teams" ("is_archived"); -- old entries


-- migrate:down
drop table "teams";
