-- Postgresql
CREATE TABLE IF NOT EXISTS photos (
	id				SERIAL PRIMARY KEY,
	latitude		REAL,
	longitude		REAL,
	timestamp		BIGINT,
	jpeg_bytes		BYTEA,

	user_id			INTEGER,
	trip_id			INTEGER,

	FOREIGN KEY (user_id) REFERENCES users (id),
	FOREIGN KEY (trip_id) REFERENCES trips (id)
);