package app

import (
	"net/http"
	"os"
	"urban-explorer/config"

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

	// Order is important
	app.LoadRepositories()
	app.LoadServices()

	// Load all routes for the app
	app.Add404Routes()
	app.AddAuthRoutes()
	app.AddTripsRoutes()
	app.AddPhotosRoutes()

	// Start the app
	return &app
}

func (a *App) Run() {
	a.router.Run(os.Getenv("HOST") + ":" + os.Getenv("PORT"))
}

func (a *App) NotImplemented(ctx *gin.Context) {
	ctx.String(http.StatusNotImplemented, "not implemented")
}
