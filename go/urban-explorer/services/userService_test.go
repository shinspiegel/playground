package services_test

import (
	"testing"
	"urban-explorer/mocks"
	"urban-explorer/models"
	"urban-explorer/services"

	"github.com/stretchr/testify/assert"
)

func TestUserService_Login(t *testing.T) {
	userRepoMock := new(mocks.UserRepoMock)
	passServiceMock := new(mocks.PasswordServiceMock)
	jwtServiceMock := new(mocks.JwtServiceMock)

	userService := services.NewUserService(userRepoMock, passServiceMock, jwtServiceMock)

	email := "test@example.com"
	password := "password123"
	hashedPassword := "hashedPassword123"
	user := &models.User{ID: 1, Email: email, Password: hashedPassword}

	userRepoMock.On("GetUserByEmail", &email).Return(user, nil)
	passServiceMock.On("Check", password, hashedPassword).Return(true)
	jwtServiceMock.On("Generate", user.ID).Return("token123", nil)

	tokenResponse, err := userService.Login(&email, &password)

	assert.NoError(t, err)
	assert.NotNil(t, tokenResponse)
	assert.Equal(t, "token123", tokenResponse.Token)

	userRepoMock.AssertExpectations(t)
	passServiceMock.AssertExpectations(t)
	jwtServiceMock.AssertExpectations(t)
}

func TestUserService_Register(t *testing.T) {
	userRepoMock := new(mocks.UserRepoMock)
	passServiceMock := new(mocks.PasswordServiceMock)
	jwtServiceMock := new(mocks.JwtServiceMock)

	userService := services.NewUserService(userRepoMock, passServiceMock, jwtServiceMock)

	email := "new@example.com"
	password := "newPassword123"
	hashedPassword := "hashedNewPassword123"
	newUser := &models.User{ID: 2, Email: email, Password: hashedPassword}

	userRepoMock.On("IsEmailUsed", &email).Return(false)
	passServiceMock.On("Hash", password).Return(hashedPassword, nil)
	userRepoMock.On("InsertUser", &email, &hashedPassword).Return(newUser)
	jwtServiceMock.On("Generate", newUser.ID).Return("newToken123", nil)

	tokenResponse, err := userService.Register(&email, &password)

	assert.NoError(t, err)
	assert.NotNil(t, tokenResponse)
	assert.Equal(t, "newToken123", tokenResponse.Token)

	userRepoMock.AssertExpectations(t)
	passServiceMock.AssertExpectations(t)
	jwtServiceMock.AssertExpectations(t)
}
