-- migrate:up
CREATE TABLE IF NOT EXISTS "tbl_maps" (
	"map_ulid" TEXT(26) PRIMARY KEY NOT NULL,
    "relic_link_map_id" INTEGER NOT NULL,
	"name" TEXT(50) NOT NULL,
    "name_file" TEXT(255) NOT NULL UNIQUE,
    "url_icon" TEXT NULL
);

-- migrate:down
DROP TABLE "tbl_maps";