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

type checkLoginResponse struct {
	Token string `json:"token"`
}

func (c *AuthController) CheckLogin() {
	token, err := c.authService.Login(
		c.context.Request.FormValue("email"),
		c.context.Request.FormValue("password"),
	)
	if err != nil {
		BadRequest(c.context, err)
		return
	}

	c.cookiesService.SetJwtCookie(c.context, token)
	c.context.JSON(http.StatusOK, checkLoginResponse{Token: *token})
}

type createUserResponse struct {
	Token string `json:"token"`
}

func (c *AuthController) CreateNewUser() {
	token, err := c.authService.Register(
		c.context.Request.FormValue("email"),
		c.context.Request.FormValue("password"),
	)
	if err != nil {
		BadRequest(c.context, err)
		return
	}

	c.cookiesService.SetJwtCookie(c.context, token)
	c.context.JSON(http.StatusCreated, createUserResponse{Token: *token})
}
