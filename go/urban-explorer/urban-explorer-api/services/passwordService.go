package services

import "golang.org/x/crypto/bcrypt"

type IPasswordService interface {
	Hash(password string) (string, error)
	Check(password string, hashedPassword string) bool
}

type PasswordService struct{}

func NewPasswordService() *PasswordService {
	return &PasswordService{}
}

func (s *PasswordService) Hash(password string) (string, error) {
	bytes, err := bcrypt.GenerateFromPassword([]byte(password), bcrypt.DefaultCost)
	if err != nil {
		return "", err
	}
	return string(bytes), nil
}

func (s *PasswordService) Check(password, hashedPassword string) bool {
	err := bcrypt.CompareHashAndPassword([]byte(hashedPassword), []byte(password))
	return err == nil
}
