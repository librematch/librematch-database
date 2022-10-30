-- migrate:up
CREATE TABLE "tbl_community_resources_categories" (
    "community_resource_category_ulid" TEXT(26) PRIMARY KEY NOT NULL,
    "display_name" TEXT NOT NULL UNIQUE,
    "description" TEXT
);

-- migrate:down
DROP TABLE "tbl_community_resources_categories";
