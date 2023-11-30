package services

import (
	"errors"
	"urban-explorer/repositories"
)

type IAuthService interface {
	Login(email, password string) (*string, error)
	Register(email, password string) (*string, error)
}

type AuthService struct {
	jwtService  IJwtService
	passService IPasswordService
	userRepo    repositories.IUserRepository
}

func NewAuthService(passService IPasswordService, jwtService IJwtService, userRepo repositories.IUserRepository) *AuthService {
	return &AuthService{
		passService: passService,
		jwtService:  jwtService,
		userRepo:    userRepo,
	}
}

func (s *AuthService) Login(email, password string) (*string, error) {
	user, err := s.userRepo.FindByEmail(email)
	if err != nil {
		return nil, err
	}

	isValid := s.passService.Check(password, user.PasswordHash)
	if !isValid {
		return nil, errors.New("invalid password")
	}

	token, err := s.jwtService.Generate(user.ID)
	if err != nil {
		return nil, err
	}

	return &token, nil
}

func (s *AuthService) Register(email, password string) (*string, error) {
	isInUse, err := s.userRepo.IsEmailInUse(email)
	if err != nil {
		return nil, err
	}
	if isInUse {
		return nil, errors.New("email already in use")
	}

	passwordHash, err := s.passService.Hash(password)
	if err != nil {
		return nil, err
	}

	user, err := s.userRepo.Insert(email, passwordHash)
	if err != nil {
		return nil, err
	}

	token, err := s.jwtService.Generate(user.ID)
	if err != nil {
		return nil, err
	}

	return &token, nil
}
