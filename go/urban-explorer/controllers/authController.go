package controllers

import (
	"errors"
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

type loginBody struct {
	Email    string `json:"email"`
	Password string `json:"password"`
}

type loginResponse struct {
	Token string `json:"token"`
}

func (c *AuthController) Login() {
	body := loginBody{}

	switch contentType := c.context.ContentType(); contentType {
	case "application/json":
		c.context.BindJSON(&body)

	case "multipart/form-data":
		body.Email = c.context.Request.FormValue("email")
		body.Password = c.context.Request.FormValue("password")

	default:
		BadRequest(c.context, errors.New("invalid content type"))
		return
	}

	if body.Email == "" || body.Password == "" {
		BadRequest(c.context, errors.New("missing or empty email or password"))
		return
	}

	token, err := c.authService.Login(body.Email, body.Password)
	if err != nil {
		BadRequest(c.context, err)
		return
	}

	c.cookiesService.SetJwtCookie(c.context, token)
	c.context.JSON(http.StatusOK, loginResponse{Token: *token})
}

type registerBody struct {
	Email    string `json:"email"`
	Password string `json:"password"`
}

type registerResponse struct {
	Token string `json:"token"`
}

func (c *AuthController) Register() {
	body := registerBody{}

	switch contentType := c.context.ContentType(); contentType {
	case "application/json":
		c.context.BindJSON(&body)

	case "multipart/form-data":
		body.Email = c.context.Request.FormValue("email")
		body.Password = c.context.Request.FormValue("password")

	default:
		BadRequest(c.context, errors.New("invalid content type"))
		return
	}

	if body.Email == "" || body.Password == "" {
		BadRequest(c.context, errors.New("missing or empty email or password"))
		return
	}

	token, err := c.authService.Register(body.Email, body.Password)
	if err != nil {
		BadRequest(c.context, err)
		return
	}

	c.cookiesService.SetJwtCookie(c.context, token)
	c.context.JSON(http.StatusCreated, registerResponse{Token: *token})
}

type recoverBody struct {
	Email string `json:"email"`
}

func (c *AuthController) Recover() {
	body := recoverBody{}

	switch contentType := c.context.ContentType(); contentType {
	case "application/json":
		c.context.BindJSON(&body)

	case "multipart/form-data":
		body.Email = c.context.Request.FormValue("email")

	default:
		BadRequest(c.context, errors.New("invalid content type"))
		return
	}

	if body.Email == "" {
		BadRequest(c.context, errors.New("missing or invalid 'email' property"))
	}

	_, err := c.authService.Recover(body.Email)
	if err != nil {
		InternalServerError(c.context, err)
	}

	c.context.Status(http.StatusAccepted)
}

func (c *AuthController) RecoverCode() {
	c.context.String(http.StatusNotImplemented, "not implemented")
}
