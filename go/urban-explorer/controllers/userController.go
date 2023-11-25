package controllers

import (
	"net/http"
	"urban-explorer/controllers/dto"

	"github.com/gin-gonic/gin"
)

type UserRepo interface{}

type UserService interface {
	Login(name *string, password *string) *dto.TokenResponse
	Register(name *string, password *string) *dto.TokenResponse
}

type UserController struct {
	repository UserRepo
	service    UserService
}

func NewUserController(r UserRepo, s UserService) *UserController {
	return &UserController{
		repository: r,
		service:    s,
	}
}

func (c *UserController) Login(ctx *gin.Context) {
	body := dto.LoginBody{}
	ctx.BindJSON(&body)
	res := c.service.Login(&body.Email, &body.Password)
	ctx.IndentedJSON(http.StatusCreated, res)
}

func (c *UserController) Register(ctx *gin.Context) {
	body := dto.RegisterBody{}
	ctx.BindJSON(&body)
	res := c.service.Register(&body.Email, &body.Password)
	ctx.IndentedJSON(http.StatusCreated, res)
}

func (c *UserController) Recover(ctx *gin.Context) {
	ctx.String(http.StatusNotImplemented, "Not implemented")
}

func (c *UserController) RecoverCode(ctx *gin.Context) {
	ctx.String(http.StatusNotImplemented, "Not implemented")
}
