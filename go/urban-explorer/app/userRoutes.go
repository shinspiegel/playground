package app

func (a *App) AddUserRoutes() {
	a.router.POST("/user", a.NotImplemented)
}
