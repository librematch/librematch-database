-- migrate:up
CREATE TABLE "tbl_users_api_keys_relations" (
	"user_api_key_relation_id" TEXT(26) PRIMARY KEY NOT NULL,
	"user_ulid_ref" TEXT(26) NOT NULL,
	"api_key_ulid_ref" TEXT(36) NOT NULL,
    FOREIGN KEY ("user_ulid_ref") REFERENCES "tbl_users" ("user_ulid"),
    FOREIGN KEY ("api_key_ulid_ref") REFERENCES "tbl_api_keys" ("api_key_ulid")
);

CREATE UNIQUE INDEX "users_api_keys_relations_users_ulid_IDX" ON "tbl_users_api_keys_relations" ("user_ulid_ref","api_key_ulid_ref");

-- migrate:down
DROP TABLE "tbl_users_api_keys_relations";
