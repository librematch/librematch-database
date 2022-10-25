-- migrate:up
create table "localizations" (
    "ulid" TEXT(26) NOT NULL,
    "lang" TEXT (5) NOT NULL,
    "updated_at_dt" DATETIME NOT NULL,
    "ftl-blob" BLOB NOT NULL,
    PRIMARY KEY ("ulid")
);

CREATE UNIQUE INDEX "localizations_lang_IDX" ON "localizations" ("lang");
CREATE INDEX "localizations_updated_at_dt_IDX" ON "localizations" ("updated_at_dt");

-- migrate:down
drop table "localizations";
