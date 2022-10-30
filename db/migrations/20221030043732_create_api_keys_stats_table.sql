-- migrate:up
CREATE TABLE "tbl_api_keys_statistics" (
	"api_key_stat_ulid" TEXT(26) PRIMARY KEY NOT NULL,
	"auth_req_last_24h" INTEGER,
	"auth_req_last_12h" INTEGER,
	"auth_req_last_6h" INTEGER,
	"auth_req_last_1h" INTEGER,
	"auth_req_last_30min" INTEGER,
	"auth_req_last_1min" INTEGER,
	"datetime_dt" DATETIME NOT NULL
);
CREATE INDEX "api_keys_stats_datetime_dt_IDX" ON "tbl_api_keys_statistics" ("datetime_dt");

-- migrate:down
DROP TABLE "tbl_api_keys_statistics";