package controllers

import (
	"net/http"
	"urban-explorer/controllers/dto"

	"github.com/gin-gonic/gin"
)

type UserRepo interface{}

type UserService interface {
	Login(name *string, password *string) (*dto.TokenResponse, error)
	Register(name *string, password *string) (*dto.TokenResponse, error)
}

type UserController struct {
	service UserService
}

func NewUserController(s UserService) *UserController {
	return &UserController{
		service: s,
	}
}

func (c *UserController) Login(ctx *gin.Context) {
	body := dto.LoginBody{}
	ctx.BindJSON(&body)
	res, err := c.service.Login(&body.Email, &body.Password)
	if err != nil {
		ctx.IndentedJSON(
			http.StatusBadRequest,
			dto.NewErrorResponse(http.StatusBadRequest, err.Error()),
		)
		return
	}
	ctx.IndentedJSON(http.StatusCreated, res)
}

func (c *UserController) Register(ctx *gin.Context) {
	body := dto.RegisterBody{}
	ctx.BindJSON(&body)
	res, err := c.service.Register(&body.Email, &body.Password)
	if err != nil {
		ctx.IndentedJSON(
			http.StatusBadRequest,
			dto.NewErrorResponse(http.StatusBadRequest, err.Error()),
		)
		return
	}
	ctx.IndentedJSON(http.StatusCreated, res)
}

func (c *UserController) Recover(ctx *gin.Context) {
	ctx.String(http.StatusNotImplemented, "Not implemented")
}

func (c *UserController) RecoverCode(ctx *gin.Context) {
	ctx.String(http.StatusNotImplemented, "Not implemented")
}
