-- migrate:up
CREATE TABLE "tbl_community_resources" (
    "community_resource_ulid" TEXT(26) NOT NULL PRIMARY KEY,
    "name_long" TEXT(100) NOT NULL,
    "url_resource" TEXT NOT NULL UNIQUE,
    "has_https_enabled" BOOLEAN DEFAULT TRUE NOT NULL,
    "url_project_source" TEXT NULL,
    "description" TEXT(255),
    "name_aoezone" TEXT(50) NULL,
    "email_address" TEXT NULL,
    "name_discord" TEXT(50) NULL,
    "discord_server_invite" TEXT(50) NULL,
    "contact_form" BOOLEAN DEFAULT FALSE NOT NULL,
    "name_github" TEXT(50) NULL
);

-- migrate:down
DROP TABLE "tbl_community_resources";
