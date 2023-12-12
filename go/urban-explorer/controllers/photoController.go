package controllers

import (
	"net/http"

	"github.com/gin-gonic/gin"
)

type PhotoController struct {
	context *gin.Context
}

func NewPhotoController(ctx *gin.Context) *PhotoController {
	return &PhotoController{
		context: ctx,
	}
}

func (c *PhotoController) GetById() {
	c.context.String(http.StatusNotImplemented, "not implemented")
}
