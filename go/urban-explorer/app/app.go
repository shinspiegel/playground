package app

import (
	"log"
	"os"
	"urban-explorer/controllers"
	"urban-explorer/repository"
	"urban-explorer/services"

	"github.com/gin-contrib/cors"
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
	app.setupCors()

	app.addAlbumRoutes()
	app.addUserRoutes()
	app.addPhotoRoutes()

	return &app
}

func (app *App) Run() {
	host := os.Getenv("HOST")
	port := os.Getenv("PORT")

	app.router.Run(host + ":" + port)
}

func (app *App) setupCors() {
	config := cors.DefaultConfig()
	config.AllowOrigins = []string{
		"http://localhost:4321",
	}
	app.router.Use(cors.New(config))
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
	repo := repository.NewAlbumRepo()
	controller := controllers.NewAlbumController(repo)

	app.router.GET("/api/albums", controller.GetAlbums)
	app.router.GET("/api/albums/:id", controller.GetAlbumById)
	app.router.PUT("/api/albums/:id", controller.UpdateAlbum)
	app.router.DELETE("/api/albums/:id", controller.DeleteAlbumById)
	app.router.POST("/api/albums", controller.PostAlbum)
}

func (app *App) addUserRoutes() {
	repo := repository.NewUserRepo()
	passService := services.NewPasswordService()
	jwtService := services.NewJwtService()
	randService := services.NewRandomNumberService()
	userService := services.NewUserService(repo, passService, jwtService, randService)
	controller := controllers.NewUserController(userService)

	app.router.POST("/api/users/login", controller.Login)
	app.router.POST("/api/users/register", controller.Register)
	app.router.GET("/api/users/recover", controller.Recover)
	app.router.POST("/api/users/recover/:recover_code", controller.RecoverCode)
}

func (app *App) addPhotoRoutes() {
	repo := repository.NewPhotoRepo()
	service := services.NewPhotoService(repo)
	controller := controllers.NewPhotosController(service)

	app.router.POST("/api/photos", controller.Photos)
}
