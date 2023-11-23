package repository

import (
	"log"
	"urban-explorer/app"
	"urban-explorer/models"
)

func GetAlbums() []models.Album {
	db, err := app.NewDatabase()
	if err != nil {
		log.Fatal(err)
	}
	defer db.Close()

	rows, err := db.Query(`
		SELECT id, title, artist, price 
		FROM users
	`)
	if err != nil {
		log.Fatal(err)
	}
	defer rows.Close()

	list := []models.Album{}

	for rows.Next() {
		rowData := models.Album{}

		if err := rows.Scan(
			rowData.ID,
			rowData.Title,
			rowData.Artist,
			rowData.Price,
		); err != nil {
			log.Fatal(err)
		}

		list = append(list, rowData)
	}

	if err := rows.Err(); err != nil {
		log.Fatal(err)
	}

	return list
}

func InsertAlbum(album *models.Album) (*models.Album, error) {
	db, err := app.NewDatabase()
	if err != nil {
		log.Fatal(err)
	}
	defer db.Close()

	stmt, err := db.Prepare(`
		INSERT INTO albums
			(title, artist, price)
		VALUES
			(?, ?, ?)
		RETURNING
			id
	`)
	defer stmt.Close()

	result, err := stmt.Exec(
		album.Title,
		album.Artist,
		album.Price,
	)
	if err != nil {
		return nil, err
	}

	id, err := result.LastInsertId()
	if err != nil {
		return nil, err
	}

	album.ID = id

	return album, nil

}
