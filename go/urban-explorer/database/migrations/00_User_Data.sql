-- SQLite
CREATE TABLE IF NOT EXISTS users (
	id				INTEGER PRIMARY KEY AUTOINCREMENT,
	email			TEXT,
	password_hash	TEXT,
	recover_code	TEXT,
);