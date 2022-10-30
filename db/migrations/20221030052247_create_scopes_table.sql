-- migrate:up
CREATE TABLE "tbl_scopes" (
    "scope_ulid" TEXT(26) PRIMARY KEY NOT NULL,
    "display_name" TEXT(25) NOT NULL UNIQUE,
    "description" TEXT(255) NULL
);

-- migrate:down
DROP TABLE "tbl_scopes";
