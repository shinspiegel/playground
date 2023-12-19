-- Postgresql
CREATE TABLE IF NOT EXISTS users (
	id				SERIAL PRIMARY KEY,
	email			TEXT,
	password_hash	TEXT,
	recover_code	TEXT
);