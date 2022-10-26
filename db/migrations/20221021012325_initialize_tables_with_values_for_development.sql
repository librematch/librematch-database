-- migrate:up
-- games table
INSERT INTO "games" VALUES (
	"01GFW0Y21VQ5RVWQC12P1TCMF2",
	"aoe1de",
	"Age of Empires: Definitive Edition",
	"2018-02-20 00:00:00",
	"https://store.steampowered.com/app/1017900/Age_of_Empires_Definitive_Edition/",
	"https://www.microsoft.com/store/productId/9NJWTJSVGVLJ"
);

INSERT INTO "games" VALUES (
	"01GFW0YE9H2MRVX4838YK3SA7E",
	"aoe2de",
	"Age of Empires II: Definitive Edition",
	"2019-11-14 00:00:00",
	"https://store.steampowered.com/app/813780/Age_of_Empires_II_Definitive_Edition/",
	"https://www.microsoft.com/store/productId/9NJDD0JGPP2Q"
);

INSERT INTO "games" VALUES (
	"01GFW0YPWW6YSPG2QAKT9SGNJF",
	"aoe3de",
	"Age of Empires III: Definitive Edition",
	"2020-10-15 00:00:00",
	"https://store.steampowered.com/app/933110/Age_of_Empires_III_Definitive_Edition/",
	"https://www.microsoft.com/store/productId/9N1HF804QXN4"
);

INSERT INTO "games" VALUES (
	"01GFW0Z04XQVFQ3SAZDGXBQ203",
	"aoe4",
	"Age of Empires IV",
	"2021-10-28 00:00:00",
	"https://store.steampowered.com/app/1466860/Age_of_Empires_IV/",
	"https://www.microsoft.com/store/productId/9N94NCGM1Q2N"
);

INSERT INTO "games" VALUES (
	"01GGAB7YPC6M8XV6YZCK4S21E0",
	"aomr",
	"Age of Mythology: Retold",
	null,
	"still not available for pre-order on Steam",
	"still not available for pre-order on Microsoft Store"
);

-- migrate:down
delete from "games"; -- remove all entries from table
