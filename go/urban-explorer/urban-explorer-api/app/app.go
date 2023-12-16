package app

import (
	"net/http"
	"os"
	"urban-explorer/config"
	"urban-explorer/services"

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
	logger := services.NewLogService()
	logger.Trace("logger initiated")

	app := App{
		router: gin.New(),
		Flags:  *config.NewFlags(),
	}
	logger.Trace("app created")
	logger.Trace("logger included on services")
	app.services.log = logger

	app.router.Use(gin.Recovery())
	logger.Trace("recovery started")
	app.router.Use(logger.LogMiddleware)
	logger.Trace("logger middleware added")

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
	uri := os.Getenv("HOST") + ":" + os.Getenv("PORT")
	a.services.log.Info("running app on " + uri)
	a.router.Run(uri)
}

func (a *App) NotImplemented(ctx *gin.Context) {
	a.services.log.Warn("route not implemente")
	ctx.String(http.StatusNotImplemented, "not implemented")
}

func (a *App) enableCors() {
	config := cors.DefaultConfig()
	a.services.log.Trace("enabling cors")

	config.AllowCredentials = true
	allowOrigins := []string{
		"http://localhost:8080",
		"http://localhost:5173",
		"https://jeferson.me",
	}
	config.AllowOrigins = allowOrigins
	a.services.log.Trace("allowing origins for", allowOrigins)

	a.router.Use(cors.New(config))
}
