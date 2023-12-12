package app

import (
	"net/http"
	"os"
	"urban-explorer/config"

	"github.com/gin-contrib/cors"
	"github.com/gin-gonic/gin"
)

type App struct {
	router   *gin.Engine
	Flags    config.Flags
	services AppServices
	repos    AppRepos
}

func NewApp() *App {
	app := App{
		router: gin.Default(),
		Flags:  *config.NewFlags(),
	}

	config.ReadEnv(&app.Flags.EnvFile)

	// App base configs
	app.enableCors()

	// Order is important
	app.LoadRepositories()
	app.LoadServices()
	app.LoadRoutes()

	// Start the app
	return &app
}

func (a *App) Run() {
	a.router.Run(os.Getenv("HOST") + ":" + os.Getenv("PORT"))
}

func (a *App) NotImplemented(ctx *gin.Context) {
	ctx.String(http.StatusNotImplemented, "not implemented")
}

func (a *App) enableCors() {
	config := cors.DefaultConfig()

	config.AllowCredentials = true
	config.AllowOrigins = []string{
		"http://localhost:8080",
		"http://localhost:4321",
		"https://jeferson.me",
	}

	a.router.Use(cors.New(config))
}
