package controllers

import (
	"net/http"

	"github.com/gin-gonic/gin"
)

type DashboardController struct {
	context *gin.Context
}

func NewDashboardController(ctx *gin.Context) *DashboardController {
	return &DashboardController{
		context: ctx,
	}
}

func (c *DashboardController) Dashboard() {
	c.context.HTML(http.StatusOK, "dashboard.html", gin.H{})
}
