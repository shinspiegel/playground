package app

import (
	"urban-explorer/controllers"

	"github.com/gin-gonic/gin"
)

func (a *App) AddAuthRoutes() {
	a.router.POST("/login", func(ctx *gin.Context) { a.getAuthController(ctx).CheckLogin() })
	a.router.POST("/register", func(ctx *gin.Context) { a.getAuthController(ctx).CreateNewUser() })
	a.router.POST("/recover", a.NotImplemented)
	a.router.POST("/recover/:code", a.NotImplemented)
}

func (a *App) getAuthController(context *gin.Context) *controllers.AuthController {
	return controllers.NewAuthController(
		context,
		a.services.auth,
		a.services.jwt,
		a.services.cookie,
		a.Flags,
	)
}
