package repositories

import (
	"database/sql"
	"errors"
	"urban-explorer/database"
	"urban-explorer/models"
)

type IPhotoRepository interface {
	CreatePhoto(userId int64, tripId int64, latitude float64, longitude float64, timestamp int64) (*models.PhotoModel, error)
}

type PhotoRepository struct{}

func NewPhotoRepository() *PhotoRepository {
	return &PhotoRepository{}
}

func (r *PhotoRepository) CreatePhoto(userId int64, tripId int64, latitude float64, longitude float64, timestamp int64) (*models.PhotoModel, error) {
	db := database.New()
	defer db.Close()

	rows, err := db.Query(`
		INSERT INTO photos
			(user_id, trip_id, latitude, longitude, timestamp)
		VALUES
			(:user_id, :trip_id, :latitude, :longitude, :timestamp)
		RETURNING
			(id, user_id, trip_id, latitude, longitude, timestamp)
		`,
		sql.Named("user_id", userId),
		sql.Named("trip_id", tripId),
		sql.Named("latitude", latitude),
		sql.Named("longitude", longitude),
		sql.Named("timestamp", timestamp),
	)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	isSaved := rows.Next()
	if !isSaved {
		return nil, errors.New("failed to insert")
	}

	photo := models.PhotoModel{}
	rows.Scan(
		&photo.Id,
		&photo.UserId,
		&photo.TripId,
		&photo.Latitude,
		&photo.Longitude,
		&photo.Timestamp,
	)

	return &photo, nil
}
