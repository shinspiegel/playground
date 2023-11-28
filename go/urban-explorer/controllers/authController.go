package controllers

import (
	"net/http"

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
	ctx.Redirect(http.StatusFound, "/dashboard")
}

func (c *AuthController) Register(ctx *gin.Context) {
	ctx.HTML(http.StatusOK, "register.html", gin.H{})
}
