package repositories

import (
	"database/sql"
	"errors"
	"urban-explorer/database"
	"urban-explorer/models"
)

type ITripRepository interface {
	CreateTrip(name string, userId int64) (*models.TripModel, error)
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
