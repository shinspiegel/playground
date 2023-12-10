package services

type IImageService interface{}

type ImageService struct{}

func NewImageService() *ImageService {
	return &ImageService{}
}
