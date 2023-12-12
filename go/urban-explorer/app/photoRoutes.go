package app

import (
	"urban-explorer/controllers"

	"github.com/gin-gonic/gin"
)

func (a *App) AddPhotosRoutes() {
	a.router.POST(
		"/photos/:photo_id",
		a.PrivateRoute,
		func(c *gin.Context) { a.getPhotosController(c).GetById() },
	)
}

func (a *App) getPhotosController(ctx *gin.Context) *controllers.PhotoController {
	return controllers.NewPhotoController(
		ctx,
	)
}
