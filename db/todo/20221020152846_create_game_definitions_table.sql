-- migrate:up
CREATE TABLE IF NOT EXISTS "tbl_game_definitions" (
    "game_definition_ulid" TEXT(26) PRIMARY KEY NOT NULL,
    "game_ulid_ref" TEXT(26) NOT NULL,
    -- TODO
    CONSTRAINT "game_definitions_game_ulid_ref_fkey" FOREIGN KEY ("game_ulid_ref") REFERENCES "tbl_games" ("game_ulid")
);

-- migrate:down
DROP TABLE "tbl_game_definitions";