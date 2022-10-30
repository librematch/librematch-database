-- migrate:up
CREATE TABLE "tbl_community_resources_categories" (
    "community_resource_category_ulid" TEXT(26) PRIMARY KEY NOT NULL,
    "display_name" TEXT(25) NOT NULL UNIQUE,
    "description" TEXT(255) NULL
);

-- migrate:down
DROP TABLE "tbl_community_resources_categories";
