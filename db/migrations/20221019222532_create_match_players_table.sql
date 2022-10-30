-- migrate:up
CREATE TABLE "tbl_matches_players_relation" (
    "matches_player_relation_ulid" TEXT(26) PRIMARY KEY NOT NULL,
    "match_ulid_ref" INTEGER NOT NULL,
    "profile_ulid_ref" INTEGER NOT NULL,
    -- "opponent_profile_id_ref" TODO: INTEGER NOT NULL, -- FEATURE: Opponent
    "civilisation" SMALLINT,
    "slot" SMALLINT NOT NULL, -- TODO: can two players have the same slot? when they have the same colour? archon mode!
    "team_number" SMALLINT,
    "color" SMALLINT, 
    "is_ready" BOOLEAN NOT NULL,
    "status" SMALLINT NOT NULL, -- 0=draft, 1=ongoing, 2=finished
    "has_won" BOOLEAN,
    "replay_url" TEXT NULL,
    CONSTRAINT "match_players_match_id_ref_fkey" FOREIGN KEY ("match_ulid_ref") REFERENCES "tbl_matches" ("match_ulid") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "match_players_profile_id_ref_fkey" FOREIGN KEY ("profile_ulid_ref") REFERENCES "tbl_profiles" ("profile_ulid") ON DELETE RESTRICT ON UPDATE CASCADE
    -- CONSTRAINT "match_players_opponent_profile_id_ref_fkey" FOREIGN KEY ("opponent_profile_id_ref") REFERENCES "profiles" ("profile_id"),
);

-- TODO: when two players play within the same colour (archon mode) they might even chose different civilisations, the civilisation being valid
-- is the civ of the player with the lower slot number (Check!!! derived from aoe2net)

CREATE UNIQUE INDEX "matches_players_relation_match_ulid_profile_ulid_IDX" ON "tbl_matches_players_relation" ("match_ulid_ref", "profile_ulid_ref");
CREATE INDEX "matches_players_relation_civ_IDX" ON "tbl_matches_players_relation" ("civilisation");
CREATE INDEX "matches_players_relation_status_IDX" ON "tbl_matches_players_relation" ("status");

-- migrate:down
drop table "tbl_matches_players_relation";
