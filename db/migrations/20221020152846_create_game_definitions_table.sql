-- migrate:up
CREATE TABLE "game_definitions" (
    "ulid" TEXT(26) NOT NULL,
    "game_ulid_ref" TEXT(26) NOT NULL,
    -- TODO
    PRIMARY KEY ("ulid"),
    CONSTRAINT "game_definitions_game_ulid_ref_fkey" FOREIGN KEY ("game_ulid_ref") REFERENCES "games" ("ulid")
);

CREATE UNIQUE INDEX "game_definitions_game_ulid_ref_IDX" ON "game_definitions" ("game_ulid_ref");


-- migrate:down
drop table "game_definitions";