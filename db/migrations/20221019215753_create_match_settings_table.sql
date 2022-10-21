-- migrate:up
CREATE TABLE "match_settings" (
    "sha256_hash" TEXT NOT NULL PRIMARY KEY,
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
    "victory_condition" SMALLINT
    -- MAYBE (for statistics):
    -- "first_seen" DATETIME,
    -- "last_seen" DATETIME,
);

-- migrate:down
drop table "match_settings";
