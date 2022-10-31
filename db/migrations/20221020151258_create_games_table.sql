-- migrate:up
CREATE TABLE "tbl_games" (
    "game_ulid" TEXT(26) PRIMARY KEY NOT NULL,
	"name_short" TEXT(8) NOT NULL UNIQUE,
	"name_long" TEXT(255) NOT NULL,
	"datetime_release" DATETIME,
	"url_steam" TEXT,
	"url_microsoft" TEXT,
	"url_icon" TEXT
);

-- migrate:down
DROP TABLE "tbl_games";
