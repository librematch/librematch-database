-- migrate:up
-- scopes table
INSERT INTO "tbl_scopes"
VALUES (
	"01GGKP2FZ7C1DKQQ855GJD4BHB",
	"LibreMatch Admin",
	NULL,
    "Administrator of the LibreMatch API"
),
(
	"01GGKP3PG6CDQ4W9K3BP6MZ4DG",
	"Tournament Admin",
	NULL,
    "Administrator of Tournaments"
),
(
	"01GGKP518Q4MM34YCG8QPN9A1X",
	"Tournament Organizer",
	NULL,
    "Organizer of Tournaments"
),
(
	"01GGKP5XS2ACGHGSN7XQ561R7K",
	"Caster",
	NULL,
    "Caster of Matches"
),
(
	"01GGKP8KV6RPN43SVN381ASE3A",
	"Player",
	NULL,
    "Player of Matches"
),
(
	"01GGKP92BGGFJ0XYR55HGZF6VJ",
	"User",
	NULL,
    "User of LibreMatch API"
);


-- migrate:down
DELETE FROM "tbl_scopes"; -- remove all entries from table
