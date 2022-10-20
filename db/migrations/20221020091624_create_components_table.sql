-- migrate:up
CREATE TABLE "components" (
    "ulid" TEXT(26) NOT NULL,
    "component_name" TEXT NOT NULL,
    "description" TEXT,
    PRIMARY KEY ("ulid", "component_name")
);

-- migrate:down
drop table "components";
