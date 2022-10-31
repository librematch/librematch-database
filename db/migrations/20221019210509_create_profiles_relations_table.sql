-- migrate:up
CREATE TABLE IF NOT EXISTS "tbl_profiles_relations" (
	"main_profile_ulid_ref" TEXT(26) NOT NULL,
	"secondary_profile_ulid_ref" TEXT(26) NOT NULL,
	"description" TEXT(255) NULL,
    FOREIGN KEY ("main_profile_ulid_ref") REFERENCES "tbl_profiles" ("profile_ulid"),
    FOREIGN KEY ("secondary_profile_ulid_ref") REFERENCES "tbl_profiles" ("profile_ulid"),
	PRIMARY KEY ("main_profile_ulid_ref","secondary_profile_ulid_ref")
);

-- migrate:down
DROP TABLE "tbl_profiles_relations";
