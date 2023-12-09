package app

func (a *App) AddTripsRoutes() {
	a.router.POST("/trips/new", a.NotImplemented)
	a.router.POST("/trips/:id", a.NotImplemented)
}
