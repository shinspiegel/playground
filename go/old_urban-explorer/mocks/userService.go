package mocks

import (
	"urban-explorer/dto"

	"github.com/stretchr/testify/mock"
)

type UserServiceMock struct {
	mock.Mock
}

func (m *UserServiceMock) Login(email *string, password *string) (*dto.UserTokenResponse, error) {
	args := m.Called(email, password)
	return args.Get(0).(*dto.UserTokenResponse), args.Error(1)
}

func (m *UserServiceMock) Register(email *string, password *string) (*dto.UserTokenResponse, error) {
	args := m.Called(email, password)
	return args.Get(0).(*dto.UserTokenResponse), args.Error(1)
}
