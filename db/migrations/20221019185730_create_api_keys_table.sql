-- migrate:up
CREATE TABLE "tbl_api_keys" (
	"api_key_ulid" TEXT(26) PRIMARY KEY NOT NULL,
	"api_key" TEXT(36) NOT NULL UNIQUE,
	"datetime_valid_until" DATETIME NOT NULL
);

CREATE INDEX "api_keys_datetime_valid_until_IDX" ON "tbl_api_keys" ("datetime_valid_until");

-- migrate:down
DROP TABLE "tbl_api_keys";
