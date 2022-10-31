-- migrate:up
CREATE TABLE IF NOT EXISTS "tbl_match_settings" (
    "match_setting_ulid" TEXT(26) PRIMARY KEY NOT NULL,
    "key" TEXT NOT NULL,
    "text_value" TEXT NULL,
    "boolean_value" BOOLEAN NULL,
    "smallint_value" SMALLINT NULL,
    "integer_value" INTEGER NULL,
    "numeric_value" NUMERIC NULL,
    "datetime_value" DATETIME NULL,
    UNIQUE("key", "text_value", "boolean_value", "smallint_value", "integer_value", "numeric_value", "datetime_value")
);

-- migrate:down
DROP TABLE "tbl_match_settings";
-- TODO: CHECK Constraint somewhere?
-- TODO: CHECK DATA TYPES FOR PADDING for not wasting space
-- TODO: AoE:DE, AoE3DE, and AoE4 match settings are missing
-- TODO: Initialize table
-- INSERT INTO "tbl_match_settings" --> 
--     "match_setting_ulid" TEXT(26) NOT NULL PRIMARY KEY, 
--     "allow_cheats" BOOLEAN,
--     "difficulty" SMALLINT,
--     "empire_wars_mode" BOOLEAN,
--     "ending_age" SMALLINT,
--     "full_tech_tree" BOOLEAN,
--     "game_mode" SMALLINT,
--     "lock_speed" BOOLEAN,
--     "lock_teams" BOOLEAN,
--     "population" SMALLINT,
--     "record_game" BOOLEAN,
--     "regicide_mode" SMALLINT,
--     "resources" SMALLINT,
--     "reveal_map" SMALLINT,
--     "shared_exploration" BOOLEAN,
--     "speed" SMALLINT,
--     "starting_age" SMALLINT,
--     "sudden_death_mode" BOOLEAN,
--     "team_positions" BOOLEAN,
--     "team_together" BOOLEAN,
--     "treaty_length" INTEGER,
--     "turbo_mode" BOOLEAN,
--     "victory_condition" SMALLINT,
--     "map_size" SMALLINT ,
--     "patch_version" FLOAT,
