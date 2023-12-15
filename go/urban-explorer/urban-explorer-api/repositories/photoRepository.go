package repositories

import (
	"database/sql"
	"errors"
	"urban-explorer/database"
	"urban-explorer/models"
)

type IPhotoRepository interface {
	CreatePhoto(userId int64, tripId int64, latitude float64, longitude float64, timestamp int64, jpegBuf []byte) (*models.PhotoModel, error)
	GetById(userId int64, photoId int64) (*models.PhotoModel, error)
	GetPhotosByTripId(userId int64, tripId int64) (*[]models.PhotoModel, error)
	DeleteById(userId int64, photoId int64) error
	DeleteAllByTrip(userId int64, tripId int64) error
}

type PhotoRepository struct{}

func NewPhotoRepository() *PhotoRepository {
	return &PhotoRepository{}
}

func (r *PhotoRepository) CreatePhoto(userId int64, tripId int64, latitude float64, longitude float64, timestamp int64, jpegBytes []byte) (*models.PhotoModel, error) {
	db := database.New()
	defer db.Close()

	rows, err := db.Query(`
		INSERT INTO photos
			(user_id, trip_id, latitude, longitude, timestamp, jpeg_bytes)
		VALUES
			(:user_id, :trip_id, :latitude, :longitude, :timestamp, :jpeg_bytes)
		RETURNING 
			id, user_id, trip_id, latitude, longitude, timestamp, jpeg_bytes
		`,
		sql.Named("user_id", userId),
		sql.Named("trip_id", tripId),
		sql.Named("latitude", latitude),
		sql.Named("longitude", longitude),
		sql.Named("timestamp", timestamp),
		sql.Named("jpeg_bytes", jpegBytes),
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
		&photo.JpegBytes,
	)

	return &photo, nil
}

func (r *PhotoRepository) GetById(userId int64, photoId int64) (*models.PhotoModel, error) {
	db := database.New()
	defer db.Close()

	rows, err := db.Query(`
		SELECT 
			id, user_id, trip_id, latitude, longitude, timestamp, jpeg_bytes
		FROM
			photos
		WHERE
			id=:id AND user_id=:user_id
		`,
		sql.Named("id", photoId),
		sql.Named("user_id", userId),
	)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	hasPhoto := rows.Next()
	if !hasPhoto {
		return nil, errors.New("no photo by user id or photo id")
	}

	photo := models.PhotoModel{}
	rows.Scan(
		&photo.Id,
		&photo.UserId,
		&photo.TripId,
		&photo.Latitude,
		&photo.Longitude,
		&photo.Timestamp,
		&photo.JpegBytes,
	)

	return &photo, nil
}

func (r *PhotoRepository) GetPhotosByTripId(userId int64, tripId int64) (*[]models.PhotoModel, error) {
	db := database.New()
	defer db.Close()

	rows, err := db.Query(`
		SELECT 
			id, user_id, trip_id, latitude, longitude, timestamp, jpeg_bytes
		FROM
			photos
		WHERE
			trip_id = :trip_id AND user_id = :user_id
		ORDER 
			BY timestamp ASC
		`,
		sql.Named("user_id", userId),
		sql.Named("trip_id", tripId),
	)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	photos := []models.PhotoModel{}

	for rows.Next() {
		photo := models.PhotoModel{}
		err := rows.Scan(
			&photo.Id,
			&photo.UserId,
			&photo.TripId,
			&photo.Latitude,
			&photo.Longitude,
			&photo.Timestamp,
			&photo.JpegBytes,
		)

		if err != nil {
			return nil, err
		}

		photos = append(photos, photo)
	}

	return &photos, nil
}

func (r *PhotoRepository) DeleteById(userId int64, photoId int64) error {
	db := database.New()
	defer db.Close()

	_, err := db.Exec(`
		DELETE 
		FROM 
			photos
		WHERE
			id = :photo_id AND user_id = :user_id
	`,
		sql.Named("photo_id", photoId),
		sql.Named("user_id", userId),
	)
	if err != nil {
		return err
	}

	return nil
}

func (r *PhotoRepository) DeleteAllByTrip(userId int64, tripId int64) error {
	db := database.New()
	defer db.Close()

	_, err := db.Exec(`
		DELETE 
		FROM 
			photos
		WHERE
			trip_id = :trip_id AND user_id = :user_id
	`,
		sql.Named("user_id", userId),
		sql.Named("trip_id", tripId),
	)

	if err != nil {
		return err
	}

	return nil
}
