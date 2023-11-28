package controllers

import (
	"net/http"
	"urban-explorer/dto"
	"urban-explorer/services"

	"github.com/gin-gonic/gin"
)

type UserController struct {
	service services.IUserService
}

func NewUserController(s services.IUserService) *UserController {
	return &UserController{
		service: s,
	}
}

func (c *UserController) Login(ctx *gin.Context) {
	body := dto.UserLoginBody{}
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
	body := dto.UserRegisterBody{}
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
	body := dto.UserRecoverBody{}
	ctx.BindJSON(&body)
	err := c.service.Recover(&body.Email)
	if err != nil {
		ctx.IndentedJSON(
			http.StatusInternalServerError,
			dto.NewErrorResponse(http.StatusInternalServerError, err.Error()),
		)
		return
	}

	ctx.Status(http.StatusAccepted)
}

func (c *UserController) RecoverCode(ctx *gin.Context) {
	body := dto.UserRecoverPassReset{}
	recoverCode := ctx.Param("recover_code")
	ctx.BindJSON(&body)

	res, err := c.service.ResetPass(&body.Email, &recoverCode, &body.Password)
	if err != nil {
		ctx.IndentedJSON(
			http.StatusInternalServerError,
			dto.NewErrorResponse(http.StatusInternalServerError, err.Error()),
		)
		return
	}

	ctx.IndentedJSON(http.StatusOK, res)
}
