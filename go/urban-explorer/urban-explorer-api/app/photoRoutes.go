package app

import (
	"urban-explorer/controllers"

	"github.com/gin-gonic/gin"
)

func (a *App) AddPhotosRoutes() {
	a.router.GET("/api/photos/:photo_id", a.PrivateRoute, func(c *gin.Context) { a.getPhotosController(c).GetById() })
	a.router.DELETE("/api/photos/:photo_id", a.PrivateRoute, func(c *gin.Context) { a.getPhotosController(c).DeleteById() })
}

func (a *App) getPhotosController(ctx *gin.Context) *controllers.PhotoController {
	return controllers.NewPhotoController(
		ctx,
		a.services.photo,
	)
}
