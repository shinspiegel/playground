package services_test

import (
	"testing"
	"urban-explorer/services"

	"github.com/stretchr/testify/assert"
)

func TestPasswordService_Hash(t *testing.T) {
	passwordService := services.NewPasswordService()

	password := "myPassword123"
	hashedPassword, err := passwordService.Hash(password)

	assert.Nil(t, err)
	assert.NotEmpty(t, hashedPassword)
}

func TestPasswordService_Check(t *testing.T) {
	passwordService := services.NewPasswordService()
	password := "123456"
	hashedPassword, _ := passwordService.Hash(password)

	result := passwordService.Check(password, hashedPassword)
	assert.True(t, result)

	result = passwordService.Check("wrongPassword", hashedPassword)
	assert.False(t, result)
}
