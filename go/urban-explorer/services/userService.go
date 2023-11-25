package services

import "urban-explorer/controllers/dto"

type UserService struct{}

func NewUserService() *UserService {
	return &UserService{}
}

func (s *UserService) Login(email *string, password *string) *dto.TokenResponse {
	return &dto.TokenResponse{}
}

func (s *UserService) Register(name *string, password *string) *dto.TokenResponse {
	return &dto.TokenResponse{}
}
