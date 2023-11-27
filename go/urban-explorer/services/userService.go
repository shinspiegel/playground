package services

import (
	"errors"
	"fmt"
	"urban-explorer/constants"
	"urban-explorer/dto"
	"urban-explorer/repository"
)

type IUserService interface {
	Login(name *string, password *string) (*dto.UserTokenResponse, error)
	Register(name *string, password *string) (*dto.UserTokenResponse, error)
	Recover(email *string) error
	ResetPass(email, recoverCode, password *string) (*dto.UserTokenResponse, error)
}

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

func (s *UserService) Login(email *string, password *string) (*dto.UserTokenResponse, error) {
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

	return &dto.UserTokenResponse{
		Token: token,
	}, nil
}

func (s *UserService) Register(email *string, password *string) (*dto.UserTokenResponse, error) {
	isEmailUsed, err := s.repository.IsEmailUsed(email)
	if err != nil {
		return nil, err
	}
	if isEmailUsed {
		return nil, errors.New(constants.EmailInUse)
	}

	hashPassword, err := s.passService.Hash(*password)
	if err != nil {
		return nil, errors.New(constants.FailedToHash)
	}

	user, err := s.repository.InsertUser(email, &hashPassword)
	if err != nil {
		return nil, err
	}

	token, err := s.jwtService.Generate(user.ID)
	if err != nil {
		return nil, errors.New(constants.FailedGenerateJWT)
	}

	return &dto.UserTokenResponse{
		Token: token,
	}, nil
}

func (s *UserService) Recover(email *string) error {
	user, err := s.repository.GetUserByEmail(email)
	if err != nil {
		return err
	}

	rand := s.randService.generate(6)
	fmt.Println("RESET PASS::" + rand)

	_, err = s.repository.AddRecoverCodeBy(&user.ID, &rand)
	if err != nil {
		return err
	}

	return nil
}

func (s *UserService) ResetPass(email *string, recoverCode *string, password *string) (*dto.UserTokenResponse, error) {
	user, err := s.repository.GetUserByEmail(email)
	if err != nil {
		return nil, err
	}

	if user.RecoverCode != *recoverCode {
		return nil, errors.New(constants.MissMatchRecoverCode)
	}

	hashPassword, err := s.passService.Hash(*password)
	if err != nil {
		return nil, errors.New(constants.FailedToHash)
	}

	_, err = s.repository.UpdatePassword(&user.ID, &hashPassword)
	if err != nil {
		return nil, err
	}

	token, err := s.jwtService.Generate(user.ID)
	if err != nil {
		return nil, errors.New(constants.FailedGenerateJWT)
	}

	return &dto.UserTokenResponse{
		Token: token,
	}, nil
}
