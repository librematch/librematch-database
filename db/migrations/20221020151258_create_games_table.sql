-- migrate:up
CREATE TABLE "tbl_games" (
    "game_ulid" TEXT(26) PRIMARY KEY NOT NULL,
	"name_short" TEXT(8) NOT NULL UNIQUE,
	"name_long" TEXT(255) NOT NULL,
	"datetime_release" DATETIME NULL,
	"url_steam" TEXT NULL,
	"url_microsoft" TEXT NULL,
	"url_icon" TEXT NULL
);

-- migrate:down
DROP TABLE "tbl_games";
