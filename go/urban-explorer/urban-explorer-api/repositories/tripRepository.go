package repositories

import (
	"database/sql"
	"errors"
	"urban-explorer/database"
	"urban-explorer/models"
)

type ITripRepository interface {
	CreateTrip(name string, userId int64) (*models.TripModel, error)
	FindById(tripId int64, userId int64) (*models.TripModel, error)
	AddTripToPhoto(photo *models.PhotoModel) (*models.PhotoModel, error)
	FindAllByUserId(userId int64) (*[]models.TripModel, error)
	DeleteById(userId int64, tripId int64) error
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
			(:name, :user_id)
		RETURNING
			id, name, user_id
	`,
		sql.Named("name", name),
		sql.Named("user_id", userId),
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
			id = :trip_id AND user_id = :user_id
	`,
		sql.Named("trip_id", tripId),
		sql.Named("user_id", userId),
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
			user_id = :user_id
	`,
		sql.Named("user_id", userId),
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

func (r *TripRepository) DeleteById(userId int64, tripId int64) error {
	db := database.New()
	defer db.Close()

	_, err := db.Exec(`
		DELETE 
		FROM 
			trips
		WHERE
			id = :trip_id AND user_id = :user_id
	`,
		sql.Named("trip_id", tripId),
		sql.Named("user_id", userId),
	)

	if err != nil {
		return err
	}

	return nil
}
