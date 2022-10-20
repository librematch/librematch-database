-- migrate:up
CREATE TABLE "api_keys" (
	"api_key" TEXT(36) NOT NULL PRIMARY KEY,
	"valid_until_dt" DATETIME NOT NULL
);

-- migrate:down
drop table "api_keys";
