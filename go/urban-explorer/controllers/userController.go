package controllers

import (
	"net/http"
	"strconv"
	"urban-explorer/dto"

	"github.com/gin-gonic/gin"
)

type UserRepo interface{}

type UserService interface {
	Login(name *string, password *string) (*dto.TokenResponse, error)
	Register(name *string, password *string) (*dto.TokenResponse, error)
	Recover(userId *int64) error
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
	id, err := strconv.ParseInt(ctx.Param("user_id"), 10, 64)
	if err != nil {
		ctx.IndentedJSON(
			http.StatusInternalServerError,
			dto.NewErrorResponse(http.StatusInternalServerError, err.Error()),
		)
		return
	}

	c.service.Recover(&id)
	ctx.Status(http.StatusAccepted)
}

func (c *UserController) RecoverCode(ctx *gin.Context) {
	ctx.String(http.StatusNotImplemented, "Not implemented")
}
