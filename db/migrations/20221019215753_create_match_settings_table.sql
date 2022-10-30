-- migrate:up
CREATE TABLE "tbl_match_settings" (
    "match_setting_ulid" TEXT(26) PRIMARY KEY NOT NULL,
    "key" TEXT NOT NULL,
    "text_value" TEXT NULL,
    "boolean_value" BOOLEAN NULL,
    "smallint_value" SMALLINT NULL,
    "integer_value" INTEGER NULL,
    "numeric_value" NUMERIC NULL,
    "datetime_value" DATETIME NULL
    -- CONSTRAINT "components_settings_component_ulid_ref_fkey" FOREIGN KEY ("component_ulid_ref") REFERENCES "cfg_components" ("component_ulid") ON DELETE SET NULL ON UPDATE CASCADE,
    -- UNIQUE("component_ulid_ref", "key")
);

-- migrate:down
DROP TABLE "tbl_match_settings";

-- CREATE TABLE "tbl_match_settings" (
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
--     UNIQUE ( 
--         "allow_cheats",
--         "difficulty",
--         "empire_wars_mode",
--         "ending_age",
--         "full_tech_tree",
--         "game_mode",
--         "lock_speed",
--         "lock_teams",
--         "population",
--         "record_game",
--         "regicide_mode",
--         "resources",
--         "reveal_map",
--         "shared_exploration",
--         "speed",
--         "starting_age",
--         "sudden_death_mode",
--         "team_positions",
--         "team_together",
--         "treaty_length",
--         "turbo_mode",
--         "victory_condition"
--     ) -- FEATURE: STATISTICS FOR COMMON/MOST PLAYED MATCH SETTINGS
-- );
-- -- TODO: CHECK DATA TYPES FOR PADDING for not wasting space
-- -- TODO: AoE:DE, AoE3DE, and AoE4 match settings are missing
-- -- TODO: This is relatively awkward, is there another option to make it easily possible??? 

-- -- migrate:down
-- DROP TABLE "tbl_match_settings";
