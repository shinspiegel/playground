package app

func (a *App) AddPhotosRoutes() {
	a.router.POST("/photos/new", a.NotImplemented)
}
