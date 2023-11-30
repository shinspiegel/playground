package controllers

import (
	"net/http"

	"github.com/gin-gonic/gin"
)

type IndexController struct {
	context *gin.Context
}

func NewIndexController(ctx *gin.Context) *IndexController {
	return &IndexController{
		context: ctx,
	}
}

func (c *IndexController) Index() {
	c.context.HTML(http.StatusOK, "index.html", gin.H{})
}
