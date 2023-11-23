package main

import (
	"log"
	"urban-explorer/app"
)

func main() {
	db, err := app.NewDatabase()
	if err != nil {
		log.Fatal(err)
	}
	defer db.Close()

	query(db, `
		CREATE TABLE IF NOT EXISTS albums (
			id     INTEGER PRIMARY KEY AUTOINCREMENT,
			title  TEXT,
			artist TEXT,
			price  REAL
		);
	`)
}

func query(db *app.Database, query string) {
	rows, err := db.Query(query)
	if err != nil {
		log.Fatal(err)
	}
	defer rows.Close()
}
