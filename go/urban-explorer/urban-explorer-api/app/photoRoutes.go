package app

import (
	"urban-explorer/controllers"

	"github.com/gin-gonic/gin"
)

func (a *App) AddPhotosRoutes() {
	a.services.log.Debug("add created photo asset route")
	a.router.GET("/assets/photos/:photo_id", a.PrivateRoute, func(c *gin.Context) { a.getPhotosController(c).GetById() })

	a.services.log.Debug("add photo routes")
	a.router.DELETE("/api/photos/:photo_id", a.PrivateRoute, func(c *gin.Context) { a.getPhotosController(c).DeleteById() })
}

func (a *App) getPhotosController(ctx *gin.Context) *controllers.PhotoController {
	return controllers.NewPhotoController(
		ctx,
		a.services.photo,
	)
}
