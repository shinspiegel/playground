package controllers_test

import (
	"bytes"
	"encoding/json"
	"net/http"
	"net/http/httptest"
	"testing"
	"urban-explorer/controllers"
	"urban-explorer/controllers/dto"
	"urban-explorer/mocks"

	"github.com/gin-gonic/gin"
	"github.com/stretchr/testify/assert"
)

func TestUserController_Login(t *testing.T) {
	gin.SetMode(gin.TestMode)

	userServiceMock := new(mocks.UserServiceMock)
	userController := controllers.NewUserController(userServiceMock)

	email := "test@example.com"
	password := "password123"
	tokenResponse := &dto.TokenResponse{Token: "testToken"}

	userServiceMock.On("Login", &email, &password).Return(tokenResponse, nil)

	router := gin.Default()
	router.POST("/login", userController.Login)

	requestBody, _ := json.Marshal(dto.LoginBody{Email: email, Password: password})
	req, _ := http.NewRequest(http.MethodPost, "/login", bytes.NewBuffer(requestBody))
	w := httptest.NewRecorder()

	router.ServeHTTP(w, req)

	assert.Equal(t, http.StatusCreated, w.Code)
	userServiceMock.AssertExpectations(t)
}
