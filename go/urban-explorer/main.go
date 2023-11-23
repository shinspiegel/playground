package main

import (
	"urban-explorer/app"
	"urban-explorer/controllers"
	"urban-explorer/repository"
)

func main() {
	app.NewApp(
		controllers.NewAlbumController(repository.NewAlbumRepo()),
	).Run()
}
