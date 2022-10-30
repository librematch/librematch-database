-- migrate:up
CREATE TABLE "tbl_users_scopes_relations" (
	"user_ulid_ref" TEXT(26) NOT NULL,
	"scope_ulid_ref" TEXT(26) NOT NULL,
	CONSTRAINT "users_scopes_relations_user_ulid_ref_FK" FOREIGN KEY ("user_ulid_ref") REFERENCES "tbl_users" ("user_ulid") ON UPDATE CASCADE,
	CONSTRAINT "users_scopes_relations_scope_ulid_ref_FK" FOREIGN KEY ("scope_ulid_ref") REFERENCES "tbl_scopes" ("scope_ulid") ON UPDATE CASCADE,
	UNIQUE ("user_ulid_ref","scope_ulid_ref")
);

-- migrate:down
DROP TABLE "tbl_users_scopes_relations";
