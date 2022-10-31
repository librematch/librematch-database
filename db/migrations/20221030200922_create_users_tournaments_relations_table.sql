-- migrate:up
CREATE TABLE "tbl_users_tournaments_relations" (
	"user_ulid_ref" TEXT(26) NOT NULL,
	"tournament_ulid_ref" TEXT(36) NOT NULL,
	"scope_ulid_ref" TEXT(26) NOT NULL,
	FOREIGN KEY ("scope_ulid_ref") REFERENCES "tbl_scopes" ("scope_ulid") ON UPDATE CASCADE,
    FOREIGN KEY ("user_ulid_ref") REFERENCES "tbl_users" ("user_ulid") ON UPDATE CASCADE,
    FOREIGN KEY ("tournament_ulid_ref") REFERENCES "tbl_tournaments" ("tournament_ulid") ON UPDATE CASCADE,
	PRIMARY KEY ("user_ulid_ref","tournament_ulid_ref", "scope_ulid_ref")
);

-- migrate:down
DROP TABLE "tbl_users_tournaments_relations";
