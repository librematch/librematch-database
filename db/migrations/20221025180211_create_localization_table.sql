-- migrate:up
create table "tbl_localizations" (
    "ulid" TEXT(26) PRIMARY KEY NOT NULL,
    "lang" TEXT (5) NOT NULL,
    "game_ulid_ref" TEXT(26) NOT NULL,
    "updated_at_dt" DATETIME NOT NULL,
    "ftl_data" BLOB NOT NULL,
    CONSTRAINT "localizations_game_ulid_ref_fkey" FOREIGN KEY ("game_ulid_ref") REFERENCES "tbl_games" ("game_ulid") ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE UNIQUE INDEX "localizations_lang_IDX" ON "tbl_localizations" ("lang");
CREATE INDEX "localizations_updated_at_dt_IDX" ON "tbl_localizations" ("updated_at_dt");

-- migrate:down
drop table "tbl_localizations";
