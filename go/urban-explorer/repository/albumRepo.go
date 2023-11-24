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

func (r *AlbumRepo) getDB() *database.Database {
	db, err := database.NewSQLite()
	if err != nil {
		log.Fatal(err)
	}
	return db
}

func (r *AlbumRepo) GetAll() []models.Album {
	db := r.getDB()
	defer db.Close()

	rows := db.Query(`
		SELECT id, title, artist, price 
		FROM albums
	`)
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

func (r *AlbumRepo) GetById(id int64) []models.Album {
	db := r.getDB()
	defer db.Close()

	rows := db.Query(`	
		SELECT id, title, artist, price 
		FROM albums
		WHERE id = ?`,
		id,
	)
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

func (r *AlbumRepo) Insert(album *models.Album) *models.Album {
	db := r.getDB()
	defer db.Close()

	rows := db.Query(`
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

	defer rows.Close()

	rows.Next()
	rows.Scan(&album.ID)

	return album
}

func (r *AlbumRepo) Update(album *models.Album) *models.Album {
	return album
}

func (r *AlbumRepo) DeleteById(id int64) *models.Album {
	return &models.Album{}
}
