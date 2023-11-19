package app

import (
	"os"
	"urban-explorer/handlers"

	"github.com/gin-gonic/gin"
)

type App struct {
	router *gin.Engine
}

func NewApp() *App {
	app := App{
		router: gin.Default(),
	}

	app.router.GET("/albums", handlers.GetAlbums)
	app.router.GET("/albums/:id", handlers.GetAlbumByID)
	app.router.POST("/albums", handlers.PostAlbums)

	return &app
}

func (app *App) Run() {
	host := os.Getenv("HOST")
	port := os.Getenv("PORT")

	app.router.Run(host + ":" + port)
}
