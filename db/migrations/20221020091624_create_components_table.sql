-- migrate:up
CREATE TABLE "cfg_components" (
    "component_ulid" TEXT(26) PRIMARY KEY NOT NULL,
    "name" TEXT(25) NOT NULL,
    "description" TEXT(50) NULL
);

CREATE UNIQUE INDEX "components_name_IDX" ON "cfg_components" ("name");

-- migrate:down
DROP TABLE "cfg_components";
