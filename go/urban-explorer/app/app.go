package app

import (
	"log"
	"os"
	"urban-explorer/controllers"
	"urban-explorer/repository"

	"github.com/gin-gonic/gin"
	"github.com/joho/godotenv"
)

type App struct {
	router *gin.Engine
	flags  Flags
}

func NewApp() *App {
	app := App{
		router: gin.Default(),
		flags:  *NewFlags(),
	}

	app.readEnv()

	app.addAlbumRoutes()

	return &app
}

func (app *App) Run() {
	host := os.Getenv("HOST")
	port := os.Getenv("PORT")

	app.router.Run(host + ":" + port)
}

func (app *App) readEnv() {
	if app.flags.EnvFile != "" {
		err := godotenv.Load(app.flags.EnvFile)
		if err != nil {
			log.Fatalf("Fail to load ['%v'] the environment.", app.flags.EnvFile)
		}
	}
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
