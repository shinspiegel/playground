package app

import "urban-explorer/repositories"

func (a *App) LoadRepositories() {
	// TODO: change for test/dev env
	a.repos.user = repositories.NewUserRepository()
}
