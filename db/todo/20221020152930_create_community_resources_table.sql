-- migrate:up
CREATE TABLE "tbl_community_resources" (
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

-- migrate:down
drop table "tbl_community_resources";

