package mocks

import (
	"urban-explorer/services"

	"github.com/stretchr/testify/mock"
)

type JwtServiceMock struct {
	mock.Mock
}

func (m *JwtServiceMock) Generate(userId int64) (string, error) {
	args := m.Called(userId)
	return args.String(0), args.Error(1)
}

func (m *JwtServiceMock) Validate(token string) (*services.AppClaim, error) {
	args := m.Called(token)
	return args.Get(0).(*services.AppClaim), args.Error(1)
}
