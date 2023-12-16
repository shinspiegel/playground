package app

func (a *App) LoadRoutes() {
	a.services.log.Debug("add routes")
	a.Add404Routes()
	a.AddAuthRoutes()
	a.AddTripsRoutes()
	a.AddPhotosRoutes()
}
