package services

import (
	"errors"
	"mime/multipart"
	"urban-explorer/models"
	"urban-explorer/repositories"
)

type IPhotoService interface {
	AddPhoto(userId int64, tripId int64, image *multipart.FileHeader) (*models.PhotoModel, error)
	GetById(photoId int64, userId int64) (*models.PhotoModel, error)
}

type PhotoService struct {
	photoRepo        repositories.IPhotoRepository
	formImageService IFormImageService
	imageService     IImageService
}

func NewPhotoService(r repositories.IPhotoRepository, fs IFormImageService, is IImageService) *PhotoService {
	return &PhotoService{
		photoRepo:        r,
		formImageService: fs,
		imageService:     is,
	}
}

func (s *PhotoService) AddPhoto(userId int64, tripId int64, image *multipart.FileHeader) (*models.PhotoModel, error) {
	if image.Header.Get("Content-Type") != "image/jpeg" {
		return nil, errors.New("image must be jpeg")
	}

	lat, long, err := s.formImageService.GetLatLong(image)
	if err != nil {
		return nil, err
	}

	timestamp, err := s.formImageService.GetTimestamp(image)
	if err != nil {
		return nil, err
	}

	resizeOpt := ResizeOptions{Height: 500, Width: 500, Quality: 70}
	imageBytes, err := s.imageService.ResizeForDB(image, &resizeOpt)
	if err != nil {
		return nil, err
	}

	return s.photoRepo.CreatePhoto(userId, tripId, lat, long, timestamp, *imageBytes)
}

func (s *PhotoService) GetById(photoId int64, userId int64) (*models.PhotoModel, error) {
	photo, err := s.photoRepo.GetById(photoId, userId)
	if err != nil {
		return nil, err
	}

	return photo, nil
}
