-- migrate:up
CREATE TABLE "tbl_matches_match_settings_relations" (
	"match_ulid_ref" TEXT(26) NOT NULL,
	"match_setting_ulid_ref" TEXT(26) NOT NULL,
    "type_of_value" TEXT CHECK( "type_of_value" IN ('text', 'boolean', 'smallint', 'integer', 'numeric', 'datetime') ) NOT NULL DEFAULT 'boolean', 
	FOREIGN KEY ("match_ulid_ref") REFERENCES "tbl_matches" ("match_ulid") ON UPDATE CASCADE,
	FOREIGN KEY ("match_setting_ulid_ref") REFERENCES "tbl_match_settings" ("match_setting_ulid") ON UPDATE CASCADE,
	PRIMARY KEY ("match_ulid_ref","match_setting_ulid_ref", "type_of_value")
);

-- migrate:down
DROP TABLE "tbl_matches_match_settings_relations";
