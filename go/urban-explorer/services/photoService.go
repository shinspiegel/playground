package services

import (
	"urban-explorer/repository"
)

type IPhotoService interface {
}

type PhotoService struct {
	repository repository.IPhotoRepo
}

func NewPhotoService(repo repository.IUserRepo) *PhotoService {
	return &PhotoService{
		repository: repo,
	}
}
