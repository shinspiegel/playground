package app

func (a *App) AddTripsRoutes() {
	a.router.POST("/trips/new", a.PrivateRoute, a.NotImplemented)
	a.router.POST("/trips/:trip_id/photos/add", a.PrivateRoute, a.NotImplemented)
}
