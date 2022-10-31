-- migrate:up
CREATE TABLE IF NOT EXISTS "tbl_scopes" (
    "scope_ulid" TEXT(26) PRIMARY KEY NOT NULL,
    "name_display" TEXT(25) NOT NULL UNIQUE,
    "name_long" TEXT(100) NULL,
    "description" TEXT(255) NULL
);

-- migrate:down
DROP TABLE "tbl_scopes";
