-- migrate:up
CREATE TABLE "tbl_matches_players_relations" (
    "match_ulid_ref" TEXT(26) NOT NULL,
    "profile_ulid_ref" TEXT(26) NOT NULL,
    "civilisation_id" SMALLINT,
    "slot" SMALLINT NOT NULL, -- TODO: can two players have the same slot? when they have the same colour? archon mode!
    "team_number" SMALLINT,
    "color" SMALLINT, 
    "is_ready" BOOLEAN NOT NULL,
    "status" SMALLINT NOT NULL, -- 0=draft, 1=ongoing, 2=finished
    "has_won" BOOLEAN,
    "replay_url" TEXT NULL,
    "is_archived" BOOLEAN DEFAULT FALSE NOT NULL,
    FOREIGN KEY ("match_ulid_ref") REFERENCES "tbl_matches" ("match_ulid") ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY ("profile_ulid_ref") REFERENCES "tbl_profiles" ("profile_ulid") ON DELETE RESTRICT ON UPDATE CASCADE,
    PRIMARY KEY ("match_ulid_ref", "profile_ulid_ref")
);

-- TODO: when two players play within the same colour (archon mode) they might even chose different civilisations, the civilisation being valid
-- is the civ of the player with the lower slot number (Check!!! derived from aoe2net)

CREATE INDEX "matches_players_relation_civ_IDX" ON "tbl_matches_players_relations" ("civilisation");
CREATE INDEX "matches_players_relation_status_IDX" ON "tbl_matches_players_relations" ("status");

-- migrate:down
DROP TABLE "tbl_matches_players_relations";