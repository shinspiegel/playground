package services

import (
	"errors"
	"urban-explorer/controllers/dto"
	"urban-explorer/repository"
)

type UserService struct {
	repository  repository.IUserRepo
	passService IPasswordService
	jwtService  IJwtService
}

func NewUserService(r repository.IUserRepo, s IPasswordService, j IJwtService) *UserService {
	return &UserService{
		repository:  r,
		passService: s,
		jwtService:  j,
	}
}

func (s *UserService) Login(email *string, password *string) (*dto.TokenResponse, error) {
	return &dto.TokenResponse{}, nil
}

func (s *UserService) Register(email *string, password *string) (*dto.TokenResponse, error) {
	isEmailUsed := s.repository.IsEmailUsed(email)
	if isEmailUsed {
		return nil, errors.New("email already in use")
	}

	hashPassword, err := s.passService.Hash(*password)
	if err != nil {
		return nil, errors.New("failed to hash password")
	}

	user := s.repository.InsertUser(email, &hashPassword)

	token, err := s.jwtService.Generate(user.ID)
	if err != nil {
		return nil, errors.New("failed to generate JWT token")
	}

	return &dto.TokenResponse{
		Token: token,
	}, nil
}
