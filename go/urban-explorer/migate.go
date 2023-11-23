package main

import (
	"fmt"
	"log"
	"urban-explorer/database"
)

func main() {
	db, err := database.NewSQLite()
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

func query(db *database.Database, query string) {
	rows, err := db.Query(query)
	if err != nil {
		log.Fatal(err)
	}
	defer rows.Close()

	for rows.Next() {
		fmt.Println("%v", rows)
	}
}
