-- migrate:up
CREATE TABLE "game_definitions" (
    "ulid" TEXT(26) NOT NULL,
    "game_ulid_ref" TEXT(26) NOT NULL,
    -- TODO
    PRIMARY KEY ("ulid", "game_ulid_ref"),
    CONSTRAINT "game_definitions_game_ulid_ref_fkey" FOREIGN KEY ("game_ulid_ref") REFERENCES "games" ("ulid")
);

-- migrate:down
drop table "game_definitions";