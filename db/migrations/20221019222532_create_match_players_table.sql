-- migrate:up
CREATE TABLE "match_players" (
    "ulid" TEXT(26) NOT NULL,
    "match_id_ref" INTEGER NOT NULL,
    "profile_id_ref" INTEGER NOT NULL,
    -- "opponent_profile_id_ref" INTEGER NOT NULL, -- FEATURE: Opponent
    "civ" SMALLINT,
    "slot" SMALLINT NOT NULL, -- TODO: can two players have the same slot? when they have the same colour? archon mode!
    "team_in_matchup" SMALLINT, -- just the team, renamed due to confusion with teams (clans) from Liquipedia
    "colour" SMALLINT, 
    "is_ready" BOOLEAN NOT NULL,
    "status" SMALLINT NOT NULL, -- 0=draft, 1=ongoing, 2=finished
    "won" BOOLEAN,
    "replay_url" TEXT,
    CONSTRAINT "match_players_match_id_ref_fkey" FOREIGN KEY ("match_id_ref") REFERENCES "matches" ("match_id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "match_players_profile_id_ref_fkey" FOREIGN KEY ("profile_id_ref") REFERENCES "profiles" ("profile_id") ON DELETE RESTRICT ON UPDATE CASCADE,
    -- CONSTRAINT "match_players_opponent_profile_id_ref_fkey" FOREIGN KEY ("opponent_profile_id_ref") REFERENCES "profiles" ("profile_id"),
    PRIMARY KEY ("ulid")
);

-- TODO: when two players play within the same colour (archon mode) they might even chose different civilisations, the civilisation being valid
-- is the civ of the player with the lower slot number (Check!!! derived from aoe2net)

CREATE UNIQUE INDEX "match_players_match_id_profile_id_slot_IDX" ON "match_players" ("match_id_ref", "profile_id_ref");
CREATE INDEX "match_players_match_id_IDX" ON "match_players" ("match_id_ref");
CREATE INDEX "match_players_profile_id_with_opponent_IDX" ON "match_players" ("profile_id_ref", "opponent_profile_id_ref");
CREATE INDEX "match_players_civ_IDX" ON "match_players" ("civ");

-- migrate:down
drop table "match_players";
