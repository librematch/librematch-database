-- migrate:up
CREATE TABLE IF NOT EXISTS "tbl_civilisations" (
	"civilisation_ulid" TEXT(26) PRIMARY KEY NOT NULL,
    "relic_link_civilisation_id" INTEGER NOT NULL,
    "is_base_civilisation" BOOLEAN DEFAULT TRUE NOT NULL, 
    "game_ulid_ref" TEXT(26) NULL,
    "dlc_ulid_ref" TEXT(26) NULL,
	"name_short" TEXT(5) NOT NULL,
	"name_long" TEXT(50) NOT NULL,
    "url_icon" TEXT NULL,
	FOREIGN KEY ("game_ulid_ref") REFERENCES "tbl_games" ("game_ulid"),
	FOREIGN KEY ("dlc_ulid_ref") REFERENCES "tbl_dlcs" ("dlc_ulid"),
    CONSTRAINT "check_at_least_one_game_or_dlc_is_not_null" CHECK (("game_ulid_ref" IS NOT NULL AND "is_base_civilisation" IS TRUE) OR ("dlc_ulid_ref" IS NOT NULL AND "is_base_civilisation" IS FALSE))
);

-- migrate:down
DROP TABLE "tbl_civilisations";