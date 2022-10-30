-- migrate:up
CREATE TABLE "tbl_games" (
    "game_ulid" TEXT(26) PRIMARY KEY NOT NULL,
	"short_name" TEXT(8) NOT NULL UNIQUE,
	"long_name" TEXT(255) NOT NULL,
	"release_date" DATETIME,
	"steam_url" TEXT,
	"microsoft_url" TEXT,
	"icon_url" TEXT
);

-- migrate:down
DROP TABLE "tbl_games";
