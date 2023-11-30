package controllers

import (
	"net/http"
	"urban-explorer/config"
	"urban-explorer/services"

	"github.com/gin-gonic/gin"
)

type AuthController struct {
	context     *gin.Context
	authService services.IAuthService
	jwtService  services.IJwtService
	flags       config.Flags
}

func NewAuthController(context *gin.Context, authService services.IAuthService, jwtService services.IJwtService, flags config.Flags) *AuthController {
	return &AuthController{
		context:     context,
		authService: authService,
		jwtService:  jwtService,
		flags:       flags,
	}
}

func (c *AuthController) Login() {
	c.context.HTML(http.StatusOK, "login.html", gin.H{})
}

func (c *AuthController) CheckLogin() {
	token, err := c.authService.Login(
		c.context.Request.FormValue("email"),
		c.context.Request.FormValue("password"),
	)
	if err != nil {
		c.renderLoginError(err)
		return
	}

	c.setJwtCookie(token)
	c.context.Redirect(http.StatusFound, "/dashboard")
}

func (c *AuthController) Register() {
	token, err := c.authService.Register(
		c.context.Request.FormValue("email"),
		c.context.Request.FormValue("password"),
	)
	if err != nil {
		c.renderLoginError(err)
		return
	}

	c.setJwtCookie(token)
	c.context.Redirect(http.StatusFound, "/dashboard")
}

func (c *AuthController) renderLoginError(err error) {
	c.context.HTML(
		http.StatusBadRequest,
		"login.html",
		gin.H{
			"error":    err.Error(),
			"haserror": true,
		},
	)
}

func (c *AuthController) setJwtCookie(token *string) {
	if c.flags.IsTest {
		c.context.SetCookie("token", *token, 3600, "/", "localhost", false, false)
	} else if c.flags.IsDev {
		c.context.SetCookie("token", *token, 3600, "/", "localhost", false, false)
	} else {
		c.context.SetCookie("token", *token, 3600, "/", "jeferson.me", true, true)
	}
}
