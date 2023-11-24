package app

import (
	"os"
	"urban-explorer/controllers"
	"urban-explorer/repository"

	"github.com/gin-gonic/gin"
)

type App struct {
	router *gin.Engine
}

func NewApp() *App {
	ReadEnv()

	app := App{
		router: gin.Default(),
	}

	app.addAlbumRoutes()

	return &app
}

func (app *App) Run() {
	host := os.Getenv("HOST")
	port := os.Getenv("PORT")

	app.router.Run(host + ":" + port)
}

func (app *App) addAlbumRoutes() {
	albumRepo := repository.NewAlbumRepo()
	albumController := controllers.NewAlbumController(albumRepo)

	app.router.GET("/albums", albumController.GetAlbums)
	app.router.GET("/albums/:id", albumController.GetAlbumById)
	app.router.PUT("/albums/:id", albumController.UpdateAlbum)
	app.router.DELETE("/albums/:id", albumController.DeleteAlbumById)
	app.router.POST("/albums", albumController.PostAlbum)
}
