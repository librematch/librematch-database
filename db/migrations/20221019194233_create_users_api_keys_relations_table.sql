-- migrate:up
CREATE TABLE "tbl_users_api_keys_relations" (
	"user_ulid_ref" TEXT(26) NOT NULL,
	"api_key_ulid_ref" TEXT(36) NOT NULL,
    FOREIGN KEY ("user_ulid_ref") REFERENCES "tbl_users" ("user_ulid"),
    FOREIGN KEY ("api_key_ulid_ref") REFERENCES "tbl_api_keys" ("api_key_ulid"),
	UNIQUE ("user_ulid_ref","api_key_ulid_ref")
);

-- migrate:down
DROP TABLE "tbl_users_api_keys_relations";
