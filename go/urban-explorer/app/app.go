package app

import (
	"os"
	"urban-explorer/config"
	"urban-explorer/controllers"

	"github.com/gin-gonic/gin"
)

type App struct {
	router *gin.Engine
	flags  config.Flags
}

func NewApp() *App {
	app := App{
		router: gin.Default(),
		flags:  *config.NewFlags(),
	}

	config.ReadEnv(&app.flags.EnvFile)
	app.loadTemplates()

	app.addUserRoutes()

	return &app
}

func (a *App) Run() {
	a.router.Run(os.Getenv("HOST") + ":" + os.Getenv("PORT"))
}

func (a *App) loadTemplates() {
	a.router.LoadHTMLGlob("views/*.html")
}

func (a *App) addUserRoutes() {
	a.router.GET("/user", func(g *gin.Context) { controllers.NewUserController().GetUser(g) })
}
