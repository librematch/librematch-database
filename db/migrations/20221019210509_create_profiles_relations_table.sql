-- migrate:up
CREATE TABLE "tbl_profiles_relations" (
	"profile_relation_ulid" TEXT(26) PRIMARY KEY NOT NULL,
	"main_profile_ulid_ref" TEXT(26) NOT NULL,
	"secondary_profile_ulid_ref" TEXT(26) NOT NULL,
	"description" TEXT(255) NULL,
    FOREIGN KEY ("main_profile_ulid_ref") REFERENCES "tbl_profiles" ("profile_ulid"),
    FOREIGN KEY ("secondary_profile_ulid_ref") REFERENCES "tbl_profiles" ("profile_ulid")
);

CREATE UNIQUE INDEX "profiles_relations_IDX" ON "tbl_profiles_relations" ("main_profile_ulid_ref","secondary_profile_ulid_ref");

-- migrate:down
drop table "tbl_profiles_relations";
