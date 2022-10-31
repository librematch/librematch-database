-- migrate:up
CREATE TABLE IF NOT EXISTS "tbl_dlcs" (
	"dlc_ulid" TEXT(26) PRIMARY KEY NOT NULL,
	"game_ulid_ref" TEXT(26) NULL,
	"name_short" TEXT(15) NOT NULL UNIQUE,
	"name_long" TEXT(100) NULL,
	"description" TEXT(255) NULL,
    "datetime_release" DATETIME NULL,
    "url_steam" TEXT NULL,
    "url_microsoft_store" TEXT NULL,
    "url_icon" TEXT NULL,
	FOREIGN KEY ("game_ulid_ref") REFERENCES "tbl_games" ("game_ulid")
);

-- migrate:down
DROP TABLE "tbl_dlcs";