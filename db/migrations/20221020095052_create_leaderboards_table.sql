-- migrate:up
CREATE TABLE "leaderboards" (
    "ulid" TEXT(26) NOT NULL,
    "leaderboard_id" INTEGER NOT NULL,
    "game" SMALLINT NOT NULL, -- 0=aoe1de, 1=aoe2de, 2=aoe3de, 3=aoe4
    "name" TEXT NOT NULL,
    PRIMARY KEY ("ulid", "game")
);

-- migrate:down
drop table "leaderboards";
