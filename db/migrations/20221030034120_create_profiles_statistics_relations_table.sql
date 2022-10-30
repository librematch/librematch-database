-- migrate:up
CREATE TABLE "tbl_profiles_statistics_relations" (
	"profile_statistic_relation_ulid" TEXT(26) PRIMARY KEY NOT NULL,
    "profile_ulid_ref" TEXT(26) NOT NULL,
    "profile_statistic_ulid_ref" TEXT(26) NOT NULL,
	CONSTRAINT "profiles_statistics_relations_profile_ulid_ref_fkey" FOREIGN KEY ("profile_ulid_ref") REFERENCES "tbl_profiles" ("profile_ulid"),
	CONSTRAINT "profiles_statistics_relations_profile_statistic_ulid_ref_fkey" FOREIGN KEY ("profile_statistic_ulid_ref") REFERENCES "tbl_profiles_statistics" ("profile_statistic_ulid")
);

-- migrate:down
drop table "tbl_profiles_statistics";
