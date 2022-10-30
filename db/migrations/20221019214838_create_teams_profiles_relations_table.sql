-- migrate:up
CREATE TABLE "tbl_teams_profiles_games_relations" (
	"team_ulid_ref" TEXT(26) NOT NULL, -- Many teams
	"profile_ulid_ref" TEXT(26) NOT NULL, -- can have many players
	"game_ulid_ref" TEXT(26) NOT NULL, -- playing on many games
	"datetime_joined" DATETIME NULL, -- EXAMPLE: for characteristics of relation
    FOREIGN KEY ("team_ulid_ref") REFERENCES "tbl_teams" ("team_ulid"),
    FOREIGN KEY ("profile_ulid_ref") REFERENCES "tbl_profiles" ("profile_ulid"),
    FOREIGN KEY ("game_ulid_ref") REFERENCES "tbl_games" ("game_ulid"),
	UNIQUE ("team_ulid_ref", "profile_ulid_ref", "game_ulid_ref") -- but each combination exists only once
);

-- migrate:down
DROP TABLE "tbl_teams_profiles_relations";
