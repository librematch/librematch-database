CREATE TABLE IF NOT EXISTS "schema_migrations" (version varchar(255) primary key);
CREATE TABLE IF NOT EXISTS "api_keys" (
	"api_key" TEXT(36) NOT NULL PRIMARY KEY,
	"valid_until_dt" DATETIME NOT NULL
);
CREATE TABLE IF NOT EXISTS "users" (
	"ulid" TEXT(26) NOT NULL,
	"profiles_ulid_ref" TEXT(26) NOT NULL,
	"rate_limit_per_unit" INTEGER DEFAULT 3,
	"rate_limit_unit" INTEGER DEFAULT 0, -- 0=minute, 1=hour, 2=day, 3=month
	"rate_limit_active" INTEGER DEFAULT 1 NOT NULL,
	PRIMARY KEY ("ulid"),
	FOREIGN KEY ("profiles_ulid_ref") REFERENCES profiles ("ulid")
);
CREATE TABLE IF NOT EXISTS "users_api_keys_relations" (
	"id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	"users_ulid_ref" TEXT(26) NOT NULL,
	"api_key_ref" TEXT(36) NOT NULL,
    FOREIGN KEY ("users_ulid_ref") REFERENCES users ("ulid"),
    FOREIGN KEY ("api_key_ref") REFERENCES api_keys ("api_key")
);
CREATE TABLE sqlite_sequence(name,seq);
CREATE UNIQUE INDEX users_api_keys_relations_user_ulid_IDX ON "users_api_keys_relations" ("users_ulid_ref","api_key_ref");
CREATE TABLE IF NOT EXISTS "profiles" (
    "ulid" TEXT(26) NOT NULL,
    "profile_id" INTEGER NOT NULL,
    "steam_id" INTEGER,
    "verified" BOOLEAN DEFAULT FALSE NOT NULL,
    "is_main_account" BOOLEAN DEFAULT TRUE NOT NULL,
    "alias" TEXT NOT NULL,
    "name" TEXT,
    "country_code" TEXT(5),
    "avatar_hash" TEXT,
    "last_match_fetched_dt" DATETIME,
    "last_match_dt" DATETIME,
    "last_refresh_dt" DATETIME,
    "delay_timer_sec" INTEGER DEFAULT 600 NOT NULL,
    "delay_timer_active" INTEGER DEFAULT 0 NOT NULL,
    "discord_invite" TEXT,
    "discord_id" TEXT,
    "twitter_id" TEXT,
    "youtube_url" TEXT,
    "twitch_id" TEXT,
    "fbgaming_id" TEXT,
    "instagram_id" TEXT,
    "liquipedia_id" TEXT,
    "esports_earnings_id" INTEGER,
    "aoe_elo_id" INTEGER,
    "douyu_id" INTEGER,
    PRIMARY KEY ("ulid", "profile_id")
);
CREATE INDEX profiles_steam_id_IDX ON profiles ("steam_id");
CREATE INDEX profiles_alias_IDX ON profiles ("alias");
CREATE INDEX profiles_name_IDX ON profiles ("name");
CREATE TABLE IF NOT EXISTS "profiles_relations" (
	"id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	"main_profiles_ulid_ref" TEXT(26) NOT NULL,
	"secondary_profiles_ulid_ref" TEXT(26) NOT NULL,
	"comments" TEXT(255),
    FOREIGN KEY ("main_profiles_ulid_ref") REFERENCES profiles ("ulid"),
    FOREIGN KEY ("secondary_profiles_ulid_ref") REFERENCES profiles ("ulid")
);
CREATE UNIQUE INDEX profiles_relations_IDX ON "profiles_relations" ("main_profiles_ulid_ref","secondary_profiles_ulid_ref");
CREATE TABLE IF NOT EXISTS "teams" (
	"ulid" TEXT(26) NOT NULL PRIMARY KEY,
	"name" TEXT(255) NOT NULL,
	"in_game_tag" TEXT(15),
	"liquipedia_id" TEXT,
	"discord_invite" TEXT,
	"twitch_id" TEXT,
	"twitter_id" TEXT,
	"youtube_url" TEXT,
	"fbgaming_id" TEXT
);
CREATE TABLE IF NOT EXISTS "teams_profiles_relations" (
	"id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	"teams_ulid_ref" TEXT(26) NOT NULL,
	"profiles_ulid_ref" TEXT(26) NOT NULL,
    FOREIGN KEY ("teams_ulid_ref") REFERENCES teams ("ulid"),
    FOREIGN KEY ("profiles_ulid_ref") REFERENCES profiles ("ulid")
);
CREATE UNIQUE INDEX teams_profiles_relations_IDX ON teams_profiles_relations ("teams_ulid_ref", "profiles_ulid_ref");
CREATE TABLE IF NOT EXISTS "match_settings" (
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
    "privacy" BOOLEAN,
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
CREATE TABLE IF NOT EXISTS "matches" (
    "ulid" TEXT(26) NOT NULL,
    "match_id" INTEGER NOT NULL,
    "leaderboards_ulid_ref" TEXT(26) NOT NULL,
    "name" TEXT,
    "server" TEXT,
    "started_dt" DATETIME,
    "finished_dt" DATETIME,
    "started_ts" INTEGER,
    "finished_ts" INTEGER,
    "map_id" INTEGER,
    "map_size" SMALLINT,
    "match_settings" TEXT NOT NULL,
    "rematch" BOOLEAN DEFAULT FALSE NOT NULL,
    "creator_profile_id" INTEGER,
    PRIMARY KEY ("ulid", "match_id", "leaderboards_ulid_ref"),
    CONSTRAINT "matches_creator_profile_id_fkey" FOREIGN KEY ("creator_profile_id") REFERENCES "profiles" ("profile_id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "matches_match_settings_fkey" FOREIGN KEY ("match_settings") REFERENCES "match_settings" ("sha256_hash")
);
CREATE INDEX "match_finished_dt_IDX" ON "matches" ("finished_dt");
CREATE INDEX "match_finished_ts_IDX" ON "matches" ("finished_ts");
CREATE INDEX "match_started_dt_IDX" ON "matches" ("started_dt");
CREATE INDEX "match_started_ts_IDX" ON "matches" ("started_ts");
CREATE INDEX "match_location_IDX" ON "matches" ("location");
CREATE INDEX "match_privacy_IDX" ON "matches" ("privacy");
CREATE INDEX "match_server_IDX" ON "matches" ("server");
CREATE INDEX "match_rematch_IDX" ON "matches" ("rematch");
CREATE TABLE IF NOT EXISTS "match_players" (
    "ulid" TEXT(26) NOT NULL,
    "match_id_ref" INTEGER NOT NULL,
    "profile_id_ref" INTEGER NOT NULL,
    "opponent_profile_id_ref" INTEGER NOT NULL,
    "civ" SMALLINT,
    "slot" SMALLINT NOT NULL,
    "team_in_matchup" SMALLINT,
    "color" SMALLINT,
    "is_ready" BOOLEAN NOT NULL,
    "status" SMALLINT NOT NULL, -- 0=draft, 1=ongoing, 2=finished
    "won" BOOLEAN,
    "replay_url" TEXT,
    PRIMARY KEY ("ulid", "match_id_ref", "profile_id_ref", "slot"),
    CONSTRAINT "match_players_match_id_ref_fkey" FOREIGN KEY ("match_id_ref") REFERENCES "matches" ("match_id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "match_players_profile_id_ref_fkey" FOREIGN KEY ("profile_id_ref") REFERENCES "profiles" ("profile_id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "match_players_opponent_profile_id_ref_fkey" FOREIGN KEY ("opponent_profile_id_ref") REFERENCES "profiles" ("profile_id")
);
CREATE INDEX "match_players_match_id_IDX" ON "match_players" ("match_id_ref");
CREATE INDEX "match_players_profile_id_with_opponent_IDX" ON "match_players" ("profile_id_ref", "opponent_profile_id_ref");
CREATE INDEX "match_players_civ_IDX" ON "match_players" ("civ");
CREATE TABLE IF NOT EXISTS "matches_import_pending" (
    "profile_id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "priority" INTEGER NOT NULL
);
CREATE TABLE IF NOT EXISTS "matches_raw" (
    "match_id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "json" TEXT NOT NULL,
    "version" INTEGER,
    "error" BOOLEAN
);
CREATE INDEX "matches_raw_version_IDX" ON "matches_raw" ("version");
CREATE INDEX "matches_raw_error_IDX" ON "matches_raw" ("error");
CREATE TABLE IF NOT EXISTS "components_settings" (
    "id" INTEGER NOT NULL PRIMARY KEY,
    "components_ulid_ref" TEXT(26) NOT NULL,
    "key" TEXT NOT NULL,
    "value" TEXT NOT NULL,
    CONSTRAINT "components_settings_components_ulid_ref_fkey" FOREIGN KEY ("components_ulid_ref") REFERENCES "components" ("ulid") ON DELETE SET NULL ON UPDATE CASCADE
);
CREATE TABLE IF NOT EXISTS "components" (
    "ulid" TEXT(26) NOT NULL,
    "component_name" TEXT NOT NULL,
    "description" TEXT,
    PRIMARY KEY ("ulid", "component_name")
);
CREATE TABLE IF NOT EXISTS "ratings_ledger" (
    "ulid" TEXT(26) NOT NULL,
    "profiles_ulid_ref" TEXT(26) NOT NULL,
    "leaderboards_ulid_ref" TEXT(26) NOT NULL,
    "match_players_ulid_ref" TEXT(26) NOT NULL,
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
    PRIMARY KEY ("ulid", "profiles_ulid_ref", "leaderboards_ulid_ref", "match_players_ulid_ref"),
    CONSTRAINT "ratings_ledger_profiles_ulid_ref_fkey" FOREIGN KEY ("profiles_ulid_ref") REFERENCES "profiles" ("ulid") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "ratings_ledger_leaderboards_ulid_ref_fkey" FOREIGN KEY ("leaderboards_ulid_ref") REFERENCES "leaderboards" ("ulid") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "ratings_ledger_match_players_ulid_ref_fkey" FOREIGN KEY ("match_players_ulid_ref") REFERENCES "match_players" ("ulid") ON DELETE SET NULL ON UPDATE CASCADE
);
CREATE TABLE IF NOT EXISTS "leaderboards" (
    "ulid" TEXT(26) NOT NULL,
    "leaderboard_id" INTEGER NOT NULL,
    "game_ulid_ref" TEXT(26) NOT NULL,
    "name" TEXT NOT NULL,
    PRIMARY KEY ("ulid", "game_ulid_ref"),
    CONSTRAINT "leaderboards_game_ulid_ref_fkey" FOREIGN KEY ("game_ulid_ref") REFERENCES "games" ("ulid")
);
CREATE TABLE IF NOT EXISTS "database_dumps" (
	"ulid" TEXT(26) NOT NULL PRIMARY KEY,
    "game_ulid_ref" TEXT(26) NOT NULL,
	"timestamp_dt" DATETIME NOT NULL,
	"type" INTEGER NOT NULL,
	"uploaded_at_dt" DATETIME NOT NULL,
	"size" INTEGER NOT NULL,
	"item_count" INTEGER NOT NULL,
	"storage_url" TEXT NOT NULL,
    CONSTRAINT "database_dumps_game_ulid_ref_fkey" FOREIGN KEY ("game_ulid_ref") REFERENCES "games" ("ulid")
);
CREATE INDEX "database_dumps_timestamp_dt_IDX" ON "database_dumps" ("timestamp_dt");
CREATE INDEX "database_dumps_uploaded_at_dt_IDX" ON "database_dumps" ("uploaded_at_dt");
CREATE TABLE IF NOT EXISTS "games" (
    "ulid" TEXT(26) NOT NULL,
	"short_name" TEXT(8) NOT NULL,
	"long_name" TEXT(255) NOT NULL,
	"release_date" DATETIME NOT NULL,
	"steam_url" TEXT NOT NULL,
	"microsoft_url" TEXT NOT NULL,
    PRIMARY KEY ("ulid", "short_name")
);
CREATE TABLE IF NOT EXISTS "game_definitions" (
    "ulid" TEXT(26) NOT NULL,
    "game_ulid_ref" TEXT(26) NOT NULL,
    -- TODO
    PRIMARY KEY ("ulid", "game_ulid_ref"),
    CONSTRAINT "game_definitions_game_ulid_ref_fkey" FOREIGN KEY ("game_ulid_ref") REFERENCES "games" ("ulid")
);
CREATE TABLE IF NOT EXISTS "community_resources" (
    "ulid" TEXT(26) NOT NULL PRIMARY KEY,
    "url" TEXT NOT NULL,
    "https_enabled" BOOLEAN DEFAULT TRUE NOT NULL,
    "description" TEXT(255),
    "aoezone_id" TEXT(255),
    "email_address" TEXT,
    "discord_id" TEXT,
    "discord_server_invite" TEXT,
    "contact_form" BOOLEAN DEFAULT FALSE NOT NULL,
    "github_id" TEXT
    -- TODO: game_ulid_ref
);
CREATE TABLE IF NOT EXISTS "tournaments" (
    "ulid" TEXT(26) NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "short" TEXT(10),
    "liquipedia_url" TEXT,
    "liquipedia_tier" SMALLINT,
    "start_dt" DATETIME,
    "end_dt" DATETIME,
    "prizepool" FLOAT,
    "player_amount" INTEGER,
    "location" TEXT
    -- TODO: Add more table columns
);
CREATE TABLE IF NOT EXISTS "statistics" (
	"ulid" TEXT(26) NOT NULL PRIMARY KEY,
    "game_ulid_ref" TEXT(26),
    "leaderboards_ulid_ref" TEXT(26),
	"timestamp_dt" DATETIME NOT NULL,
    "interval_days" INTEGER,
    "playerbase_size" INTEGER,
    -- TODO: Check how the values of different intervals fit in here
	CONSTRAINT "statistics_game_ulid_ref_fkey" FOREIGN KEY ("game_ulid_ref") REFERENCES "games" ("ulid"),
	CONSTRAINT "statistics_leaderboards_ulid_ref_fkey" FOREIGN KEY ("leaderboards_ulid_ref") REFERENCES "leaderboards" ("ulid")
);
CREATE INDEX "statistics_timestamp_dt_IDX" ON "statistics" ("timestamp_dt");
CREATE INDEX "statistics_game_ulid_ref_IDX" ON "statistics" ("game_ulid_ref");
CREATE INDEX "statistics_leaderboards_ulid_ref_IDX" ON "statistics" ("leaderboards_ulid_ref");
CREATE TABLE IF NOT EXISTS "community_resources_categories" (
    "ulid" TEXT(26) NOT NULL,
    "display_text" TEXT NOT NULL,
    "description" TEXT,
    PRIMARY KEY ("ulid", "display_text")
);
-- Dbmate schema migrations
INSERT INTO "schema_migrations" (version) VALUES
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
  ('20221020180409');
