package controllers

import (
	"net/http"
	"urban-explorer/services"

	"github.com/gin-gonic/gin"
)

type DashboardController struct {
	context        *gin.Context
	cookiesService services.ICookiesService
	jwtService     services.IJwtService
}

func NewDashboardController(
	ctx *gin.Context,
	cookieService services.ICookiesService,
	jwtService services.IJwtService,
) *DashboardController {
	return &DashboardController{
		context:        ctx,
		cookiesService: cookieService,
		jwtService:     jwtService,
	}
}

func (c *DashboardController) Dashboard() {
	token, err := c.cookiesService.GetJwtCookie(c.context)
	if err != nil {
		c.context.Redirect(http.StatusMovedPermanently, "/login")
		return
	}

	claim, err := c.jwtService.Validate(token)
	if err != nil {
		c.cookiesService.CleanCookies(c.context)
		c.context.Redirect(http.StatusMovedPermanently, "/login")
		return
	}

	err = claim.Valid()
	if err != nil {
		c.cookiesService.CleanCookies(c.context)
		c.context.Redirect(http.StatusMovedPermanently, "/login")
		return
	}

	c.context.HTML(http.StatusOK, "dashboard.html", gin.H{})
}
