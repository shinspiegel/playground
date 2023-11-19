package repository

import (
	"database/sql"

	_ "github.com/mattn/go-sqlite3"
)

type Database struct {
	conn *sql.DB
}

func NewDatabase() (*Database, error) {
	db, err := sql.Open("sqlite3", "database.sqlite")
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
