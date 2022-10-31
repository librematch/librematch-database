-- migrate:up
CREATE TABLE "tbl_api_keys_statistics_relations" (
	"api_key_ulid_ref" TEXT(26) NOT NULL,
	"api_key_statistic_ulid_ref" TEXT(26) NOT NULL,
	"datetime_dt" DATETIME NOT NULL,
	FOREIGN KEY ("api_key_ulid_ref") REFERENCES "tbl_api_keys" ("api_key_ulid") ON UPDATE CASCADE,
	FOREIGN KEY ("api_key_statistic_ulid_ref") REFERENCES "tbl_api_keys_statistics" ("api_key_stat_ulid") ON UPDATE CASCADE,
	PRIMARY KEY ("api_key_ulid_ref","api_key_statistic_ulid_ref", "datetime_dt")
);

-- migrate:down
DROP TABLE "tbl_api_keys_statistics_relations";