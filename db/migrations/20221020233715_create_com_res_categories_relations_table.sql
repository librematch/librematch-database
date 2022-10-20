-- migrate:up
CREATE TABLE "community_resources_categories_relations" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "com_res_categories_ulid_ref" TEXT(26) NOT NULL,
    "com_res_ulid_ref" TEXT(26) NOT NULL,
    FOREIGN KEY ("com_res_categories_ulid_ref") REFERENCES "community_resources_categories" ("ulid"),
    FOREIGN KEY ("com_res_ulid_ref") REFERENCES "community_resources" ("ulid")
);

CREATE UNIQUE INDEX "com_res_cat_ulids_IDX" ON "community_resources_categories_relations" ("com_res_categories_ulid_ref", "com_res_ulid_ref");

-- migrate:down
drop table "community_resources_categories_relations";

