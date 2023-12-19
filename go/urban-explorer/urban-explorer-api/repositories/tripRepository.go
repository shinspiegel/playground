package repositories

import (
	"database/sql"
	"errors"
	"urban-explorer/database"
	"urban-explorer/models"
)

type ITripRepository interface {
	AddTripToPhoto(photo *models.PhotoModel) (*models.PhotoModel, error)
	CreateTrip(name string, userId int64) (*models.TripModel, error)
	DeleteById(userId int64, tripId int64) error
	FindAllByUserId(userId int64) (*[]models.TripModel, error)
	FindById(tripId int64, userId int64) (*models.TripModel, error)
	FindWithPhotosByUserId(userId int64) (*[]models.TripModel, error)
}

type TripRepository struct{}

func NewTripRepository() *TripRepository {
	return &TripRepository{}
}

func (r *TripRepository) CreateTrip(name string, userId int64) (*models.TripModel, error) {
	db := database.New()
	defer db.Close()

	rows, err := db.Query(`
		INSERT INTO trips
			(name, user_id)
		VALUES
			($1, $2)
		RETURNING
			id, name, user_id
	`,
		name, userId,
	)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	isSaved := rows.Next()
	if !isSaved {
		return nil, errors.New("failed to insert")
	}

	trip := models.TripModel{}
	rows.Scan(
		&trip.Id,
		&trip.Name,
		&trip.User_id,
	)

	return &trip, nil
}

func (r *TripRepository) FindById(tripId int64, userId int64) (*models.TripModel, error) {
	db := database.New()
	defer db.Close()

	rows, err := db.Query(`
		SELECT
			id, user_id, name
		FROM
			trips
		WHERE
			id=$1 AND user_id=$2
	`,
		tripId, userId,
	)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	hasUser := rows.Next()
	if !hasUser {
		return nil, errors.New("user id not found")
	}
	trip := models.TripModel{}
	rows.Scan(
		&trip.Id,
		&trip.User_id,
		&trip.Name,
	)

	return &trip, nil
}

func (r *TripRepository) AddTripToPhoto(photo *models.PhotoModel) (*models.PhotoModel, error) {
	trip, err := r.FindById(photo.TripId, photo.UserId)
	if err != nil {
		return nil, err
	}

	photo.Trip = trip
	return photo, nil
}

func (r *TripRepository) FindAllByUserId(userId int64) (*[]models.TripModel, error) {
	db := database.New()
	defer db.Close()

	rows, err := db.Query(`
		SELECT
			id, user_id, name
		FROM
			trips
		WHERE
			user_id=$1
	`,
		userId,
	)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	trips := []models.TripModel{}

	for rows.Next() {
		trip := models.TripModel{}
		err := rows.Scan(
			&trip.Id,
			&trip.User_id,
			&trip.Name,
		)
		if err != nil {
			return nil, err
		}

		trips = append(trips, trip)
	}

	return &trips, nil
}

func (r *TripRepository) FindWithPhotosByUserId(userId int64) (*[]models.TripModel, error) {
	db := database.New()
	defer db.Close()

	rows, err := db.Query(`
		SELECT
			trips.id as trip_id,
			trips.name as trip_name,
			photos.id as photo_id,
			photos.latitude,
			photos.longitude,
			photos.timestamp
		FROM
			trips
		LEFT JOIN
			photos ON trips.id = photos.trip_id
		WHERE
			trips.user_id=$1
		ORDER BY
			trips.id ASC, photos.timestamp DESC
	`,
		userId,
	)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	trips := []models.TripModel{}
	tripMap := map[int64]*models.TripModel{}

	for rows.Next() {
		var tripId int64
		var tripName string
		var photo models.PhotoModel
		var photoId sql.NullInt64
		var lat sql.NullFloat64
		var long sql.NullFloat64
		var time sql.NullInt64

		err := rows.Scan(
			&tripId,
			&tripName,
			&photoId,
			&lat,
			&long,
			&time,
		)
		if err != nil {
			return nil, err
		}

		trip, exists := tripMap[tripId]
		if !exists {
			newTrip := models.TripModel{
				Id:     tripId,
				Name:   tripName,
				Photos: &[]models.PhotoModel{},
			}

			tripMap[tripId] = &newTrip
			trips = append(trips, newTrip)
			trip = &newTrip
		}

		if photoId.Valid {
			photo.Id = photoId.Int64
			photo.Latitude = lat.Float64
			photo.Longitude = long.Float64
			photo.Timestamp = time.Int64
			*trip.Photos = append(*trip.Photos, photo)
		}
	}

	if err := rows.Err(); err != nil {
		return nil, err
	}

	return &trips, nil
}

func (r *TripRepository) DeleteById(userId int64, tripId int64) error {
	db := database.New()
	defer db.Close()

	_, err := db.Exec(`
		DELETE 
		FROM 
			trips
		WHERE
			id=$1 AND user_id=$2
	`,
		tripId, userId,
	)

	if err != nil {
		return err
	}

	return nil
}
