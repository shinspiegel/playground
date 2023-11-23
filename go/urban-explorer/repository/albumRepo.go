package repository

import (
	"log"
	"urban-explorer/database"
	"urban-explorer/models"
)

type AlbumRepo struct {
}

func NewAlbumRepo() *AlbumRepo {
	return &AlbumRepo{}
}

func (r *AlbumRepo) GetAlbums() []models.Album {
	db, err := database.NewSQLite()
	if err != nil {
		log.Fatal(err)
	}
	defer db.Close()

	rows, err := db.Query(`
		SELECT id, title, artist, price 
		FROM albums
	`)
	if err != nil {
		log.Fatal(err)
	}
	defer rows.Close()

	list := []models.Album{}

	for rows.Next() {
		rowData := models.Album{}

		if err := rows.Scan(
			&rowData.ID,
			&rowData.Title,
			&rowData.Artist,
			&rowData.Price,
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

func (r *AlbumRepo) GetAlbumByID(id int64) []models.Album {
	db, err := database.NewSQLite()
	if err != nil {
		log.Fatal(err)
	}
	defer db.Close()

	rows, err := db.Query(`	
		SELECT id, title, artist, price 
		FROM albums
		WHERE id = ?`,
		id,
	)
	if err != nil {
		log.Fatal(err)
	}
	defer rows.Close()

	list := []models.Album{}

	for rows.Next() {
		rowData := models.Album{}

		if err := rows.Scan(
			&rowData.ID,
			&rowData.Title,
			&rowData.Artist,
			&rowData.Price,
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

func (r *AlbumRepo) InsertAlbum(album *models.Album) *models.Album {
	db, err := database.NewSQLite()
	if err != nil {
		log.Fatal(err)
	}
	defer db.Close()

	rows, err := db.Query(`
		INSERT INTO albums
			(title, artist, price)
		VALUES
			(?, ?, ?)
		RETURNING
			id`,
		album.Title,
		album.Artist,
		album.Price,
	)

	if err != nil {
		log.Fatal(err)
	}
	defer rows.Close()

	rows.Next()
	rows.Scan(&album.ID)

	return album
}
