package controllers

import (
	"net/http"

	"github.com/gin-gonic/gin"
)

type DashboardController struct{}

func NewDashboardController() *DashboardController {
	return &DashboardController{}
}

func (c *DashboardController) Dashboard(ctx *gin.Context) {
	ctx.HTML(http.StatusOK, "dashboard.html", gin.H{})
}
