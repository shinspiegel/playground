package services

import (
	"mime/multipart"
	"urban-explorer/models"
	"urban-explorer/repositories"
)

type IPhotoService interface {
	AddPhoto(
		userId int64,
		tripId int64,
		image *multipart.FileHeader,
	) (*models.PhotoModel, error)
}

type PhotoService struct {
	repo      repositories.IPhotoRepository
	formImage IFormImageService
}

func NewPhotoService(r repositories.IPhotoRepository, fs IFormImageService) *PhotoService {
	return &PhotoService{
		repo:      r,
		formImage: fs,
	}
}

func (s *PhotoService) AddPhoto(
	userId int64,
	tripId int64,
	image *multipart.FileHeader,
) (*models.PhotoModel, error) {
	lat, long, err := s.formImage.GetLatLong(image)
	if err != nil {
		return nil, err
	}
	timestamp, err := s.formImage.GetTimestamp(image)
	if err != nil {
		return nil, err
	}

	return s.repo.CreatePhoto(userId, tripId, lat, long, timestamp)
}
