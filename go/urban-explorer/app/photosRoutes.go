package app

import (
	"urban-explorer/controllers"

	"github.com/gin-gonic/gin"
)

func (a *App) AddPhotosRoutes() {
	a.router.POST(
		"/photos/:photo_id",
		a.PrivateRoute,
		a.NotImplemented,
	)
}

func (a *App) getPhotosController(ctx *gin.Context) *controllers.TripController {
	return controllers.NewTripController(
		ctx,
		a.services.trip,
		a.services.photo,
	)
}
