-- migrate:up
CREATE TABLE "users" (
	"ulid" TEXT(26) NOT NULL,
	"profiles_ulid_ref" TEXT(26) NOT NULL,
	"rate_limit_per_unit" INTEGER DEFAULT 3,
	"rate_limit_unit" INTEGER DEFAULT 0, -- 0=minute, 1=hour, 2=day, 3=month
	"rate_limit_active" INTEGER DEFAULT 1 NOT NULL,
	PRIMARY KEY ("ulid"),
	FOREIGN KEY ("profiles_ulid_ref") REFERENCES "profiles" ("ulid")
);

-- migrate:down
drop table "users";
