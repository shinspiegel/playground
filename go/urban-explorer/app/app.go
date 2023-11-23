package app

import (
	"os"
	"urban-explorer/controllers"

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

	app.router.GET("/albums", controllers.GetAlbums)
	app.router.GET("/albums/:id", controllers.GetAlbumByID)
	app.router.POST("/albums", controllers.PostAlbums)

	return &app
}

func (app *App) Run() {
	host := os.Getenv("HOST")
	port := os.Getenv("PORT")

	app.router.Run(host + ":" + port)
}
