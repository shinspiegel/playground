package repository

import (
	"database/sql"
	"log"
	"urban-explorer/database"
	"urban-explorer/models"
)

type AlbumRepo struct {
}

func NewAlbumRepo() *AlbumRepo {
	return &AlbumRepo{}
}

func (r *AlbumRepo) GetAll() []models.Album {
	db := database.New()
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
	db := database.New()
	defer db.Close()

	rows := db.Query(`	
		SELECT id, title, artist, price 
		FROM albums
		WHERE id = :id
		`,
		sql.Named("id", id),
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
	db := database.New()
	defer db.Close()

	rows := db.Query(`
		INSERT INTO albums
			(title, artist, price)
		VALUES
			(:title, :artist, :price)
		RETURNING
			id
		`,
		sql.Named("title", album.Title),
		sql.Named("artist", album.Artist),
		sql.Named("price", album.Price),
	)

	defer rows.Close()

	rows.Next()
	rows.Scan(&album.ID)

	return album
}

func (r *AlbumRepo) Update(album *models.Album) *models.Album {
	db := database.New()
	defer db.Close()

	rows := db.Query(`
		UPDATE albums
		SET title = :title, artist = :artist, price = :price
		WHERE id = :id
	`,
		sql.Named("id", album.ID),
		sql.Named("title", album.Title),
		sql.Named("artist", album.Artist),
		sql.Named("price", album.Price),
	)
	defer rows.Close()

	if err := rows.Err(); err != nil {
		log.Fatal(err)
	}

	return album
}

func (r *AlbumRepo) DeleteById(id int64) {
	db := database.New()
	defer db.Close()

	db.Exec(`
		DELETE FROM albums
		WHERE id = :id
	`,
		sql.Named("id", id),
	)
}
