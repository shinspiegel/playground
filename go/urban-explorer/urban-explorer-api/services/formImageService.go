package services

import (
	"mime/multipart"

	"github.com/rwcarlsen/goexif/exif"
)

type IFormImageService interface {
	GetLatLong(fileHeader *multipart.FileHeader) (float64, float64, error)
	GetTimestamp(fileHeader *multipart.FileHeader) (int64, error)
}

type FormImageService struct{}

func NewFormImageService() *FormImageService {
	return &FormImageService{}
}

func (s *FormImageService) GetLatLong(fileHeader *multipart.FileHeader) (float64, float64, error) {
	file, err := fileHeader.Open()
	if err != nil {
		return 0, 0, err
	}
	defer file.Close()

	exifData, err := exif.Decode(file)
	if err != nil {
		return 0, 0, err
	}

	lat, long, err := exifData.LatLong()
	if err != nil {
		return 0, 0, err
	}

	return lat, long, nil
}

func (s *FormImageService) GetTimestamp(fileHeader *multipart.FileHeader) (int64, error) {
	file, err := fileHeader.Open()
	if err != nil {
		return 0, err
	}
	defer file.Close()

	exifData, err := exif.Decode(file)
	if err != nil {
		return 0, err
	}

	time, err := exifData.DateTime()
	if err != nil {
		return 0, nil
	}

	return time.UnixMilli(), nil
}
