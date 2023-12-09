package app

import "urban-explorer/services"

type AppServices struct {
	jwt      services.IJwtService
	password services.IPasswordService
	random   services.IRandomNumberService
	auth     services.IAuthService
	cookie   services.ICookiesService
	trip     services.ITripService
}

func (a *App) LoadServices() {
	// TODO: Change for test/dev env
	a.services.jwt = services.NewJwtService()
	a.services.password = services.NewPasswordService()
	a.services.random = services.NewRandomNumberService()
	a.services.cookie = services.NewCookiesService()
	a.services.trip = services.NewTripService()

	a.services.auth = services.NewAuthService(
		a.services.password,
		a.services.jwt,
		a.services.cookie,
		a.repos.user,
	)
}
