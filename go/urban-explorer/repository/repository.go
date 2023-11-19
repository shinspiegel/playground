package repository

import (
	"database/sql"
	"os"

	_ "github.com/mattn/go-sqlite3"
)

type Database struct {
	conn *sql.DB
}

func NewDatabase() (*Database, error) {
	dbPath := os.Getenv("HOST")
	db, err := sql.Open("sqlite3", dbPath)
	if err != nil {
		return nil, err
	}

	return &Database{conn: db}, nil
}

func (db *Database) Query(query string) (*sql.Rows, error) {
	return db.conn.Query(query)
}

func (db *Database) Close() error {
	return db.conn.Close()
}
