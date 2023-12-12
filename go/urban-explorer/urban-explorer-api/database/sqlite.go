package database

import (
	"database/sql"
	"os"

	_ "github.com/mattn/go-sqlite3"
)

func newSQLite() (*Database, error) {
	dbPath := os.Getenv("DATABASE")
	db, err := sql.Open("sqlite3", dbPath)
	if err != nil {
		return nil, err
	}

	return &Database{conn: db}, nil
}
