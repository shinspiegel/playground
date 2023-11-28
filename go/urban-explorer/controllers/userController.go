package controllers

import (
	"net/http"

	"github.com/gin-gonic/gin"

	"urban-explorer/models"
)

func GetUser(c *gin.Context) {
	user := models.User{ID: 1, Name: "John Doe", Email: "john@example.com"}
	c.HTML(http.StatusOK, "user.html", gin.H{
		"Name":  user.Name,
		"Email": user.Email,
	})
}
