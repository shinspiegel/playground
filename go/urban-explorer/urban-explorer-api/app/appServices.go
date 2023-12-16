package app

import "urban-explorer/services"

type AppServices struct {
	jwt       services.IJwtService
	password  services.IPasswordService
	random    services.IRandomNumberService
	auth      services.IAuthService
	cookie    services.ICookiesService
	trip      services.ITripService
	photo     services.IPhotoService
	formImage services.IFormImageService
	image     services.IImageService
	log       services.ILogService
}

func (a *App) LoadServices() {
	// TODO: Change for test/dev env
	a.services.log.Debug("loading services")

	if a.services.log == nil {
		a.services.log.Info("log not created in app, adding on services")
		a.services.log = services.NewLogService()
	}

	a.services.jwt = services.NewJwtService()
	a.services.password = services.NewPasswordService()
	a.services.random = services.NewRandomNumberService()
	a.services.cookie = services.NewCookiesService()
	a.services.formImage = services.NewFormImageService()
	a.services.image = services.NewImageService()

	a.services.trip = services.NewTripService(
		a.repos.trip,
		a.repos.photo,
	)

	a.services.auth = services.NewAuthService(
		a.services.password,
		a.services.jwt,
		a.services.cookie,
		a.services.random,
		a.repos.user,
	)

	a.services.photo = services.NewPhotoService(
		a.repos.photo,
		a.services.formImage,
		a.services.image,
	)
}
