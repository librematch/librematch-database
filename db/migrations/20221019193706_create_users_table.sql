-- migrate:up
CREATE TABLE "tbl_users" (
	"user_ulid" TEXT(26) PRIMARY KEY NOT NULL,
	"profile_ulid_ref" TEXT(26) NULL UNIQUE,
	"user_name" TEXT(50) NOT NULL,
	"email_address" TEXT(100) NULL,
	"discord_id" TEXT(100) NULL,
	"steam_name" TEXT(100) NULL,
	"about_me" TEXT(255) NULL,
	"rate_limit_per_unit" INTEGER DEFAULT 3,
	"rate_limit_unit" INTEGER DEFAULT 0, -- 0=minute, 1=hour, 2=day, 3=month
	"rate_limit_active" INTEGER DEFAULT 1 NOT NULL,
	FOREIGN KEY ("profile_ulid_ref") REFERENCES "tbl_profiles" ("profile_ulid")
);

-- migrate:down
DROP TABLE "tbl_users";
