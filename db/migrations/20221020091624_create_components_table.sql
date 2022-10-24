-- migrate:up
CREATE TABLE "components" (
    "ulid" TEXT(26) NOT NULL,
    "component_name" TEXT NOT NULL,
    "description" TEXT,
    PRIMARY KEY ("ulid"),
    -- UNIQUE ("component_name") -- TODO: this can be done alternatively, think about it
);

CREATE UNIQUE INDEX "components_component_name_IDX" ON "components" ("component_name");

-- migrate:down
drop table "components";
