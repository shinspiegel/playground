package app

import "urban-explorer/repositories"

type AppRepos struct {
	user  repositories.IUserRepository
	trip  repositories.ITripRepository
	photo repositories.IPhotoRepository
}

func (a *App) LoadRepositories() {
	// TODO: change for test/dev env
	a.repos.user = repositories.NewUserRepository()
	a.repos.trip = repositories.NewTripRepository()
	a.repos.photo = repositories.NewPhotoRepository()
}
