-- migrate:up
CREATE TABLE IF NOT EXISTS "tbl_community_resources_categories_relations" (
    "community_resource_ulid_ref" TEXT(26) NOT NULL, -- Community resources
    "community_resource_category_ulid_ref" TEXT(26) NOT NULL, -- can have many categories
    "game_ulid_ref" TEXT(26) NOT NULL, -- for many games
    FOREIGN KEY ("community_resource_category_ulid_ref") REFERENCES "tbl_community_resources_categories" ("community_resource_category_ulid"),
    FOREIGN KEY ("community_resource_ulid_ref") REFERENCES "tbl_community_resources" ("community_resource_ulid")
    FOREIGN KEY ("game_ulid_ref") REFERENCES "tbl_games" ("game_ulid"),
    PRIMARY KEY ("community_resource_category_ulid_ref", "community_resource_ulid_ref", "game_ulid_ref")
);

-- migrate:down
DROP TABLE "tbl_community_resources_categories_relations";

