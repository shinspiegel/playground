package services

import (
	"errors"
	"urban-explorer/controllers/dto"
	"urban-explorer/repository"
)

type UserService struct {
	repository repository.IUserRepo
}

func NewUserService(r repository.IUserRepo) *UserService {
	return &UserService{
		repository: r,
	}
}

func (s *UserService) Login(email *string, password *string) (*dto.TokenResponse, error) {
	return &dto.TokenResponse{}, nil
}

func (s *UserService) Register(email *string, password *string) (*dto.TokenResponse, error) {
	isEmailUsed := s.repository.IsEmailUsed(email)
	if !isEmailUsed {
		return nil, errors.New("email already in use")
	}

	// Generate salt
	// Generate hash_password
	// Save on the database

	return &dto.TokenResponse{}, nil
}
