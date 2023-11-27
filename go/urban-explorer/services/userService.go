package services

import (
	"errors"
	"fmt"
	"urban-explorer/constants"
	"urban-explorer/dto"
	"urban-explorer/repository"
)

type UserService struct {
	repository  repository.IUserRepo
	passService IPasswordService
	jwtService  IJwtService
	randService IRandomNumberService
}

func NewUserService(repo repository.IUserRepo, pass IPasswordService, jwt IJwtService, rand IRandomNumberService) *UserService {
	return &UserService{
		repository:  repo,
		passService: pass,
		jwtService:  jwt,
		randService: rand,
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

func (s *UserService) Recover(userId *int64) error {
	_, err := s.repository.GetUserById(userId)
	if err != nil {
		return err
	}

	rand := s.randService.generate(6)
	fmt.Println("RESET PASS" + rand)

	err = s.repository.AddRecoverCodeTo(userId, rand)
	if err != nil {
		return err
	}

	return nil
}
