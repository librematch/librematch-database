-- migrate:up
CREATE TABLE "tbl_api_keys" (
	"api_key_ulid" TEXT(26) PRIMARY KEY NOT NULL,
	"api_key" TEXT(36) NOT NULL UNIQUE,
	"valid_until_dt" DATETIME NOT NULL
);

-- migrate:down
DROP TABLE "tbl_api_keys";
