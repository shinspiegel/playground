package services

import (
	"urban-explorer/models"
	"urban-explorer/repositories"
)

type ITripService interface {
	CreateTrip(name string, userId int64) (*models.TripModel, error)
	GetById(tripId int64, userId int64) (*models.TripModel, error)
	GetByUserId(userId int64) (*[]models.TripModel, error)
	DeleteTripAndPhotos(userId int64, tripId int64) error
}

type TripService struct {
	tripRepo  repositories.ITripRepository
	photoRepo repositories.IPhotoRepository
}

func NewTripService(tr repositories.ITripRepository, pr repositories.IPhotoRepository) *TripService {
	return &TripService{
		tripRepo:  tr,
		photoRepo: pr,
	}
}

func (s *TripService) CreateTrip(name string, userId int64) (*models.TripModel, error) {
	return s.tripRepo.CreateTrip(name, userId)
}

func (s *TripService) GetById(tripId int64, userId int64) (*models.TripModel, error) {
	return s.tripRepo.FindById(tripId, userId)
}

func (s *TripService) GetByUserId(userId int64) (*[]models.TripModel, error) {
	return s.tripRepo.FindAllByUserId(userId)
}

func (s *TripService) DeleteTripAndPhotos(userId int64, tripId int64) error {
	err := s.photoRepo.DeleteAllByTrip(userId, tripId)
	if err != nil {
		return err
	}

	err = s.tripRepo.DeleteById(userId, tripId)
	if err != nil {
		return err
	}

	return nil
}
