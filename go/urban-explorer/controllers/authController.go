package controllers

import (
	"log"
	"net/http"
	"urban-explorer/models"

	"github.com/gin-gonic/gin"
)

type AuthController struct{}

func NewAuthController() *AuthController {
	return &AuthController{}
}

func (c *AuthController) Login(ctx *gin.Context) {
	ctx.HTML(http.StatusOK, "login.html", gin.H{})
}

func (c *AuthController) CheckLogin(ctx *gin.Context) {
	// password := ctx.Request.FormValue("password")

	// fmt.Print(email, password)
	user, err := models.FindUserByEmail(ctx.Request.FormValue("email"))
	if err != nil {
		log.Fatal(err)
	}

	// Compare password with hash
	// Redirect or send back to login with failed state
	// ctx.Redirect(http.StatusFound, "/dashboard")
}

func (c *AuthController) Register(ctx *gin.Context) {
	ctx.HTML(http.StatusOK, "register.html", gin.H{})
}
