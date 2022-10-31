-- migrate:up
CREATE TABLE "tbl_api_keys_statistics" (
	"api_key_stat_ulid" TEXT(26) PRIMARY KEY NOT NULL,
	"key" TEXT CHECK( "key" IN ('req_last_24h', 'req_last_12h', 'req_last_6h', 'last_1h', 'last_30min', 'last_1min') ) NOT NULL DEFAULT 'last_1h',
	"value" INTEGER NOT NULL,
	UNIQUE ("key", "value")
);

-- migrate:down
DROP TABLE "tbl_api_keys_statistics";