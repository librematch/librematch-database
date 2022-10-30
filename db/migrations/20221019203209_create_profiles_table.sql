-- migrate:up
CREATE TABLE "tbl_profiles" (
    "profile_ulid" TEXT(26) PRIMARY KEY NOT NULL,
    "relic_link_id" INTEGER NOT NULL UNIQUE,
    "steam_id" INTEGER NULL,
    "requested_privacy" BOOLEAN DEFAULT FALSE NOT NULL, -- this is a special attribute people can set
    "is_verified" BOOLEAN DEFAULT FALSE NOT NULL, -- has an entry on aoc-ref-data
    "is_active" BOOLEAN DEFAULT TRUE NOT NULL, -- played a match in the last 30d
    "is_main_account" BOOLEAN DEFAULT TRUE NOT NULL,
    "is_hidden" BOOLEAN DEFAULT FALSE NOT NULL, -- this lets us hide e.g. cheaters
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

CREATE INDEX "profiles_steam_id_IDX" ON "tbl_profiles" ("steam_id"); -- how many players on each platform
CREATE INDEX "profiles_requested_privacy_IDX" ON "tbl_profiles" ("requested_privacy");
CREATE INDEX "profiles_is_verified_IDX" ON "tbl_profiles" ("is_verified");
CREATE INDEX "profiles_is_active_IDX" ON "tbl_profiles" ("is_active");
CREATE INDEX "profiles_main_account_IDX" ON "tbl_profiles" ("is_main_account");
CREATE INDEX "profiles_alias_IDX" ON "tbl_profiles" ("alias");
CREATE INDEX "profiles_name_IDX" ON "tbl_profiles" ("name");
CREATE INDEX "profiles_country_IDX" ON "tbl_profiles" ("country_code");
CREATE INDEX "profiles_last_match_IDX" ON "tbl_profiles" ("last_match_dt");

-- migrate:down
DROP TABLE "tbl_profiles";
