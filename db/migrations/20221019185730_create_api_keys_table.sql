-- migrate:up
CREATE TABLE "tbl_api_keys" (
	"api_key_ulid" TEXT(26) PRIMARY KEY NOT NULL,
	"api_key" TEXT(36) NOT NULL,
	"valid_until_dt" DATETIME NOT NULL,
	"has_admin_scope" BOOLEAN DEFAULT FALSE NOT NULL,
	"has_user_scope" BOOLEAN DEFAULT TRUE NOT NULL,
	"has_tournament_admin_scope" BOOLEAN DEFAULT FALSE NOT NULL
);

CREATE UNIQUE INDEX "api_keys_api_key_IDX" ON "tbl_api_keys" ("api_key");

-- migrate:down
drop table "tbl_api_keys";
