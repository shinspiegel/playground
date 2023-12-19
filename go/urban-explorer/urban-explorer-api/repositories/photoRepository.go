package repositories

import (
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
			($1, $2, $3, $4, $5, $6)
		RETURNING 
			id, user_id, trip_id, latitude, longitude, timestamp, jpeg_bytes
		`,
		userId, tripId, latitude, longitude, timestamp, jpegBytes,
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
			id=$1 AND user_id=$2
		`,
		photoId, userId,
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
			trip_id=$1 AND user_id=$2
		ORDER BY 
			timestamp ASC
		`,
		tripId, userId,
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
			id=$1 AND user_id=$2
	`,
		photoId, userId,
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
			trip_id=$1 AND user_id=$2
	`,
		tripId, userId,
	)

	if err != nil {
		return err
	}

	return nil
}
