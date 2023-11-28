package controllers

import (
	"net/http"

	"github.com/gin-gonic/gin"

	"urban-explorer/models"
)

type UserController struct{}

func NewUserController() *UserController {
	return &UserController{}
}

func (c *UserController) GetUser(ctx *gin.Context) {
	user := models.User{ID: 1, Name: "John Doe", Email: "john@example.com"}
	ctx.HTML(http.StatusOK, "user.html", gin.H{
		"Name":  user.Name,
		"Email": user.Email,
	})
}
