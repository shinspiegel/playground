package mocks

import (
	"urban-explorer/controllers/dto"

	"github.com/stretchr/testify/mock"
)

type UserServiceMock struct {
	mock.Mock
}

func (m *UserServiceMock) Login(email *string, password *string) (*dto.TokenResponse, error) {
	args := m.Called(email, password)
	return args.Get(0).(*dto.TokenResponse), args.Error(1)
}

func (m *UserServiceMock) Register(email *string, password *string) (*dto.TokenResponse, error) {
	args := m.Called(email, password)
	return args.Get(0).(*dto.TokenResponse), args.Error(1)
}
