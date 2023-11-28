package mocks

import (
	"urban-explorer/models"

	"github.com/stretchr/testify/mock"
)

type UserRepoMock struct {
	mock.Mock
}

func (m *UserRepoMock) IsEmailUsed(email *string) bool {
	args := m.Called(email)
	return args.Bool(0)
}

func (m *UserRepoMock) InsertUser(email *string, hashPassword *string) *models.User {
	args := m.Called(email, hashPassword)
	return args.Get(0).(*models.User)
}

func (m *UserRepoMock) GetUserByEmail(email *string) (*models.User, error) {
	args := m.Called(email)
	return args.Get(0).(*models.User), args.Error(1)
}
