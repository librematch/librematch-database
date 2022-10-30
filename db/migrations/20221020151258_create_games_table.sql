-- migrate:up
CREATE TABLE "tbl_games" (
    "game_ulid" TEXT(26) PRIMARY KEY NOT NULL,
	"short_name" TEXT(8) NOT NULL,
	"long_name" TEXT(255) NOT NULL,
	"release_date" DATETIME,
	"steam_url" TEXT,
	"microsoft_url" TEXT
);

CREATE UNIQUE INDEX "games_short_name_IDX" ON "tbl_games" ("short_name");


-- migrate:down
DROP TABLE "tbl_games";
