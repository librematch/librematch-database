-- migrate:up
CREATE TABLE "profiles_relations" (
	"id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	"main_profiles_ulid_ref" TEXT(26) NOT NULL,
	"secondary_profiles_ulid_ref" TEXT(26) NOT NULL,
	"comments" TEXT(255),
    FOREIGN KEY ("main_profiles_ulid_ref") REFERENCES profiles ("ulid"),
    FOREIGN KEY ("secondary_profiles_ulid_ref") REFERENCES profiles ("ulid")
);

CREATE UNIQUE INDEX profiles_relations_IDX ON "profiles_relations" ("main_profiles_ulid_ref","secondary_profiles_ulid_ref");


-- migrate:down
drop table "profiles_relations";
