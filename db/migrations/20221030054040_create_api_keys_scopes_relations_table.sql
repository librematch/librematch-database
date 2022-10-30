-- migrate:up
CREATE TABLE "tbl_api_keys_scopes_relations" (
	"api_key_ulid_ref" TEXT(26) NOT NULL,
	"scope_ulid_ref" TEXT(26) NOT NULL,
	CONSTRAINT "api_keys_scopes_relations_api_key_ulid_ref_FK" FOREIGN KEY ("api_key_ulid_ref") REFERENCES "tbl_api_keys" ("api_key_ulid") ON UPDATE CASCADE,
	CONSTRAINT "api_keys_scopes_relations_scope_ulid_ref_FK" FOREIGN KEY ("scope_ulid_ref") REFERENCES "tbl_scopes" ("scope_ulid") ON UPDATE CASCADE,
	UNIQUE ("api_key_ulid_ref","scope_ulid_ref")
);

-- migrate:down
DROP TABLE "tbl_api_keys_scopes_relations";
