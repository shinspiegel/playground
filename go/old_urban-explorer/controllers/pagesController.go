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
	ctx.HTML(http.StatusOK, "index.tmpl", gin.H{})
}

func (c *PagesController) Login(ctx *gin.Context) {
	ctx.HTML(http.StatusOK, "login.tmpl", gin.H{})
}

func (c *PagesController) Register(ctx *gin.Context) {
	ctx.HTML(http.StatusOK, "register.tmpl", gin.H{})
}

func (c *PagesController) Dashboard(ctx *gin.Context) {
	ctx.HTML(http.StatusOK, "dashboard.tmpl", gin.H{})
}
