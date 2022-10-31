-- migrate:up
CREATE TABLE IF NOT EXISTS "tbl_api_keys_statistics" (
	"api_key_stat_ulid" TEXT(26) PRIMARY KEY NOT NULL,
	"key" TEXT CHECK( "key" IN ('req_last_24h', 'req_last_12h', 'req_last_6h', 'req_last_1h', 'req_last_30min', 'req_last_1min') ) DEFAULT 'req_last_1h' NOT NULL,
	"value" INTEGER NOT NULL,
	UNIQUE ("key", "value")
);

-- migrate:down
DROP TABLE "tbl_api_keys_statistics";