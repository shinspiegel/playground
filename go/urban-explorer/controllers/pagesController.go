package controllers

import (
	"net/http"

	"github.com/gin-gonic/gin"
)

type PagesController struct{}

func NewPagesController() *PagesController {
	return &PagesController{}
}

func (c *PagesController) Index(ctx *gin.Context) {
	ctx.HTML(http.StatusOK, "index.tmpl", gin.H{
		"Title":   "TITLE",
		"Heading": "HEADING",
		"Content": "CONTENT",
	})
}
