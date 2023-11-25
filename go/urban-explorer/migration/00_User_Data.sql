-- SQLite
CREATE TABLE IF NOT EXISTS users (
	id				INTEGER PRIMARY KEY AUTOINCREMENT,
	email			TEXT,
	password_hash	TEXT,
	is_active		INTEGER
);