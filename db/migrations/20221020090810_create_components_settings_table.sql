-- migrate:up
CREATE TABLE "cfg_components_settings" (
    "component_setting_ulid" TEXT(26) PRIMARY KEY NOT NULL,
    "component_ulid_ref" TEXT(26) NOT NULL,
    "key" TEXT NOT NULL,
    "value" TEXT NOT NULL,
    CONSTRAINT "components_settings_component_ulid_ref_fkey" FOREIGN KEY ("component_ulid_ref") REFERENCES "cfg_components" ("component_ulid") ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE UNIQUE INDEX "components_settings_keys_IDX" ON "cfg_components_settings" ("component_ulid_ref", "key"); -- each component can only have the same key once

-- migrate:down
DROP TABLE "cfg_components_settings";
