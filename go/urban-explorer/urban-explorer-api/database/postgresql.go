package database

import (
	"database/sql"
	"os"

	_ "github.com/lib/pq"
)

func newPostgres() (*Database, error) {
	dbConnString := os.Getenv("DATABASE")
	db, err := sql.Open("postgres", dbConnString)
	if err != nil {
		return nil, err
	}

	err = db.Ping()
	if err != nil {
		return nil, err
	}

	return &Database{conn: db}, nil
}
