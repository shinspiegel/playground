package app

import (
	"urban-explorer/controllers"

	"github.com/gin-gonic/gin"
)

func (a *App) AddAuthRoutes() {
	a.router.GET("api/auth/check", a.PrivateRoute, func(ctx *gin.Context) { a.getAuthController(ctx).Check() })
	a.router.POST("api/auth/login", func(ctx *gin.Context) { a.getAuthController(ctx).Login() })
	a.router.POST("api/auth/logout", func(ctx *gin.Context) { a.getAuthController(ctx).Logout() })
	a.router.POST("api/auth/register", func(ctx *gin.Context) { a.getAuthController(ctx).Register() })
	a.router.POST("api/auth/recover", func(ctx *gin.Context) { a.getAuthController(ctx).Recover() })
	a.router.POST("api/auth/recover/:recover_code", func(ctx *gin.Context) { a.getAuthController(ctx).RecoverCode() })
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
