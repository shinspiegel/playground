package app

import (
	"os"

	"github.com/gin-gonic/gin"
)

type App struct {
	router *gin.Engine
}

type AlbumController interface {
	GetAlbums(c *gin.Context)
	GetAlbumById(c *gin.Context)
	PostAlbum(c *gin.Context)
}

func NewApp(abc AlbumController) *App {
	ReadEnv()

	app := App{
		router: gin.Default(),
	}

	app.router.GET("/albums", abc.GetAlbums)
	app.router.GET("/albums/:id", abc.GetAlbumById)
	app.router.POST("/albums", abc.PostAlbum)

	return &app
}

func (app *App) Run() {
	host := os.Getenv("HOST")
	port := os.Getenv("PORT")

	app.router.Run(host + ":" + port)
}
