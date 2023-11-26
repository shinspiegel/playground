package services

import (
	"errors"
	"urban-explorer/constants"
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
	user, err := s.repository.GetUserByEmail(email)
	if err != nil {
		return nil, err
	}

	isPasswordCheck := s.passService.Check(*password, user.Password)
	if !isPasswordCheck {
		return nil, errors.New(constants.MissMatchPassword)
	}

	token, err := s.jwtService.Generate(user.ID)
	if err != nil {
		return nil, errors.New(constants.FailedGenerateJWT)
	}

	return &dto.TokenResponse{
		Token: token,
	}, nil
}

func (s *UserService) Register(email *string, password *string) (*dto.TokenResponse, error) {
	isEmailUsed := s.repository.IsEmailUsed(email)
	if isEmailUsed {
		return nil, errors.New(constants.EmailInUse)
	}

	hashPassword, err := s.passService.Hash(*password)
	if err != nil {
		return nil, errors.New(constants.FailedToHash)
	}

	user := s.repository.InsertUser(email, &hashPassword)

	token, err := s.jwtService.Generate(user.ID)
	if err != nil {
		return nil, errors.New(constants.FailedGenerateJWT)
	}

	return &dto.TokenResponse{
		Token: token,
	}, nil
}
