package app

import (
	"urban-explorer/controllers"

	"github.com/gin-gonic/gin"
)

func (a *App) AddTripsRoutes() {
	a.router.POST("/api/trips/new", a.PrivateRoute, func(c *gin.Context) { a.getTripController(c).NewTrip() })
	a.router.GET("/api/trips", a.PrivateRoute, func(c *gin.Context) { a.getTripController(c).GetTrips() })
	a.router.GET("/api/trips/:trip_id", a.PrivateRoute, func(c *gin.Context) { a.getTripController(c).GetById() })
	a.router.POST("/api/trips/:trip_id/photo/add", a.PrivateRoute, func(c *gin.Context) { a.getTripController(c).AddPhoto() })
	a.router.POST("/api/trips/:trip_id/publish", a.PrivateRoute, a.NotImplemented)
}

func (a *App) getTripController(context *gin.Context) *controllers.TripController {
	return controllers.NewTripController(
		context,
		a.services.trip,
		a.services.photo,
	)
}
