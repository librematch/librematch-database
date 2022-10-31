-- migrate:up
CREATE TABLE "tbl_users_api_keys_relations" (
	"user_ulid_ref" TEXT(26) NOT NULL,
	"api_key_ulid_ref" TEXT(36) NOT NULL,
	"scope_ulid_ref" TEXT(26) NOT NULL,
	FOREIGN KEY ("scope_ulid_ref") REFERENCES "tbl_scopes" ("scope_ulid") ON UPDATE CASCADE,
    FOREIGN KEY ("user_ulid_ref") REFERENCES "tbl_users" ("user_ulid") ON UPDATE CASCADE,
    FOREIGN KEY ("api_key_ulid_ref") REFERENCES "tbl_api_keys" ("api_key_ulid") ON UPDATE CASCADE,
	PRIMARY KEY ("user_ulid_ref","api_key_ulid_ref", "scope_ulid_ref")
);

-- migrate:down
DROP TABLE "tbl_users_api_keys_relations";
