package repositories

import (
	"database/sql"
	"errors"
	"urban-explorer/database"
	"urban-explorer/models"
)

type ITripRepository interface {
	CreateTrip(name string, userId int64) (*models.TripModel, error)
	FindById(id int64) (*models.TripModel, error)
	AddTripToPhoto(photo *models.PhotoModel) (*models.PhotoModel, error)
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

func (r *TripRepository) FindById(id int64) (*models.TripModel, error) {
	db := database.New()
	defer db.Close()

	rows, err := db.Query(`
		SELECT
			id, user_id, name
		FROM
			trips
		WHERE
			id = :id
	`,
		sql.Named("id", id),
	)
	if err != nil {
		return nil, err
	}

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
	trip, err := r.FindById(photo.TripId)
	if err != nil {
		return nil, err
	}

	photo.Trip = trip
	return photo, nil
}
