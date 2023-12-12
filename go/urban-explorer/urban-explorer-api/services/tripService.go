package services

import (
	"urban-explorer/models"
	"urban-explorer/repositories"
)

type ITripService interface {
	CreateTrip(name string, userId int64) (*models.TripModel, error)
}

type TripService struct {
	repo repositories.ITripRepository
}

func NewTripService(r repositories.ITripRepository) *TripService {
	return &TripService{
		repo: r,
	}
}

func (s *TripService) CreateTrip(name string, userId int64) (*models.TripModel, error) {
	return s.repo.CreateTrip(name, userId)
}
