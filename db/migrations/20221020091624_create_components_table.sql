-- migrate:up
CREATE TABLE IF NOT EXISTS "cfg_components" (
    "component_ulid" TEXT(26) PRIMARY KEY NOT NULL,
    "name" TEXT(25) NOT NULL UNIQUE,
    "description" TEXT(50) NULL
);

-- migrate:down
DROP TABLE "cfg_components";
