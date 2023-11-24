package database

import (
	"database/sql"
	"log"
	"os"

	_ "github.com/mattn/go-sqlite3"
)

type Database struct {
	conn *sql.DB
}

func NewSQLite() (*Database, error) {
	dbPath := os.Getenv("DATABASE")
	db, err := sql.Open("sqlite3", dbPath)
	if err != nil {
		return nil, err
	}

	return &Database{conn: db}, nil
}

func (db *Database) Query(query string, args ...any) *sql.Rows {
	rows, err := db.conn.Query(query, args...)
	if err != nil {
		log.Fatal(err)
	}

	return rows
}

func (db *Database) Prepare(query string) *sql.Stmt {
	stmt, err := db.conn.Prepare(query)
	if err != nil {
		log.Fatal(err)
	}
	return stmt
}

func (db *Database) Close() error {
	return db.conn.Close()
}
