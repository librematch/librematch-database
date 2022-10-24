-- migrate:up
CREATE TABLE "community_resources_categories" (
    "ulid" TEXT(26) NOT NULL,
    "display_text" TEXT NOT NULL,
    "description" TEXT,
    PRIMARY KEY ("ulid")
);

CREATE UNIQUE INDEX "community_resources_categories_display_text_IDX" ON "community_resources_categories" ("display_text");

-- migrate:down
drop table "community_resources_categories";

