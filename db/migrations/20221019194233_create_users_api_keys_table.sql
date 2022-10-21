-- migrate:up
CREATE TABLE "users_api_keys_relations" (
	"id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	"users_ulid_ref" TEXT(26) NOT NULL,
	"api_key_ref" TEXT(36) NOT NULL,
    FOREIGN KEY ("users_ulid_ref") REFERENCES users ("ulid"),
    FOREIGN KEY ("api_key_ref") REFERENCES api_keys ("api_key")
);

CREATE UNIQUE INDEX "users_api_keys_relations_users_ulid_IDX" ON "users_api_keys_relations" ("users_ulid_ref","api_key_ref");

-- migrate:down
drop table "users_api_keys_relations";
