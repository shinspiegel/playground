package app

import (
	"log"
	"os"
	"urban-explorer/controllers"
	"urban-explorer/repository"
	"urban-explorer/services"

	"github.com/gin-gonic/gin"
	"github.com/joho/godotenv"
)

type App struct {
	router *gin.Engine
	flags  Flags
}

func NewApp() *App {
	a := App{
		router: gin.Default(),
		flags:  *NewFlags(),
	}

	a.readEnv()

	a.addAlbumRoutes()
	a.addUserRoutes()

	return &a
}

func (a *App) Run() {
	host := os.Getenv("HOST")
	port := os.Getenv("PORT")

	a.router.Run(host + ":" + port)
}

func (a *App) readEnv() {
	if a.flags.EnvFile != "" {
		err := godotenv.Load(a.flags.EnvFile)
		if err != nil {
			log.Fatalf("Fail to load ['%v'] the environment.", a.flags.EnvFile)
		}
	}
}

func (a *App) addAlbumRoutes() {
	r := repository.NewAlbumRepo()
	c := controllers.NewAlbumController(r)

	a.router.GET("/albums", c.GetAlbums)
	a.router.GET("/albums/:id", c.GetAlbumById)
	a.router.PUT("/albums/:id", c.UpdateAlbum)
	a.router.DELETE("/albums/:id", c.DeleteAlbumById)
	a.router.POST("/albums", c.PostAlbum)
}

func (a *App) addUserRoutes() {
	r := repository.NewUserRepo()
	s := services.NewUserService()
	c := controllers.NewUserController(r, s)

	a.router.POST("/users/login", c.Login)
	a.router.POST("/users/register", c.Register)
	a.router.POST("/users/:user_id/recover", c.Recover)
	a.router.POST("/users/:user_id/recover/:recover_code", c.RecoverCode)
}
