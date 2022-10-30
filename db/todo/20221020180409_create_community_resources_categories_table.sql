-- migrate:up
CREATE TABLE "tbl_community_resources_categories" (
    "community_resource_category_ulid" TEXT(26) PRIMARY KEY NOT NULL,
    "display_text" TEXT NOT NULL,
    "description" TEXT
);

CREATE UNIQUE INDEX "community_resources_categories_display_text_IDX" ON "tbl_community_resources_categories" ("display_text");

-- migrate:down
DROP TABLE "tbl_community_resources_categories";
