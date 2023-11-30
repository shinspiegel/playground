-- SQLite
CREATE TABLE IF NOT EXISTS photos (
	id			INTEGER PRIMARY KEY AUTOINCREMENT,
	user_id		INTEGER,
	trip_id		INTEGER,

	FOREIGN KEY (user_id) REFERENCES users (id)
	FOREIGN KEY (trip_id) REFERENCES trips (id)
);