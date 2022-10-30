-- migrate:up
-- scopes table
INSERT INTO "tbl_scopes"
VALUES (
	"01GGKP2FZ7C1DKQQ855GJD4BHB",
	"LibreMatch Admin",
    "Administrator of the LibreMatch API"
),
(
	"01GGKP3PG6CDQ4W9K3BP6MZ4DG",
	"Tournament Admin",
    "Administrator of Tournaments"
),
(
	"01GGKP518Q4MM34YCG8QPN9A1X",
	"Tournament Organizer",
    "Organizer of Tournaments"
),
(
	"01GGKP5XS2ACGHGSN7XQ561R7K",
	"Caster",
    "Caster of Matches"
),
(
	"01GGKP8KV6RPN43SVN381ASE3A",
	"Player",
    "Player of Matches"
),
(
	"01GGKP92BGGFJ0XYR55HGZF6VJ",
	"User",
    "User of LibreMatch API"
);


-- migrate:down
DELETE FROM "tbl_scopes"; -- remove all entries from table
