-- migrate:up
CREATE TABLE "community_resources" (
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

-- migrate:down
drop table "community_resources";

