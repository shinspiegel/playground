package services_test

import (
	"os"
	"testing"
	"time"
	"urban-explorer/services"

	"github.com/dgrijalva/jwt-go"
	"github.com/stretchr/testify/assert"
)

func TestJwtService_Generate(t *testing.T) {
	os.Setenv("JWT_SECRET", "test_secret")
	jwtService := services.NewJwtService()

	userID := int64(123)
	token, err := jwtService.Generate(userID)

	assert.Nil(t, err)
	assert.NotEmpty(t, token)
}

func TestJwtService_Validate(t *testing.T) {
	// Setup
	os.Setenv("JWT_SECRET", "test_secret")
	jwtService := services.NewJwtService()

	userID := int64(123)
	token, _ := jwtService.Generate(userID)

	claims, err := jwtService.Validate(token)

	assert.Nil(t, err)
	assert.NotNil(t, claims)
	assert.Equal(t, userID, claims.UserID)

	expiredToken, _ := jwt.NewWithClaims(jwt.SigningMethodHS256, &services.AppClaim{
		UserID: userID,
		StandardClaims: jwt.StandardClaims{
			ExpiresAt: time.Now().Add(-24 * time.Hour).Unix(),
			Issuer:    "urban-explorer",
		},
	}).SignedString([]byte("test_secret"))

	_, err = jwtService.Validate(expiredToken)
	assert.NotNil(t, err)
	assert.Equal(t, "token is expired by 24h0m0s", err.Error())
}
