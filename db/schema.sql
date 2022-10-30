CREATE TABLE IF NOT EXISTS "db_schema_migrations" (version varchar(255) primary key);
CREATE TABLE IF NOT EXISTS "tbl_api_keys" (
	"api_key_ulid" TEXT(26) PRIMARY KEY NOT NULL,
	"api_key" TEXT(36) NOT NULL,
	"valid_until_dt" DATETIME NOT NULL,
	"has_admin_scope" BOOLEAN DEFAULT FALSE NOT NULL,
	"has_user_scope" BOOLEAN DEFAULT TRUE NOT NULL,
	"has_tournament_admin_scope" BOOLEAN DEFAULT FALSE NOT NULL
);
CREATE UNIQUE INDEX "api_keys_api_key_IDX" ON "tbl_api_keys" ("api_key");
CREATE TABLE IF NOT EXISTS "tbl_users" (
	"user_ulid" TEXT(26) PRIMARY KEY NOT NULL,
	"profile_ulid_ref" TEXT(26) NULL,
	"rate_limit_per_unit" INTEGER DEFAULT 3,
	"rate_limit_unit" INTEGER DEFAULT 0, -- 0=minute, 1=hour, 2=day, 3=month
	"rate_limit_active" INTEGER DEFAULT 1 NOT NULL,
	FOREIGN KEY ("profile_ulid_ref") REFERENCES "tbl_profiles" ("profile_ulid")
);
CREATE TABLE IF NOT EXISTS "tbl_users_api_keys_relations" (
	"user_api_key_relation_id" TEXT(26) PRIMARY KEY NOT NULL,
	"user_ulid_ref" TEXT(26) NOT NULL,
	"api_key_ulid_ref" TEXT(36) NOT NULL,
    FOREIGN KEY ("user_ulid_ref") REFERENCES "tbl_users" ("user_ulid"),
    FOREIGN KEY ("api_key_ulid_ref") REFERENCES "tbl_api_keys" ("api_key_ulid")
);
CREATE UNIQUE INDEX "users_api_keys_relations_users_ulid_IDX" ON "tbl_users_api_keys_relations" ("user_ulid_ref","api_key_ulid_ref");
CREATE TABLE IF NOT EXISTS "tbl_profiles" (
    "profile_ulid" TEXT(26) PRIMARY KEY NOT NULL,
    "profile_id" INTEGER NOT NULL,
    "steam_id" INTEGER NULL,
    "requested_privacy" BOOLEAN DEFAULT FALSE NOT NULL, -- this is a special attribute people can set
    "is_verified" BOOLEAN DEFAULT FALSE NOT NULL, -- has an entry on aoc-ref-data
    "is_active" BOOLEAN DEFAULT TRUE NOT NULL, -- played a match in the last 30d
    "is_main_account" BOOLEAN DEFAULT TRUE NOT NULL,
    "alias" TEXT(50) NOT NULL,
    "name" TEXT(50) NULL, -- real name from Liquipedia
    "country_code" TEXT(5), -- same as language string, e.g. es-MX
    "avatar_hash" TEXT(50), -- Hash to generate Avatar URLs for small, medium, full
    "last_match_fetched_dt" DATETIME,
    "last_match_dt" DATETIME, -- TODO: Activity indicator needs also game_ulid -> move out to own activity table
    "last_refresh_dt" DATETIME,
    "delay_timer_sec" INTEGER DEFAULT 600 NOT NULL, -- set by Tournament admins, delays a profiles' match to be shown on our API
    "delay_timer_reset_hours" INTEGER DEFAULT 1 NOT NULL, -- set by Tournament admins, when the timer expires
    "delay_timer_active" INTEGER DEFAULT 0 NOT NULL, -- if the timer is set
    "discord_invite" TEXT(50) NULL,
    "discord_id" TEXT(50) NULL,
    "twitter_id" TEXT(25) NULL,
    "youtube_url" TEXT(50) NULL,
    "twitch_id" TEXT(25) NULL,
    "fbgaming_id" TEXT(25) NULL,
    "instagram_id" TEXT(25) NULL,
    "liquipedia_id" TEXT(25) NULL,
    "esports_earnings_id" INTEGER NULL,
    "aoe_elo_id" INTEGER NULL,
    "douyu_id" INTEGER NULL
);
CREATE UNIQUE INDEX "profiles_profile_id_IDX" ON "tbl_profiles" ("profile_id");
CREATE INDEX "profiles_steam_id_IDX" ON "tbl_profiles" ("steam_id");
CREATE INDEX "profiles_requested_privacy_IDX" ON "tbl_profiles" ("requested_privacy");
CREATE INDEX "profiles_is_verified_IDX" ON "tbl_profiles" ("is_verified");
CREATE INDEX "profiles_is_active_IDX" ON "tbl_profiles" ("is_active");
CREATE INDEX "profiles_main_account_IDX" ON "tbl_profiles" ("is_main_account");
CREATE INDEX "profiles_alias_IDX" ON "tbl_profiles" ("alias");
CREATE INDEX "profiles_name_IDX" ON "tbl_profiles" ("name");
CREATE INDEX "profiles_country_IDX" ON "tbl_profiles" ("country_code");
CREATE INDEX "profiles_last_match_IDX" ON "tbl_profiles" ("last_match_dt");
CREATE TABLE IF NOT EXISTS "tbl_profiles_relations" (
	"profile_relation_ulid" TEXT(26) PRIMARY KEY NOT NULL,
	"main_profile_ulid_ref" TEXT(26) NOT NULL,
	"secondary_profile_ulid_ref" TEXT(26) NOT NULL,
	"description" TEXT(255) NULL,
    FOREIGN KEY ("main_profile_ulid_ref") REFERENCES "tbl_profiles" ("profile_ulid"),
    FOREIGN KEY ("secondary_profile_ulid_ref") REFERENCES "tbl_profiles" ("profile_ulid")
);
CREATE UNIQUE INDEX "profiles_relations_IDX" ON "tbl_profiles_relations" ("main_profile_ulid_ref","secondary_profile_ulid_ref");
CREATE TABLE IF NOT EXISTS "tbl_teams" (
	"team_ulid" TEXT(26) NOT NULL PRIMARY KEY,
	"name" TEXT(255) NOT NULL,
	"is_archived" BOOLEAN DEFAULT FALSE NOT NULL,
	"in_game_tag" TEXT(15) NULL,
	"liquipedia_id" TEXT(50) NULL,
	"discord_invite" TEXT(50) NULL,
	"twitch_id" TEXT(50) NULL,
	"twitter_id" TEXT(50) NULL,
	"youtube_url" TEXT(50) NULL,
	"fbgaming_id" TEXT(50) NULL
);
CREATE INDEX "teams_is_archived_IDX" ON "tbl_teams" ("is_archived");
CREATE TABLE IF NOT EXISTS "tbl_teams_profiles_relations" (
	"team_profile_relation_id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	"team_ulid_ref" TEXT(26) NOT NULL, -- A team
	"profile_ulid_ref" TEXT(26) NOT NULL, -- can have many players
	"game_ulid_ref" TEXT(26) NOT NULL, -- playing on different games
    FOREIGN KEY ("team_ulid_ref") REFERENCES "tbl_teams" ("team_ulid"),
    FOREIGN KEY ("profile_ulid_ref") REFERENCES "tbl_profiles" ("profile_ulid"),
    FOREIGN KEY ("game_ulid_ref") REFERENCES "tbl_games" ("game_ulid")
);
CREATE TABLE sqlite_sequence(name,seq);
CREATE UNIQUE INDEX "teams_profiles_relations_IDX" ON "tbl_teams_profiles_relations" ("team_ulid_ref", "profile_ulid_ref");
CREATE INDEX "teams_games_relations_IDX" ON "tbl_teams_profiles_relations" ("game_ulid_ref");
CREATE TABLE IF NOT EXISTS "tbl_match_settings" (
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
    "victory_condition" SMALLINT
);
CREATE TABLE IF NOT EXISTS "tbl_matches" (
    "match_ulid" TEXT(26) PRIMARY KEY NOT NULL,
    "match_id" INTEGER NOT NULL,
    "leaderboard_ulid_ref" TEXT(26) NOT NULL,
    "creator_profile_ulid_ref" TEXT(26) NOT NULL,
    "match_setting_ulid_ref" TEXT NOT NULL,
    "name" TEXT,
    "server" TEXT,
    "started_dt" DATETIME,
    "finished_dt" DATETIME,
    "map_id" INTEGER, -- originally "location", changed due to confusion in tournaments
    "map_size" SMALLINT,
    "is_private" BOOLEAN DEFAULT FALSE NOT NULL,
    "is_rematch" BOOLEAN DEFAULT FALSE NOT NULL,
    "patch_version" FLOAT,
    CONSTRAINT "matches_creator_profile_ulid_fkey" FOREIGN KEY ("creator_profile_ulid_ref") REFERENCES "tbl_profiles" ("profile_ulid") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "matches_match_settings_ulid_ref_fkey" FOREIGN KEY ("match_setting_ulid_ref") REFERENCES "tbl_match_settings" ("match_setting_ulid") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "matches_leaderboard_ulid_ref_fkey" FOREIGN KEY ("leaderboard_ulid_ref") REFERENCES "tbl_leaderboards" ("leaderboard_ulid") ON DELETE SET NULL ON UPDATE CASCADE
);
CREATE INDEX "match_finished_dt_IDX" ON "tbl_matches" ("finished_dt");
CREATE INDEX "match_started_dt_IDX" ON "tbl_matches" ("started_dt");
CREATE INDEX "match_same_map_IDX" ON "tbl_matches" ("map_id");
CREATE INDEX "match_privacy_IDX" ON "tbl_matches" ("is_private");
CREATE INDEX "match_rematch_IDX" ON "tbl_matches" ("is_rematch");
CREATE INDEX "match_same_server_IDX" ON "tbl_matches" ("server");
CREATE INDEX "match_version_IDX" ON "tbl_matches" ("version");
CREATE INDEX "match_same_settings_IDX" ON "tbl_matches" ("match_setting_ulid_ref");
CREATE INDEX "match_same_profile_IDX" ON "tbl_matches" ("creator_profile_ulid_ref");
CREATE INDEX "match_matches_on_leaderboard_IDX" ON "tbl_matches" ("leaderboard_ulid_ref");
CREATE TABLE IF NOT EXISTS "tbl_matches_players_relation" (
    "matches_player_relation_ulid" TEXT(26) PRIMARY KEY NOT NULL,
    "match_ulid_ref" INTEGER NOT NULL,
    "profile_ulid_ref" INTEGER NOT NULL,
    -- "opponent_profile_id_ref" TODO: INTEGER NOT NULL, -- FEATURE: Opponent
    "civilisation" SMALLINT,
    "slot" SMALLINT NOT NULL, -- TODO: can two players have the same slot? when they have the same colour? archon mode!
    "team_number" SMALLINT,
    "color" SMALLINT,
    "is_ready" BOOLEAN NOT NULL,
    "status" SMALLINT NOT NULL, -- 0=draft, 1=ongoing, 2=finished
    "has_won" BOOLEAN,
    "replay_url" TEXT NULL,
    CONSTRAINT "match_players_match_id_ref_fkey" FOREIGN KEY ("match_ulid_ref") REFERENCES "tbl_matches" ("match_ulid") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "match_players_profile_id_ref_fkey" FOREIGN KEY ("profile_ulid_ref") REFERENCES "tbl_profiles" ("profile_ulid") ON DELETE RESTRICT ON UPDATE CASCADE
    -- CONSTRAINT "match_players_opponent_profile_id_ref_fkey" FOREIGN KEY ("opponent_profile_id_ref") REFERENCES "profiles" ("profile_id"),
);
CREATE UNIQUE INDEX "matches_players_relation_match_ulid_profile_ulid_IDX" ON "tbl_matches_players_relation" ("match_ulid_ref", "profile_ulid_ref");
CREATE INDEX "matches_players_relation_civ_IDX" ON "tbl_matches_players_relation" ("civilisation");
CREATE INDEX "matches_players_relation_status_IDX" ON "tbl_matches_players_relation" ("status");
CREATE TABLE IF NOT EXISTS "workflow_matches_import_pending" (
    "profile_id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "priority" INTEGER NOT NULL
);
CREATE TABLE IF NOT EXISTS "workflow_matches_raw" (
    "match_id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "json" TEXT NOT NULL,
    "version" INTEGER,
    "error" BOOLEAN
);
CREATE INDEX "workflow_matches_raw_version_IDX" ON "workflow_matches_raw" ("version");
CREATE INDEX "workflow_matches_raw_error_IDX" ON "workflow_matches_raw" ("error");
CREATE TABLE IF NOT EXISTS "cfg_components_settings" (
    "component_setting_ulid" TEXT(26) PRIMARY KEY NOT NULL,
    "component_ulid_ref" TEXT(26) NOT NULL,
    "key" TEXT NOT NULL,
    "value" TEXT NOT NULL,
    CONSTRAINT "components_settings_component_ulid_ref_fkey" FOREIGN KEY ("component_ulid_ref") REFERENCES "cfg_components" ("component_ulid") ON DELETE SET NULL ON UPDATE CASCADE
);
CREATE UNIQUE INDEX "components_settings_keys_IDX" ON "cfg_components_settings" ("component_ulid_ref", "key");
CREATE TABLE IF NOT EXISTS "cfg_components" (
    "component_ulid" TEXT(26) PRIMARY KEY NOT NULL,
    "name" TEXT(25) NOT NULL,
    "description" TEXT(50) NULL
);
CREATE UNIQUE INDEX "components_name_IDX" ON "cfg_components" ("name");
CREATE TABLE IF NOT EXISTS "tbl_ratings_ledger" (
    "ratings_ledger_entry_ulid" TEXT(26) PRIMARY KEY NOT NULL,
    "profile_ulid_ref" TEXT(26) NOT NULL,
    "leaderboard_ulid_ref" TEXT(26) NOT NULL,
    "datetime" DATETIME NOT NULL,
    "rating_diff" INTEGER,
    "overall_matches" INTEGER NOT NULL,
    "drops" INTEGER,
    "current_rank" INTEGER,
    "highest_rank" INTEGER,
    "lowest_rank" INTEGER,
    "rank_country" INTEGER,
    "current_rating" INTEGER NOT NULL,
    "highest_rating" INTEGER NOT NULL,
    "lowest_rating" INTEGER NOT NULL,
    "losses" INTEGER,
    "current_streak" INTEGER,
    "highest_streak" INTEGER,
    "lowest_streak" INTEGER,
    "wins" INTEGER,
    "last_match_time" DATETIME,
    "updated_at" DATETIME NOT NULL,
    CONSTRAINT "ratings_ledger_profile_ulid_ref_fkey" FOREIGN KEY ("profile_ulid_ref") REFERENCES "tbl_profiles" ("profile_ulid") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "ratings_ledger_leaderboard_ulid_ref_fkey" FOREIGN KEY ("leaderboard_ulid_ref") REFERENCES "tbl_leaderboards" ("leaderboard_ulid") ON DELETE SET NULL ON UPDATE CASCADE
);
CREATE TABLE IF NOT EXISTS "tbl_leaderboards" (
    "leaderboard_ulid" TEXT(26) PRIMARY KEY NOT NULL,
    "leaderboard_id" INTEGER NOT NULL, -- original id from Relic Link API
    "game_ulid_ref" TEXT(26) NOT NULL, -- each leaderboard can only exist in one game
    "description" TEXT(50) NOT NULL,
    CONSTRAINT "leaderboards_game_ulid_ref_fkey" FOREIGN KEY ("game_ulid_ref") REFERENCES "tbl_games" ("game_ulid")
);
CREATE UNIQUE INDEX "leaderboards_leaderboard_game_IDX" ON "tbl_leaderboards" ("leaderboard_ulid", "game_ulid_ref");
CREATE TABLE IF NOT EXISTS "tbl_database_dumps" (
	"database_dump_ulid" TEXT(26) NOT NULL PRIMARY KEY,
    "game_ulid_ref" TEXT(26) NOT NULL, -- database dumps contain always all leaderboards of a game
	"query_executed" TEXT NOT NULL,
	"timestamp_dt" DATETIME NOT NULL,
	-- "type" INTEGER NOT NULL, -- TODO: do we want to categorize DB dumps?
	"uploaded_at_dt" DATETIME NOT NULL,
	"size" INTEGER NOT NULL,
	"item_count" INTEGER NOT NULL, -- overall rows contained
	"storage_url" TEXT NOT NULL,
    CONSTRAINT "database_dumps_game_ulid_ref_fkey" FOREIGN KEY ("game_ulid_ref") REFERENCES "tbl_games" ("game_ulid")
);
CREATE INDEX "database_dumps_timestamp_dt_IDX" ON "tbl_database_dumps" ("timestamp_dt");
CREATE INDEX "database_dumps_uploaded_at_dt_IDX" ON "tbl_database_dumps" ("uploaded_at_dt");
CREATE TABLE IF NOT EXISTS "tbl_games" (
    "game_ulid" TEXT(26) PRIMARY KEY NOT NULL,
	"short_name" TEXT(8) NOT NULL,
	"long_name" TEXT(255) NOT NULL,
	"release_date" DATETIME,
	"steam_url" TEXT,
	"microsoft_url" TEXT
);
CREATE UNIQUE INDEX "games_short_name_IDX" ON "tbl_games" ("short_name");
CREATE TABLE IF NOT EXISTS "tbl_game_definitions" (
    "game_definition_ulid" TEXT(26) PRIMARY KEY NOT NULL,
    "game_ulid_ref" TEXT(26) NOT NULL,
    -- TODO
    CONSTRAINT "game_definitions_game_ulid_ref_fkey" FOREIGN KEY ("game_ulid_ref") REFERENCES "tbl_games" ("game_ulid")
);
CREATE UNIQUE INDEX "game_definitions_game_ulid_ref_IDX" ON "tbl_game_definitions" ("game_ulid_ref");
CREATE TABLE IF NOT EXISTS "tbl_community_resources" (
    "community_resource_ulid" TEXT(26) NOT NULL PRIMARY KEY,
    "url" TEXT NOT NULL,
    "has_https_enabled" BOOLEAN DEFAULT TRUE NOT NULL,
    "description" TEXT(255),
    "aoezone_id" TEXT(255) NULL,
    "email_address" TEXT NULL,
    "discord_id" TEXT NULL,
    "discord_server_invite" TEXT NULL,
    "contact_form" BOOLEAN DEFAULT FALSE NOT NULL,
    "github_id" TEXT NULL,
    "project_source_url" TEXT NULL
);
CREATE UNIQUE INDEX "community_resource_url_IDX" ON "tbl_community_resources" ("url");
CREATE TABLE IF NOT EXISTS "tbl_tournaments" (
    "tounament_ulid" TEXT(26) NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "short" TEXT(10),
    "liquipedia_url" TEXT NULL,
    "liquipedia_tier" SMALLINT NULL,
    "start_dt" DATETIME NULL,
    "end_dt" DATETIME NULL,
    "prizepool" FLOAT NULL,
    "player_amount" INTEGER NULL,
    "location" TEXT NULL
    -- TODO: Add more table columns
);
CREATE TABLE IF NOT EXISTS "tbl_statistics" (
	"statistic_ulid" TEXT(26) NOT NULL PRIMARY KEY,
    "game_ulid_ref" TEXT(26),
    "leaderboard_ulid_ref" TEXT(26),
	"timestamp_dt" DATETIME NOT NULL,
    "interval_days" INTEGER,
    "playerbase_size" INTEGER,
    -- TODO: Check how the values of different intervals fit in here
    -- TODO: Talk to Coolio on Discord
    -- - interesting might be to make more obvious how many new multiplayers players are there (metric like first game on any leaderboard)
    --   - we could even chose top5 (activity, rating) from them and make them queryable, to be e.g. greeted on community resources
    --     - something like "We welcome @<username> as a new multiplayer to our community!"
    --   - also how many people left the game (metric might be how many _new_ people haven't played the game in 1/1,5/2/3 months)
	CONSTRAINT "statistics_game_ulid_ref_fkey" FOREIGN KEY ("game_ulid_ref") REFERENCES "tbl_games" ("game_ulid"),
	CONSTRAINT "statistics_leaderboard_ulid_ref_fkey" FOREIGN KEY ("leaderboard_ulid_ref") REFERENCES "tbl_leaderboards" ("leaderboard_ulid")
);
CREATE INDEX "statistics_timestamp_dt_IDX" ON "tbl_statistics" ("timestamp_dt");
CREATE INDEX "statistics_game_ulid_ref_IDX" ON "tbl_statistics" ("game_ulid_ref");
CREATE INDEX "statistics_leaderboard_ulid_ref_IDX" ON "tbl_statistics" ("leaderboard_ulid_ref");
CREATE TABLE IF NOT EXISTS "tbl_community_resources_categories" (
    "community_resource_category_ulid" TEXT(26) PRIMARY KEY NOT NULL,
    "display_text" TEXT NOT NULL,
    "description" TEXT
);
CREATE UNIQUE INDEX "community_resources_categories_display_text_IDX" ON "tbl_community_resources_categories" ("display_text");
CREATE TABLE IF NOT EXISTS "tbl_community_resources_categories_relations" (
    "community_resource_relation_id" TEXT(26) PRIMARY KEY NOT NULL,
    "community_resource_ulid_ref" TEXT(26) NOT NULL, -- Community resources
    "community_resource_category_ulid_ref" TEXT(26), -- can have many categories
    "game_ulid_ref" TEXT(26), -- for many games
    FOREIGN KEY ("community_resource_category_ulid_ref") REFERENCES "tbl_community_resources_categories" ("community_resource_category_ulid"),
    FOREIGN KEY ("community_resource_ulid_ref") REFERENCES "tbl_community_resources" ("community_resource_ulid")
    FOREIGN KEY ("game_ulid_ref") REFERENCES "tbl_games" ("game_ulid")
);
CREATE UNIQUE INDEX "com_res_cat_ulids_IDX" ON "tbl_community_resources_categories_relations" ("community_resource_category_ulid_ref", "community_resource_ulid_ref", "game_ulid_ref");
CREATE TABLE IF NOT EXISTS "tbl_profiles_statistics" (
	"profile_statistic_ulid" TEXT(26) PRIMARY KEY NOT NULL,
    -- "game_ulid_ref" TEXT(26), -- REL
    -- "leaderboards_ulid_ref" TEXT(26), -- REL
	"timestamp_dt" DATETIME NOT NULL,
    "interval_days" INTEGER
    -- TODO: Talk to Coolio on Discord
    -- IDEAS:
    -- - how many games per week
    -- - how many losses/wins
    -- - more chatty?
    -- - which games played most? how long?
    -- - most played civs (favourite civs)
    -- - most wins with which civs
    -- - most played map
    -- - most won map (which civ?)
    -- - how much time spent in queue
    -- - percentage of 1v1 vs TG (both ranked)
    -- - tends to pick civ (metric?)
    -- - "Player X has a YY.Z% winrate vs <civ_x> in <year>/<month> on <map>"
    -- - etc.
	-- CONSTRAINT "statistics_game_ulid_ref_fkey" FOREIGN KEY ("game_ulid_ref") REFERENCES "games" ("ulid"),
	-- CONSTRAINT "statistics_leaderboards_ulid_ref_fkey" FOREIGN KEY ("leaderboards_ulid_ref") REFERENCES "leaderboards" ("ulid")
);
CREATE TABLE IF NOT EXISTS "tbl_localizations" (
    "ulid" TEXT(26) PRIMARY KEY NOT NULL,
    "lang" TEXT (5) NOT NULL,
    "game_ulid_ref" TEXT(26) NOT NULL,
    "updated_at_dt" DATETIME NOT NULL,
    "ftl_data" BLOB NOT NULL,
    CONSTRAINT "localizations_game_ulid_ref_fkey" FOREIGN KEY ("game_ulid_ref") REFERENCES "tbl_games" ("game_ulid") ON DELETE SET NULL ON UPDATE CASCADE
);
CREATE UNIQUE INDEX "localizations_lang_IDX" ON "tbl_localizations" ("lang");
CREATE INDEX "localizations_updated_at_dt_IDX" ON "tbl_localizations" ("updated_at_dt");
CREATE TABLE IF NOT EXISTS "tbl_profiles_statistics_relations" (
	"profile_statistic_relation_ulid" TEXT(26) PRIMARY KEY NOT NULL,
    "profile_ulid_ref" TEXT(26) NOT NULL,
    "profile_statistic_ulid_ref" TEXT(26) NOT NULL,
	CONSTRAINT "profiles_statistics_relations_profile_ulid_ref_fkey" FOREIGN KEY ("profile_ulid_ref") REFERENCES "tbl_profiles" ("profile_ulid"),
	CONSTRAINT "profiles_statistics_relations_profile_statistic_ulid_ref_fkey" FOREIGN KEY ("profile_statistic_ulid_ref") REFERENCES "tbl_profiles_statistics" ("profile_statistic_ulid")
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
  ('20221020152846'),
  ('20221020152930'),
  ('20221020153039'),
  ('20221020172045'),
  ('20221020180409'),
  ('20221020233715'),
  ('20221021000721'),
  ('20221021012325'),
  ('20221025180211'),
  ('20221030034120');
