package app

import (
	"urban-explorer/controllers"

	"github.com/gin-gonic/gin"
)

func (a *App) AddAuthRoutes() {
	a.router.POST("auth/login", func(ctx *gin.Context) { a.getAuthController(ctx).Login() })
	a.router.POST("auth/register", func(ctx *gin.Context) { a.getAuthController(ctx).Register() })
	a.router.POST("auth/recover", a.NotImplemented)
	a.router.POST("auth/recover/:code", a.NotImplemented)
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
