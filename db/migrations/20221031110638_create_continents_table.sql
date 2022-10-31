-- migrate:up
CREATE TABLE IF NOT EXISTS "tbl_continents" (
	"continent_ulid" TEXT(26) PRIMARY KEY NOT NULL,
    "relic_link_continent_id" INTEGER NOT NULL,
	"name" TEXT(25) NOT NULL
);

-- migrate:down
DROP TABLE "tbl_continents";