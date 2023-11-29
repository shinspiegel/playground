package services

import (
	"errors"
	"urban-explorer/models"
)

type IAuthService interface {
	CheckUserPassword(email, password string) (*models.UserModel, error)
}

type AuthService struct {
	passService IPasswordService
}

func NewAuthService(passService IPasswordService) *AuthService {
	return &AuthService{
		passService: passService,
	}
}

func (s *AuthService) CheckUserPassword(email, password string) (*models.UserModel, error) {
	user, err := models.FindUserByEmail(email)
	if err != nil {
		return nil, err
	}

	isValid := s.passService.Check(password, user.PasswordHash)
	if !isValid {
		return nil, errors.New("invalid password")
	}

	return user, nil
}
