-- migrate:up
CREATE TABLE "games" (
    "ulid" TEXT(26) NOT NULL,
	"short_name" TEXT(8) NOT NULL,
	"long_name" TEXT(255) NOT NULL,
	"release_date" DATETIME NOT NULL,
	"steam_url" TEXT NOT NULL,
	"microsoft_url" TEXT NOT NULL,
    PRIMARY KEY ("ulid", "short_name")
);

-- migrate:down
drop table "games";
