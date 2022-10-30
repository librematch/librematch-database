-- migrate:up
CREATE TABLE "tbl_community_resources_categories_relations" (
    "community_resource_relation_id" TEXT(26) PRIMARY KEY NOT NULL,
    "community_resource_ulid_ref" TEXT(26) NOT NULL, -- Community resources
    "community_resource_category_ulid_ref" TEXT(26), -- can have many categories
    "game_ulid_ref" TEXT(26), -- for many games
    FOREIGN KEY ("community_resource_category_ulid_ref") REFERENCES "tbl_community_resources_categories" ("community_resource_category_ulid"),
    FOREIGN KEY ("community_resource_ulid_ref") REFERENCES "tbl_community_resources" ("community_resource_ulid")
    FOREIGN KEY ("game_ulid_ref") REFERENCES "tbl_games" ("game_ulid")
);

CREATE UNIQUE INDEX "com_res_cat_ulids_IDX" ON "tbl_community_resources_categories_relations" ("community_resource_category_ulid_ref", "community_resource_ulid_ref", "game_ulid_ref");

-- migrate:down
drop table "tbl_community_resources_categories_relations";

