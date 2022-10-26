-- migrate:up
CREATE TABLE "games" (
    "ulid" TEXT(26) NOT NULL,
	"short_name" TEXT(8) NOT NULL,
	"long_name" TEXT(255) NOT NULL,
	"release_date" DATETIME,
	"steam_url" TEXT,
	"microsoft_url" TEXT,
    PRIMARY KEY ("ulid")
);

CREATE UNIQUE INDEX "games_short_name_IDX" ON "games" ("short_name");


-- migrate:down
drop table "games";
