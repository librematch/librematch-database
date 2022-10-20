-- migrate:up
CREATE TABLE "components_settings" (
    "id" INTEGER NOT NULL PRIMARY KEY,
    "components_ulid_ref" TEXT(26) NOT NULL,
    "key" TEXT NOT NULL,
    "value" TEXT NOT NULL,
    CONSTRAINT "components_settings_components_ulid_ref_fkey" FOREIGN KEY ("components_ulid_ref") REFERENCES "components" ("ulid") ON DELETE SET NULL ON UPDATE CASCADE
);

-- migrate:down
drop table "components_settings";