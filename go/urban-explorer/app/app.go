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
	app := App{
		router: gin.Default(),
		flags:  *NewFlags(),
	}

	app.readEnv()

	app.addAlbumRoutes()
	app.addUserRoutes()

	return &app
}

func (app *App) Run() {
	host := os.Getenv("HOST")
	port := os.Getenv("PORT")

	app.router.Run(host + ":" + port)
}

func (a *App) readEnv() {
	if a.flags.EnvFile != "" {
		err := godotenv.Load(a.flags.EnvFile)
		if err != nil {
			log.Fatalf("Fail to load ['%v'] the environment.", a.flags.EnvFile)
		}
	}
}

func (app *App) addAlbumRoutes() {
	repo := repository.NewAlbumRepo()
	controller := controllers.NewAlbumController(repo)

	app.router.GET("/albums", controller.GetAlbums)
	app.router.GET("/albums/:id", controller.GetAlbumById)
	app.router.PUT("/albums/:id", controller.UpdateAlbum)
	app.router.DELETE("/albums/:id", controller.DeleteAlbumById)
	app.router.POST("/albums", controller.PostAlbum)
}

func (app *App) addUserRoutes() {
	repo := repository.NewUserRepo()
	passService := services.NewPasswordService()
	jwtService := services.NewJwtService()
	randService := services.NewRandomNumberService()
	userService := services.NewUserService(repo, passService, jwtService, randService)
	controller := controllers.NewUserController(userService)

	app.router.POST("/users/login", controller.Login)
	app.router.POST("/users/register", controller.Register)
	app.router.GET("/users/recover", controller.Recover)
	app.router.POST("/users/recover/:recover_code", controller.RecoverCode)
}
