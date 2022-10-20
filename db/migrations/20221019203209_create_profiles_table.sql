-- migrate:up
CREATE TABLE "profiles" (
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

-- migrate:down
drop table "profiles";
