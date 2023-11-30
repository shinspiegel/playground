package controllers

import (
	"net/http"
	"urban-explorer/config"
	"urban-explorer/services"

	"github.com/gin-gonic/gin"
)

type AuthController struct {
	context        *gin.Context
	authService    services.IAuthService
	jwtService     services.IJwtService
	cookiesService services.ICookiesService
	flags          config.Flags
}

func NewAuthController(
	context *gin.Context,
	authService services.IAuthService,
	jwtService services.IJwtService,
	cookieService services.ICookiesService,
	flags config.Flags,
) *AuthController {
	return &AuthController{
		context:        context,
		authService:    authService,
		jwtService:     jwtService,
		cookiesService: cookieService,
		flags:          flags,
	}
}

func (c *AuthController) GetLogin() {
	c.context.HTML(http.StatusOK, "login.html", gin.H{})
}

func (c *AuthController) GetRegister() {
	c.context.HTML(http.StatusOK, "register.html", gin.H{})
}

func (c *AuthController) CheckLogin() {
	token, err := c.authService.Login(
		c.context.Request.FormValue("email"),
		c.context.Request.FormValue("password"),
	)
	if err != nil {
		c.renderErrorOn("login.html", err)
		return
	}

	c.cookiesService.SetJwtCookie(c.context, token)
	c.context.Redirect(http.StatusFound, "/dashboard")
}

func (c *AuthController) CreateNewUser() {
	token, err := c.authService.Register(
		c.context.Request.FormValue("email"),
		c.context.Request.FormValue("password"),
	)
	if err != nil {
		c.renderErrorOn("register.html", err)
		return
	}

	c.cookiesService.SetJwtCookie(c.context, token)
	c.context.Redirect(http.StatusFound, "/dashboard")
}

func (c *AuthController) renderErrorOn(page string, err error) {
	c.context.HTML(
		http.StatusBadRequest,
		page,
		gin.H{
			"error":    err.Error(),
			"hasError": true,
		},
	)
}
