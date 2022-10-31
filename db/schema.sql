CREATE TABLE IF NOT EXISTS "db_schema_migrations" (version varchar(255) primary key);
CREATE TABLE IF NOT EXISTS "tbl_api_keys" (
	"api_key_ulid" TEXT(26) PRIMARY KEY NOT NULL,
	"api_key" TEXT(36) NOT NULL UNIQUE,
	"datetime_valid_until" DATETIME NOT NULL
);
CREATE INDEX "api_keys_datetime_valid_until_IDX" ON "tbl_api_keys" ("datetime_valid_until");
CREATE TABLE IF NOT EXISTS "tbl_users" (
	"user_ulid" TEXT(26) PRIMARY KEY NOT NULL,
	"profile_ulid_ref" TEXT(26) NULL UNIQUE,
	"email_address" TEXT(100) NULL,
	"name_user" TEXT(50) NOT NULL,
	"name_steam" TEXT(50) NULL,
	"name_github" TEXT(50) NULL,
	"name_discord" TEXT(50) NULL,
	"about_me" TEXT(255) NULL,
	"datetime_registered" DATETIME NOT NULL,
	"rate_limit_per_unit" INTEGER DEFAULT 3 NOT NULL,
	"rate_limit_unit" INTEGER DEFAULT 0 NOT NULL, -- 0=minute, 1=hour, 2=day, 3=month
	"rate_limit_active" INTEGER DEFAULT 1 NOT NULL,
	FOREIGN KEY ("profile_ulid_ref") REFERENCES "tbl_profiles" ("profile_ulid")
);
CREATE TABLE IF NOT EXISTS "tbl_users_api_keys_relations" (
	"user_ulid_ref" TEXT(26) NOT NULL,
	"api_key_ulid_ref" TEXT(36) NOT NULL,
	"scope_ulid_ref" TEXT(26) NOT NULL,
	FOREIGN KEY ("scope_ulid_ref") REFERENCES "tbl_scopes" ("scope_ulid") ON UPDATE CASCADE,
    FOREIGN KEY ("user_ulid_ref") REFERENCES "tbl_users" ("user_ulid") ON UPDATE CASCADE,
    FOREIGN KEY ("api_key_ulid_ref") REFERENCES "tbl_api_keys" ("api_key_ulid") ON UPDATE CASCADE,
	PRIMARY KEY ("user_ulid_ref","api_key_ulid_ref", "scope_ulid_ref")
);
CREATE TABLE IF NOT EXISTS "tbl_profiles" (
    "profile_ulid" TEXT(26) PRIMARY KEY NOT NULL,
    "relic_link_id" INTEGER NOT NULL UNIQUE,
    "steam_id" INTEGER NULL,
    "requested_privacy" BOOLEAN DEFAULT FALSE NOT NULL, -- this is a special attribute people can set
    "no_import" BOOLEAN DEFAULT FALSE NOT NULL, -- this is a special attribute that keeps us of from reimporting data for this profile_id
    "is_verified" BOOLEAN DEFAULT FALSE NOT NULL, -- has an entry on aoc-ref-data
    "is_active" BOOLEAN DEFAULT TRUE NOT NULL, -- played a match in the last 30d
    "is_main_account" BOOLEAN DEFAULT TRUE NOT NULL,
    "is_hidden" BOOLEAN DEFAULT FALSE NOT NULL, -- this lets us hide e.g. cheaters
    "alias" TEXT(50) NOT NULL,
    "name" TEXT(50) NULL, -- real name from Liquipedia
    "country_code" TEXT(5) NULL, -- same as language string, e.g. es-MX
    "avatar_hash" TEXT(50) NULL, -- Hash to generate Avatar URLs for small, medium, full
    "datetime_first_seen" DATETIME NOT NULL,
    "datetime_last_match_fetched" DATETIME NULL,
    "datetime_last_match" DATETIME NULL, -- TODO: Activity indicator needs also game_ulid -> move out to own activity table
    "datetime_last_refresh" DATETIME NULL,
    "timer_delay_in_sec" INTEGER DEFAULT 600 NOT NULL, -- set by Tournament admins, delays a profiles' match to be shown on our API
    "timer_delay_reset_afer_hours" INTEGER DEFAULT 1 NOT NULL, -- set by Tournament admins, when the timer expires
    "timer_delay_active" INTEGER DEFAULT 0 NOT NULL, -- if the timer is set
    "discord_invite" TEXT(50) NULL,
    "name_discord" TEXT(50) NULL,
    "name_twitter" TEXT(50) NULL,
    "name_twitch" TEXT(50) NULL,
    "name_fbgaming" TEXT(50) NULL,
    "name_instagram" TEXT(50) NULL,
    "name_liquipedia" TEXT(50) NULL,
    "esports_earnings_id" INTEGER NULL,
    "url_youtube" TEXT(100) NULL,
    "aoe_elo_id" INTEGER NULL,
    "douyu_id" INTEGER NULL
);
CREATE INDEX "profiles_steam_id_IDX" ON "tbl_profiles" ("steam_id");
CREATE INDEX "profiles_requested_privacy_IDX" ON "tbl_profiles" ("requested_privacy");
CREATE INDEX "profiles_is_verified_IDX" ON "tbl_profiles" ("is_verified");
CREATE INDEX "profiles_is_active_IDX" ON "tbl_profiles" ("is_active");
CREATE INDEX "profiles_main_account_IDX" ON "tbl_profiles" ("is_main_account");
CREATE INDEX "profiles_alias_IDX" ON "tbl_profiles" ("alias");
CREATE INDEX "profiles_name_IDX" ON "tbl_profiles" ("name");
CREATE INDEX "profiles_country_IDX" ON "tbl_profiles" ("country_code");
CREATE INDEX "profiles_datetime_last_match_IDX" ON "tbl_profiles" ("datetime_last_match");
CREATE TABLE IF NOT EXISTS "tbl_profiles_relations" (
	"main_profile_ulid_ref" TEXT(26) NOT NULL,
	"secondary_profile_ulid_ref" TEXT(26) NOT NULL,
	"description" TEXT(255) NULL,
    FOREIGN KEY ("main_profile_ulid_ref") REFERENCES "tbl_profiles" ("profile_ulid"),
    FOREIGN KEY ("secondary_profile_ulid_ref") REFERENCES "tbl_profiles" ("profile_ulid"),
	PRIMARY KEY ("main_profile_ulid_ref","secondary_profile_ulid_ref")
);
CREATE TABLE IF NOT EXISTS "tbl_teams" (
	"team_ulid" TEXT(26) NOT NULL PRIMARY KEY,
	"name_long" TEXT(255) NOT NULL,
	"name_short" TEXT(15) NULL,
	"is_active" BOOLEAN DEFAULT TRUE NOT NULL,
	"liquipedia_id" TEXT(50) NULL,
	"discord_invite" TEXT(50) NULL,
	"twitch_id" TEXT(50) NULL,
	"twitter_id" TEXT(50) NULL,
	"url_youtube" TEXT(50) NULL,
	"fbgaming_id" TEXT(50) NULL
);
CREATE INDEX "teams_is_active_IDX" ON "tbl_teams" ("is_active");
CREATE TABLE IF NOT EXISTS "tbl_teams_profiles_games_relations" (
	"team_ulid_ref" TEXT(26) NOT NULL, -- Many teams
	"profile_ulid_ref" TEXT(26) NOT NULL, -- can have many players
	"game_ulid_ref" TEXT(26) NOT NULL, -- playing on many games
	"datetime_joined" DATETIME NULL,
	"datetime_left" DATETIME NULL,
	-- TODO: add statistics for player in team on game
    FOREIGN KEY ("team_ulid_ref") REFERENCES "tbl_teams" ("team_ulid"),
    FOREIGN KEY ("profile_ulid_ref") REFERENCES "tbl_profiles" ("profile_ulid"),
    FOREIGN KEY ("game_ulid_ref") REFERENCES "tbl_games" ("game_ulid"),
	UNIQUE ("team_ulid_ref", "profile_ulid_ref", "game_ulid_ref") -- but each combination exists only once
);
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
CREATE TABLE IF NOT EXISTS "tbl_matches" (
    "match_ulid" TEXT(26) PRIMARY KEY NOT NULL,
    "leaderboard_ulid_ref" TEXT(26) NOT NULL,
    "map_ulid_ref" TEXT(26) NOT NULL, -- originally "location", changed due to confusion in tournaments (geographical location)
    "relic_link_match_uuid" TEXT(36) NOT NULL UNIQUE,
    "relic_link_match_id" INTEGER NOT NULL UNIQUE,
    "name_lobby" TEXT NOT NULL,
    "server" TEXT NOT NULL,
    "datetime_started" DATETIME NULL,
    "datetime_finished" DATETIME NULL,
    "is_private" BOOLEAN DEFAULT FALSE NOT NULL,
    "is_rematch" BOOLEAN DEFAULT FALSE NOT NULL,
    "is_archived" BOOLEAN DEFAULT FALSE NOT NULL,
    FOREIGN KEY ("leaderboard_ulid_ref") REFERENCES "tbl_leaderboards" ("leaderboard_ulid") ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY ("map_ulid_ref") REFERENCES "tbl_maps" ("map_ulid") ON DELETE SET NULL ON UPDATE CASCADE
);
CREATE INDEX "matches_same_settings_IDX" ON "tbl_matches" ("match_setting_ulid_ref");
CREATE INDEX "matches_rematch_IDX" ON "tbl_matches" ("is_rematch");
CREATE INDEX "matches_matches_on_leaderboard_IDX" ON "tbl_matches" ("leaderboard_ulid_ref");
CREATE INDEX "matches_relic_link_match_uuid_IDX" ON "tbl_matches" ("relic_link_match_uuid");
CREATE INDEX "matches_relic_link_match_id_IDX" ON "tbl_matches" ("relic_link_match_id");
CREATE INDEX "matches_datetime_finished_IDX" ON "tbl_matches" ("datetime_finished");
CREATE INDEX "matches_datetime_started_IDX" ON "tbl_matches" ("datetime_started");
CREATE INDEX "matches_is_private_IDX" ON "tbl_matches" ("is_private");
CREATE INDEX "matches_same_server_IDX" ON "tbl_matches" ("server");
CREATE INDEX "matches_patch_version_IDX" ON "tbl_matches" ("patch_version");
CREATE INDEX "matches_is_archived_IDX" ON "tbl_matches" ("is_archived");
CREATE TABLE IF NOT EXISTS "tbl_matches_players_relations" (
    "match_ulid_ref" TEXT(26) NOT NULL,
    "profile_ulid_ref" TEXT(26) NOT NULL,
    "civilisation_ulid_ref" TEXT(26) NOT NULL,
    "slot" SMALLINT NOT NULL, -- TODO: can two players have the same slot? when they have the same colour? archon mode!
    "team_number" SMALLINT NOT NULL,
    "color" SMALLINT NOT NULL,
    "is_ready" BOOLEAN NOT NULL,
    "status" SMALLINT NOT NULL, -- 0=draft, 1=ongoing, 2=finished
    "has_won" BOOLEAN DEFAULT FALSE NOT NULL,
    "url_recorded_game" TEXT NULL,
    "is_archived" BOOLEAN DEFAULT FALSE NOT NULL,
    FOREIGN KEY ("match_ulid_ref") REFERENCES "tbl_matches" ("match_ulid") ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY ("profile_ulid_ref") REFERENCES "tbl_profiles" ("profile_ulid") ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY ("civilisation_ulid_ref") REFERENCES "tbl_civilisations" ("civilisation_ulid") ON DELETE RESTRICT ON UPDATE CASCADE,
    PRIMARY KEY ("match_ulid_ref", "profile_ulid_ref")
);
CREATE INDEX "matches_players_relations_civ_IDX" ON "tbl_matches_players_relations" ("civilisation");
CREATE INDEX "matches_players_relations_status_IDX" ON "tbl_matches_players_relations" ("status");
CREATE INDEX "matches_players_relations_is_archived_IDX" ON "tbl_matches_players_relations" ("is_archived");
CREATE TABLE IF NOT EXISTS "workflow_matches_import_pending" (
    "profile_id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "priority" INTEGER NOT NULL
);
CREATE TABLE sqlite_sequence(name,seq);
CREATE TABLE IF NOT EXISTS "workflow_matches_raw" (
    "match_id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "json" TEXT NOT NULL,
    "version" INTEGER NULL,
    "error" BOOLEAN DEFAULT FALSE NOT NULL
);
CREATE INDEX "workflow_matches_raw_version_IDX" ON "workflow_matches_raw" ("version");
CREATE INDEX "workflow_matches_raw_error_IDX" ON "workflow_matches_raw" ("error");
CREATE TABLE IF NOT EXISTS "cfg_components_settings" (
    "component_ulid_ref" TEXT(26) NOT NULL,
    "key" TEXT NOT NULL,
    "value" TEXT NOT NULL,
    FOREIGN KEY ("component_ulid_ref") REFERENCES "cfg_components" ("component_ulid") ON DELETE SET NULL ON UPDATE CASCADE,
    UNIQUE("component_ulid_ref", "key")
);
CREATE TABLE IF NOT EXISTS "cfg_components" (
    "component_ulid" TEXT(26) PRIMARY KEY NOT NULL,
    "name" TEXT(25) NOT NULL UNIQUE,
    "description" TEXT(50) NULL
);
CREATE TABLE IF NOT EXISTS "tbl_ratings_ledger" (
    "profile_ulid_ref" TEXT(26) NOT NULL,
    "leaderboard_ulid_ref" TEXT(26) NOT NULL,
    "rating_diff" INTEGER NULL,
    "overall_matches" INTEGER NOT NULL,
    "drops" INTEGER DEFAULT 0 NOT NULL,
    "current_rank" INTEGER NOT NULL,
    "highest_rank" INTEGER NOT NULL,
    "lowest_rank" INTEGER NOT NULL,
    "rank_country" INTEGER NOT NULL,
    "current_rating" INTEGER NOT NULL,
    "highest_rating" INTEGER NOT NULL,
    "lowest_rating" INTEGER NOT NULL,
    "losses" INTEGER DEFAULT 0 NOT NULL,
    "current_streak" INTEGER DEFAULT 0 NOT NULL,
    "highest_streak" INTEGER DEFAULT 0 NOT NULL,
    "lowest_streak" INTEGER DEFAULT 0 NOT NULL,
    "wins" INTEGER DEFAULT 0 NOT NULL,
    "datetime_rating_achieved" DATETIME NOT NULL,
    "datetime_updated_at" DATETIME NOT NULL,
    "datetime_last_match" DATETIME NULL,
    "is_archived" BOOLEAN DEFAULT FALSE NOT NULL,
    FOREIGN KEY ("profile_ulid_ref") REFERENCES "tbl_profiles" ("profile_ulid") ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY ("leaderboard_ulid_ref") REFERENCES "tbl_leaderboards" ("leaderboard_ulid") ON DELETE SET NULL ON UPDATE CASCADE,
    PRIMARY KEY ("profile_ulid_ref", "leaderboard_ulid_ref", "datetime_rating_achieved")
);
CREATE INDEX "ratings_ledger_is_archived_IDX" ON "tbl_ratings_ledger" ("is_archived");
CREATE TABLE IF NOT EXISTS "tbl_leaderboards" (
    "leaderboard_ulid" TEXT(26) PRIMARY KEY NOT NULL,
    "relic_link_leaderboard_id" INTEGER NULL, -- original id from Relic Link API, can be NULL because tournaments and other also have leaderboards
    "game_ulid_ref" TEXT(26) NOT NULL, -- each leaderboard can only exist in one game
    "description" TEXT(50) NOT NULL,
    FOREIGN KEY ("game_ulid_ref") REFERENCES "tbl_games" ("game_ulid"),
    UNIQUE ("leaderboard_ulid", "game_ulid_ref")
);
CREATE TABLE IF NOT EXISTS "tbl_database_dumps" (
	"database_dump_ulid" TEXT(26) NOT NULL PRIMARY KEY,
    "game_ulid_ref" TEXT(26) NOT NULL, -- database dumps contain always all leaderboards of a game
	"query_executed" TEXT NOT NULL,
	"datetime_created_at" DATETIME NOT NULL,
	"datetime_uploaded_at" DATETIME NOT NULL,
	"size" INTEGER NOT NULL,
	"item_count" INTEGER NOT NULL, -- overall rows contained
	"url_storage" TEXT NOT NULL,
	-- "type" INTEGER NOT NULL, -- TODO: do we want to categorize DB dumps?
    FOREIGN KEY ("game_ulid_ref") REFERENCES "tbl_games" ("game_ulid")
);
CREATE INDEX "database_dumps_datetime_created_at_IDX" ON "tbl_database_dumps" ("datetime_created_at");
CREATE INDEX "database_dumps_datetime_uploaded_at_IDX" ON "tbl_database_dumps" ("datetime_uploaded_at");
CREATE TABLE IF NOT EXISTS "tbl_games" (
    "game_ulid" TEXT(26) PRIMARY KEY NOT NULL,
	"name_short" TEXT(8) NOT NULL UNIQUE,
	"name_long" TEXT(255) NOT NULL,
	"datetime_release" DATETIME NULL,
	"url_steam" TEXT NULL,
	"url_microsoft" TEXT NULL,
	"url_icon" TEXT NULL
);
CREATE TABLE IF NOT EXISTS "tbl_community_resources" (
    "community_resource_ulid" TEXT(26) NOT NULL PRIMARY KEY,
    "name_long" TEXT(100) NOT NULL,
    "url_resource" TEXT NOT NULL UNIQUE,
    "has_https_enabled" BOOLEAN DEFAULT TRUE NOT NULL,
    "url_project_source" TEXT NULL,
    "description" TEXT(255) NULL,
    "name_aoezone" TEXT(50) NULL,
    "email_address" TEXT NULL,
    "name_discord" TEXT(50) NULL,
    "discord_server_invite" TEXT(50) NULL,
    "contact_form" BOOLEAN DEFAULT FALSE NOT NULL,
    "name_github" TEXT(50) NULL
);
CREATE TABLE IF NOT EXISTS "tbl_tournaments" (
    "tournament_ulid" TEXT(26) NOT NULL PRIMARY KEY,
    "name_long" TEXT(50) NOT NULL,
    "name_short" TEXT(10),
    "url_liquipedia" TEXT NULL,
    "liquipedia_tier" SMALLINT NULL,
    "datetime_start" DATETIME NULL,
    "datetime_end" DATETIME NULL,
    "prizepool" FLOAT NULL,
    "player_amount" INTEGER NULL,
    "location" TEXT NULL
    -- TODO: Add more table columns
);
CREATE TABLE IF NOT EXISTS "tbl_community_resources_categories" (
    "community_resource_category_ulid" TEXT(26) PRIMARY KEY NOT NULL,
    "name_display" TEXT(25) NOT NULL UNIQUE,
    "name_long" TEXT(100) NULL,
    "description" TEXT(255) NULL
);
CREATE TABLE IF NOT EXISTS "tbl_community_resources_categories_relations" (
    "community_resource_ulid_ref" TEXT(26) NOT NULL, -- Community resources
    "community_resource_category_ulid_ref" TEXT(26) NOT NULL, -- can have many categories
    "game_ulid_ref" TEXT(26) NOT NULL, -- for many games
    FOREIGN KEY ("community_resource_category_ulid_ref") REFERENCES "tbl_community_resources_categories" ("community_resource_category_ulid"),
    FOREIGN KEY ("community_resource_ulid_ref") REFERENCES "tbl_community_resources" ("community_resource_ulid")
    FOREIGN KEY ("game_ulid_ref") REFERENCES "tbl_games" ("game_ulid"),
    PRIMARY KEY ("community_resource_category_ulid_ref", "community_resource_ulid_ref", "game_ulid_ref")
);
CREATE TABLE IF NOT EXISTS "tbl_api_keys_statistics" (
	"api_key_stat_ulid" TEXT(26) PRIMARY KEY NOT NULL,
	"key" TEXT CHECK( "key" IN ('req_last_24h', 'req_last_12h', 'req_last_6h', 'req_last_1h', 'req_last_30min', 'req_last_1min') ) DEFAULT 'req_last_1h' NOT NULL,
	"value" INTEGER NOT NULL,
	UNIQUE ("key", "value")
);
CREATE TABLE IF NOT EXISTS "tbl_api_keys_statistics_relations" (
	"api_key_ulid_ref" TEXT(26) NOT NULL,
	"api_key_statistic_ulid_ref" TEXT(26) NOT NULL,
	"datetime_created" DATETIME NOT NULL,
	FOREIGN KEY ("api_key_ulid_ref") REFERENCES "tbl_api_keys" ("api_key_ulid") ON UPDATE CASCADE,
	FOREIGN KEY ("api_key_statistic_ulid_ref") REFERENCES "tbl_api_keys_statistics" ("api_key_stat_ulid") ON UPDATE CASCADE,
	PRIMARY KEY ("api_key_ulid_ref","api_key_statistic_ulid_ref", "datetime_created")
);
CREATE TABLE IF NOT EXISTS "tbl_scopes" (
    "scope_ulid" TEXT(26) PRIMARY KEY NOT NULL,
    "name_display" TEXT(25) NOT NULL UNIQUE,
    "name_long" TEXT(100) NULL,
    "description" TEXT(255) NULL
);
CREATE TABLE IF NOT EXISTS "tbl_users_scopes_relations" (
	"user_ulid_ref" TEXT(26) NOT NULL,
	"scope_ulid_ref" TEXT(26) NOT NULL,
	FOREIGN KEY ("user_ulid_ref") REFERENCES "tbl_users" ("user_ulid") ON UPDATE CASCADE,
	FOREIGN KEY ("scope_ulid_ref") REFERENCES "tbl_scopes" ("scope_ulid") ON UPDATE CASCADE,
	PRIMARY KEY ("user_ulid_ref","scope_ulid_ref")
);
CREATE TABLE IF NOT EXISTS "tbl_matches_match_settings_relations" (
	"match_ulid_ref" TEXT(26) NOT NULL,
	"match_setting_ulid_ref" TEXT(26) NOT NULL,
    "type_of_value" TEXT CHECK( "type_of_value" IN ('text_value', 'boolean_value', 'smallint_value', 'integer_value', 'numeric_value', 'datetime_value') ) DEFAULT 'boolean_value' NOT NULL,
	FOREIGN KEY ("match_ulid_ref") REFERENCES "tbl_matches" ("match_ulid") ON UPDATE CASCADE,
	FOREIGN KEY ("match_setting_ulid_ref") REFERENCES "tbl_match_settings" ("match_setting_ulid") ON UPDATE CASCADE,
	PRIMARY KEY ("match_ulid_ref","match_setting_ulid_ref", "type_of_value")
);
CREATE TABLE IF NOT EXISTS "tbl_users_tournaments_relations" (
	"user_ulid_ref" TEXT(26) NOT NULL,
	"tournament_ulid_ref" TEXT(36) NOT NULL,
	"scope_ulid_ref" TEXT(26) NOT NULL,
	FOREIGN KEY ("scope_ulid_ref") REFERENCES "tbl_scopes" ("scope_ulid") ON UPDATE CASCADE,
    FOREIGN KEY ("user_ulid_ref") REFERENCES "tbl_users" ("user_ulid") ON UPDATE CASCADE,
    FOREIGN KEY ("tournament_ulid_ref") REFERENCES "tbl_tournaments" ("tournament_ulid") ON UPDATE CASCADE,
	PRIMARY KEY ("user_ulid_ref","tournament_ulid_ref", "scope_ulid_ref")
);
CREATE TABLE IF NOT EXISTS "tbl_tournaments_leaderboards_relations" (
	"tournament_ulid_ref" TEXT(36) NOT NULL,
	"leaderboard_ulid_ref" TEXT(26) NOT NULL,
    "url_bracket" TEXT NULL,
    "url_liquipedia" TEXT NULL,
    FOREIGN KEY ("leaderboard_ulid_ref") REFERENCES "tbl_leaderboards" ("leaderboard_ulid") ON UPDATE CASCADE,
    FOREIGN KEY ("tournament_ulid_ref") REFERENCES "tbl_tournaments" ("tournament_ulid") ON UPDATE CASCADE,
	PRIMARY KEY ("tournament_ulid_ref", "leaderboard_ulid_ref")
);
CREATE TABLE IF NOT EXISTS "tbl_dlcs" (
	"dlc_ulid" TEXT(26) PRIMARY KEY NOT NULL,
	"game_ulid_ref" TEXT(26) NULL,
	"name_short" TEXT(15) NOT NULL UNIQUE,
	"name_long" TEXT(100) NULL,
	"description" TEXT(255) NULL,
    "datetime_release" DATETIME NULL,
    "url_steam" TEXT NULL,
    "url_microsoft_store" TEXT NULL,
    "url_icon" TEXT NULL,
	FOREIGN KEY ("game_ulid_ref") REFERENCES "tbl_games" ("game_ulid")
);
CREATE TABLE IF NOT EXISTS "tbl_civilisations" (
	"civilisation_ulid" TEXT(26) PRIMARY KEY NOT NULL,
    "relic_link_civilisation_id" INTEGER NOT NULL,
    "is_base_civilisation" BOOLEAN DEFAULT TRUE NOT NULL,
    "game_ulid_ref" TEXT(26) NULL,
    "dlc_ulid_ref" TEXT(26) NULL,
	"name_short" TEXT(5) NOT NULL,
	"name_long" TEXT(50) NOT NULL,
    "url_icon" TEXT NULL,
	FOREIGN KEY ("game_ulid_ref") REFERENCES "tbl_games" ("game_ulid"),
	FOREIGN KEY ("dlc_ulid_ref") REFERENCES "tbl_dlcs" ("dlc_ulid"),
    CONSTRAINT "check_at_least_one_game_or_dlc_is_not_null" CHECK (("game_ulid_ref" IS NOT NULL AND "is_base_civilisation" IS TRUE) OR ("dlc_ulid_ref" IS NOT NULL AND "is_base_civilisation" IS FALSE))
);
CREATE TABLE IF NOT EXISTS "tbl_maps" (
	"map_ulid" TEXT(26) PRIMARY KEY NOT NULL,
    "relic_link_map_id" INTEGER NOT NULL,
	"name" TEXT(50) NOT NULL,
    "name_file" TEXT(255) NOT NULL UNIQUE,
    "url_icon" TEXT NULL
);
CREATE TABLE IF NOT EXISTS "tbl_maps_leaderboards_relations" (
	"leaderboard_ulid_ref" TEXT(26) NOT NULL,
	"map_ulid_ref" TEXT(26) NOT NULL,
    FOREIGN KEY ("leaderboard_ulid_ref") REFERENCES "tbl_leaderboards" ("leaderboard_ulid") ON UPDATE CASCADE,
    FOREIGN KEY ("map_ulid_ref") REFERENCES "tbl_maps" ("map_ulid") ON UPDATE CASCADE,
	PRIMARY KEY ("leaderboard_ulid_ref", "map_ulid_ref")
);
CREATE TABLE IF NOT EXISTS "tbl_continents" (
	"continent_ulid" TEXT(26) PRIMARY KEY NOT NULL,
    "relic_link_continent_id" INTEGER NOT NULL,
	"name" TEXT(25) NOT NULL
);
-- Dbmate schema migrations
INSERT INTO "db_schema_migrations" (version) VALUES
  ('20221019185730'),
  ('20221019193706'),
  ('20221019194233'),
  ('20221019203209'),
  ('20221019210509'),
  ('20221019213552'),
  ('20221019214838'),
  ('20221019215753'),
  ('20221019221428'),
  ('20221019222532'),
  ('20221020090157'),
  ('20221020090436'),
  ('20221020090810'),
  ('20221020091624'),
  ('20221020093601'),
  ('20221020095052'),
  ('20221020151117'),
  ('20221020151258'),
  ('20221020152930'),
  ('20221020153039'),
  ('20221020180409'),
  ('20221020233715'),
  ('20221021012325'),
  ('20221030043732'),
  ('20221030043738'),
  ('20221030052247'),
  ('20221030052253'),
  ('20221030053241'),
  ('20221030190631'),
  ('20221030200922'),
  ('20221030202750'),
  ('20221031083722'),
  ('20221031095545'),
  ('20221031104304'),
  ('20221031104702'),
  ('20221031110638');
