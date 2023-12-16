package app

import "urban-explorer/repositories"

type AppRepos struct {
	user  repositories.IUserRepository
	trip  repositories.ITripRepository
	photo repositories.IPhotoRepository
}

func (a *App) LoadRepositories() {
	// TODO: change for test/dev env
	a.services.log.Debug("loading repositories")
	a.repos.user = repositories.NewUserRepository()
	a.repos.trip = repositories.NewTripRepository()
	a.repos.photo = repositories.NewPhotoRepository()
}
