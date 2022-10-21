-- migrate:up
CREATE TABLE "profiles" (
    "ulid" TEXT(26) NOT NULL,
    "profile_id" INTEGER NOT NULL,
    "steam_id" INTEGER,
    "requested_privacy" BOOLEAN DEFAULT FALSE NOT NULL, -- this is a special attribute people can set
    "is_verified" BOOLEAN DEFAULT FALSE NOT NULL, -- has an entry on aoc-ref-data
    "is_active" BOOLEAN DEFAULT TRUE NOT NULL, -- played a match in the last 30d
    "is_main_account" BOOLEAN DEFAULT TRUE NOT NULL,
    "alias" TEXT NOT NULL,
    "name" TEXT, -- real name from Liquipedia
    "country_code" TEXT(5), -- same as language string, e.g. es-MX
    "avatar_hash" TEXT, -- Hash to generate Avatar URLs for small, medium, full
    "last_match_fetched_dt" DATETIME,
    "last_match_dt" DATETIME, -- Activity indicator
    "last_refresh_dt" DATETIME,
    "delay_timer_sec" INTEGER DEFAULT 600 NOT NULL, -- set by Tournament admins, delays a profiles' match to be shown on our API
    "delay_timer_reset_hours" INTEGER DEFAULT 1 NOT NULL, -- set by Tournament admins, when the timer expires
    "delay_timer_active" INTEGER DEFAULT 0 NOT NULL, -- if the timer is set
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

CREATE INDEX "profiles_steam_id_IDX" ON "profiles" ("steam_id"); -- how many players on each platform
CREATE INDEX "profiles_requested_privacy_IDX" ON "profiles" ("requested_privacy");
CREATE INDEX "profiles_is_verified_IDX" ON "profiles" ("is_verified");
CREATE INDEX "profiles_is_active_IDX" ON "profiles" ("is_active");
CREATE INDEX "profiles_main_account_IDX" ON "profiles" ("is_main_account");
CREATE INDEX "profiles_alias_IDX" ON "profiles" ("alias");
CREATE INDEX "profiles_name_IDX" ON "profiles" ("name");
CREATE INDEX "profiles_country_IDX" ON "profiles" ("country_code");
CREATE INDEX "profiles_last_match_IDX" ON "profiles" ("last_match_dt");

-- migrate:down
drop table "profiles";
