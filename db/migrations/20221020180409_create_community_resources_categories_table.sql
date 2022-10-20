-- migrate:up
CREATE TABLE "community_resources_categories" (
    "ulid" TEXT(26) NOT NULL,
    "display_text" TEXT NOT NULL,
    "description" TEXT,
    PRIMARY KEY ("ulid", "display_text")
);

-- migrate:down
drop table "community_resources_categories";

