package main

import (
	"log"
	"urban-explorer/app"
	"urban-explorer/repository"
)

func main() {
	db, err := app.NewDatabase()
	if err != nil {
		log.Fatal(err)
	}
	defer db.Close()

	createUserTabe(db)
	insert(db)
	selectUsers(db)
}

func createUserTabe(db *app.Database) {
	rows, err := db.Query(`
		CREATE TABLE IF NOT EXISTS users (
			id INTEGER PRIMARY KEY AUTOINCREMENT,
			username TEXT
		);
	`)
	if err != nil {
		log.Fatal(err)
	}
	defer rows.Close()

	for rows.Next() {
		var id int
		var name string
		if err := rows.Scan(&id, &name); err != nil {
			log.Fatal(err)
		}
		log.Printf("ID: %d, Name: %s\n", id, name)
	}

	if err := rows.Err(); err != nil {
		log.Fatal(err)
	}
}

func insert(db *repository.Database) {
	rows, err := db.Query(`
		INSERT INTO users (username)
		VALUES ('admin');
	`)
	if err != nil {
		log.Fatal(err)
	}
	defer rows.Close()

	for rows.Next() {
		var id int
		var name string
		if err := rows.Scan(&id, &name); err != nil {
			log.Fatal(err)
		}
		log.Printf("ID: %d, Name: %s\n", id, name)
	}

	if err := rows.Err(); err != nil {
		log.Fatal(err)
	}
}

func selectUsers(db *repository.Database) {
	rows, err := db.Query(`
		SELECT * FROM users;
	`)
	if err != nil {
		log.Fatal(err)
	}
	defer rows.Close()

	for rows.Next() {
		var id int
		var name string
		if err := rows.Scan(&id, &name); err != nil {
			log.Fatal(err)
		}
		log.Printf("ID: %d, Name: %s\n", id, name)
	}

	if err := rows.Err(); err != nil {
		log.Fatal(err)
	}
}
