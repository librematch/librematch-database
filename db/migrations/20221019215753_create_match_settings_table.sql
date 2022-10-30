-- migrate:up
CREATE TABLE "tbl_match_settings" (
    "match_setting_ulid" TEXT(26) NOT NULL PRIMARY KEY, 
    "allow_cheats" BOOLEAN,
    "difficulty" SMALLINT,
    "empire_wars_mode" BOOLEAN,
    "ending_age" SMALLINT,
    "full_tech_tree" BOOLEAN,
    "game_mode" SMALLINT,
    "lock_speed" BOOLEAN,
    "lock_teams" BOOLEAN,
    "population" SMALLINT,
    "record_game" BOOLEAN,
    "regicide_mode" SMALLINT,
    "resources" SMALLINT,
    "reveal_map" SMALLINT,
    "shared_exploration" BOOLEAN,
    "speed" SMALLINT,
    "starting_age" SMALLINT,
    "sudden_death_mode" BOOLEAN,
    "team_positions" BOOLEAN,
    "team_together" BOOLEAN,
    "treaty_length" INTEGER,
    "turbo_mode" BOOLEAN,
    "victory_condition" SMALLINT,
    UNIQUE (
        "match_setting_ulid", 
        "allow_cheats",
        "difficulty",
        "empire_wars_mode",
        "ending_age",
        "full_tech_tree",
        "game_mode",
        "lock_speed",
        "lock_teams",
        "population",
        "record_game",
        "regicide_mode",
        "resources",
        "reveal_map",
        "shared_exploration",
        "speed",
        "starting_age",
        "sudden_death_mode",
        "team_positions",
        "team_together",
        "treaty_length",
        "turbo_mode",
        "victory_condition"
    )
);
-- TODO: CHECK DATA TYPES FOR PADDING for not wasting space


-- migrate:down
DROP TABLE "tbl_match_settings";
