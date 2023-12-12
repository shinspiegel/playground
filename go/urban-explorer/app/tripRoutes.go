package app

import (
	"urban-explorer/controllers"

	"github.com/gin-gonic/gin"
)

func (a *App) AddTripsRoutes() {
	a.router.POST(
		"/trips/new",
		a.PrivateRoute,
		func(ctx *gin.Context) { a.getTripController(ctx).NewTrip() },
	)
	a.router.POST(
		"/trips/:trip_id/photos/add",
		a.PrivateRoute,
		func(ctx *gin.Context) { a.getTripController(ctx).AddPhoto() },
	)
	a.router.POST(
		"/trips/:trip_id/publish",
		a.PrivateRoute,
		a.NotImplemented,
	)
}

func (a *App) getTripController(ctx *gin.Context) *controllers.TripController {
	return controllers.NewTripController(
		ctx,
		a.services.trip,
		a.services.photo,
	)
}
