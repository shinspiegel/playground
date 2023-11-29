package controllers

import (
	"net/http"
	"urban-explorer/config"
	"urban-explorer/services"

	"github.com/gin-gonic/gin"
)

type AuthController struct {
	authService services.IAuthService
	jwtService  services.IJwtService
	flags       config.Flags
}

func NewAuthController(authService services.IAuthService, jwtService services.IJwtService, flags config.Flags) *AuthController {
	return &AuthController{
		authService: authService,
		jwtService:  jwtService,
		flags:       flags,
	}
}

func (c *AuthController) Login(ctx *gin.Context) {
	ctx.HTML(http.StatusOK, "login.html", gin.H{})
}

func (c *AuthController) CheckLogin(ctx *gin.Context) {
	user, err := c.authService.CheckUserPassword(
		ctx.Request.FormValue("email"),
		ctx.Request.FormValue("password"),
	)
	if err != nil {
		ctx.HTML(
			http.StatusBadRequest,
			"login.html",
			gin.H{
				"error":    err.Error(),
				"hasError": true,
			},
		)
		return
	}

	token, err := c.jwtService.Generate(user.ID)
	if err != nil {
		ctx.HTML(
			http.StatusBadRequest,
			"login.html",
			gin.H{
				"error":    err.Error(),
				"hasError": true,
			},
		)
		return
	}

	if c.flags.IsTest {
		ctx.SetCookie("token", token, 3600, "/", "localhost", false, false)
	} else if c.flags.IsDev {
		ctx.SetCookie("token", token, 3600, "/", "localhost", false, false)
	} else {
		ctx.SetCookie("token", token, 3600, "/", "jeferson.me", true, true)
	}

	ctx.Redirect(http.StatusFound, "/dashboard")
}

func (c *AuthController) Register(ctx *gin.Context) {
	ctx.HTML(http.StatusOK, "register.html", gin.H{})
}
