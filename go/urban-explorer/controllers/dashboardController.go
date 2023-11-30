package controllers

import (
	"net/http"
	"urban-explorer/services"

	"github.com/gin-gonic/gin"
)

type DashboardController struct {
	context     *gin.Context
	authService services.IAuthService
}

func NewDashboardController(
	ctx *gin.Context,
	authService services.IAuthService,
) *DashboardController {
	return &DashboardController{
		context: ctx,
	}
}

func (c *DashboardController) Dashboard() {
	err := c.authService.ValidateContext(c.context)
	if err != nil {
		c.context.Redirect(http.StatusMovedPermanently, "/login")
	}

	c.context.HTML(http.StatusOK, "dashboard.html", gin.H{})
}
