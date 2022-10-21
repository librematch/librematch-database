-- migrate:up
CREATE TABLE "teams_profiles_relations" (
	"id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	"teams_ulid_ref" TEXT(26) NOT NULL, -- Teams
	"profiles_ulid_ref" TEXT(26) NOT NULL, -- can have many players
	"games_ulid_ref" TEXT(26) NOT NULL, -- playing on different games
    FOREIGN KEY ("teams_ulid_ref") REFERENCES "teams" ("ulid"),
    FOREIGN KEY ("profiles_ulid_ref") REFERENCES "profiles" ("ulid"),
    FOREIGN KEY ("games_ulid_ref") REFERENCES "games" ("ulid")
);

CREATE UNIQUE INDEX "teams_profiles_relations_IDX" ON "teams_profiles_relations" ("teams_ulid_ref", "profiles_ulid_ref"); -- one profile, can only be in the same team once
CREATE INDEX "teams_games_relations_IDX" ON "teams_profiles_relations" ("games_ulid_ref");

-- migrate:down
drop table "teams_profiles_relations";
