-- SQLite
CREATE TABLE IF NOT EXISTS albums (
	id		INTEGER PRIMARY KEY AUTOINCREMENT,
	title	TEXT,
	artist	TEXT,
	price	REAL
);