-- migrate:up
CREATE TABLE "tbl_match_match_settings_relations" (
	"match_ulid_ref" TEXT(26) NOT NULL,
	"match_setting_ulid_ref" TEXT(26) NOT NULL,
    "type_of_value" TEXT CHECK( "type_of_value" IN ('text', 'boolean', 'smallint', 'integer', 'numeric', 'datetime') ) NOT NULL DEFAULT 'boolean', 
	CONSTRAINT "match_match_settings_relations_match_ulid_ref_FK" FOREIGN KEY ("match_ulid_ref") REFERENCES "tbl_matches" ("match_ulid") ON UPDATE CASCADE,
	CONSTRAINT "match_match_settings_relations_match_setting_ulid_ref_FK" FOREIGN KEY ("match_setting_ulid_ref") REFERENCES "tbl_match_settings" ("match_setting_ulid") ON UPDATE CASCADE,
	UNIQUE ("match_ulid_ref","match_setting_ulid_ref")
);

-- migrate:down
DROP TABLE "tbl_match_match_settings_relations";


        -- "allow_cheats",
        -- "difficulty",
        -- "empire_wars_mode",
        -- "ending_age",
        -- "full_tech_tree",
        -- "game_mode",
        -- "lock_speed",
        -- "lock_teams",
        -- "population",
        -- "record_game",
        -- "regicide_mode",
        -- "resources",
        -- "reveal_map",
        -- "shared_exploration",
        -- "speed",
        -- "starting_age",
        -- "sudden_death_mode",
        -- "team_positions",
        -- "team_together",
        -- "treaty_length",
        -- "turbo_mode",
        -- "victory_condition"