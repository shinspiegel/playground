package database

import (
	"database/sql"
	"log"
)

type Database struct {
	conn *sql.DB
}

func New() *Database {
	db, err := newSQLite()
	if err != nil {
		log.Fatal(err)
	}
	return db
}

func (db *Database) Query(query string, args ...any) (*sql.Rows, error) {
	return db.conn.Query(query, args...)
}

func (db *Database) Exec(query string, args ...any) (sql.Result, error) {
	return db.conn.Exec(query, args...)
}

func (db *Database) Prepare(query string) (*sql.Stmt, error) {
	return db.conn.Prepare(query)
}

func (db *Database) Close() error {
	return db.conn.Close()
}
