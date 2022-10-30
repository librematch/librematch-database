-- migrate:up
CREATE TABLE "tbl_api_keys_statistics_relations" (
	"api_key_ulid_ref" TEXT(26) NOT NULL,
	"api_key_statistic_ulid_ref" TEXT(26) NOT NULL,
	CONSTRAINT "api_keys_stats_api_key_ulid_ref_FK" FOREIGN KEY ("api_key_ulid_ref") REFERENCES "tbl_api_keys" ("api_key_ulid") ON UPDATE CASCADE,
	CONSTRAINT "api_keys_stats_api_key_statistic_ulid_ref_FK" FOREIGN KEY ("api_key_statistic_ulid_ref") REFERENCES "tbl_api_keys_statistics" ("api_key_stat_ulid") ON UPDATE CASCADE,
	UNIQUE ("api_key_ulid_ref","api_key_statistic_ulid_ref")
);

-- migrate:down
DROP TABLE "tbl_api_keys_statistics_relations";
