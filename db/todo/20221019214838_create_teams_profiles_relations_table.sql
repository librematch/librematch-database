-- migrate:up
CREATE TABLE "tbl_teams_profiles_relations" (
	"team_profile_relation_id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	"team_ulid_ref" TEXT(26) NOT NULL, -- A team
	"profile_ulid_ref" TEXT(26) NOT NULL, -- can have many players
	"game_ulid_ref" TEXT(26) NOT NULL, -- playing on different games
    FOREIGN KEY ("team_ulid_ref") REFERENCES "tbl_teams" ("team_ulid"),
    FOREIGN KEY ("profile_ulid_ref") REFERENCES "tbl_profiles" ("profile_ulid"),
    FOREIGN KEY ("game_ulid_ref") REFERENCES "tbl_games" ("game_ulid")
);

CREATE UNIQUE INDEX "teams_profiles_relations_IDX" ON "tbl_teams_profiles_relations" ("team_ulid_ref", "profile_ulid_ref"); -- one profile, can only be in the same team once
CREATE INDEX "teams_games_relations_IDX" ON "tbl_teams_profiles_relations" ("game_ulid_ref");

-- migrate:down
DROP TABLE "tbl_teams_profiles_relations";
