package app

func (a *App) LoadRoutes() {
	a.Add404Routes()
	a.AddAuthRoutes()
	a.AddTripsRoutes()
	a.AddPhotosRoutes()
}
