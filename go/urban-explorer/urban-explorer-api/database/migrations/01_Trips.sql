-- Postgresql
CREATE TABLE IF NOT EXISTS trips (
	id			SERIAL PRIMARY KEY,
	user_id		INTEGER,
	name		TEXT,
	
	FOREIGN KEY (user_id) REFERENCES users (id)
);