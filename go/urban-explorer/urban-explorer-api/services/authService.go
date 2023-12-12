package services

import (
	"errors"
	"fmt"
	"strings"
	"urban-explorer/repositories"
)

type IAuthService interface {
	Login(email, password string) (*string, error)
	Register(email, password string) (*string, error)
	Recover(email string) (*string, error)
	RecoverCode(code string, email string, password string) (*string, error)
}

type AuthService struct {
	cookiesService ICookiesService
	jwtService     IJwtService
	passService    IPasswordService
	randService    IRandomNumberService
	userRepo       repositories.IUserRepository
}

func NewAuthService(
	ps IPasswordService,
	js IJwtService,
	cs ICookiesService,
	rs IRandomNumberService,
	ur repositories.IUserRepository,
) *AuthService {
	return &AuthService{
		passService:    ps,
		jwtService:     js,
		cookiesService: cs,
		randService:    rs,
		userRepo:       ur,
	}
}

func (s *AuthService) Login(email, password string) (*string, error) {
	user, err := s.userRepo.FindByEmail(email)
	if err != nil {
		return nil, err
	}

	isValid := s.passService.Check(password, user.PasswordHash)
	if !isValid {
		return nil, errors.New("invalid email or password")
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

func (s *AuthService) Recover(email string) (*string, error) {
	recoverCode := s.randService.generate(8)

	_, err := s.userRepo.UpdateRecoverByEmail(email, recoverCode)
	if err != nil {
		return nil, err
	}

	// TODO: Create email sender
	fmt.Println("CODE::" + recoverCode)

	return &recoverCode, nil
}

func (s *AuthService) RecoverCode(code string, email string, password string) (*string, error) {
	user, err := s.userRepo.FindByEmail(email)
	if err != nil {
		return nil, err
	}

	if strings.Compare(user.RecoverCode, code) == 0 {
		return nil, errors.New("invalid or missing recovery code")
	}

	passwordHash, err := s.passService.Hash(password)
	if err != nil {
		return nil, err
	}

	user, err = s.userRepo.UpdateUserPassword(user.ID, passwordHash)
	if err != nil {
		return nil, err
	}

	token, err := s.jwtService.Generate(user.ID)
	if err != nil {
		return nil, err
	}

	return &token, nil
}
