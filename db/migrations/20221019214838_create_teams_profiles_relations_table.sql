-- migrate:up
CREATE TABLE "teams_profiles_relations" (
	"id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	"teams_ulid_ref" TEXT(26) NOT NULL,
	"profiles_ulid_ref" TEXT(26) NOT NULL,
    FOREIGN KEY ("teams_ulid_ref") REFERENCES teams ("ulid"),
    FOREIGN KEY ("profiles_ulid_ref") REFERENCES profiles ("ulid")
);

CREATE UNIQUE INDEX teams_profiles_relations_IDX ON teams_profiles_relations ("teams_ulid_ref", "profiles_ulid_ref");

-- migrate:down
drop table "teams_profiles_relations";
