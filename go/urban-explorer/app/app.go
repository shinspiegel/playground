package app

import (
	"net/http"
	"os"
	"urban-explorer/config"
	"urban-explorer/controllers"
	"urban-explorer/services"

	"github.com/gin-gonic/gin"
)

type App struct {
	router   *gin.Engine
	flags    config.Flags
	services AppServices
}

type AppServices struct {
	jwt      services.IJwtService
	password services.IPasswordService
	rand     services.IRandomNumberService
}

func NewApp() *App {
	app := App{
		router: gin.Default(),
		flags:  *config.NewFlags(),
	}

	config.ReadEnv(&app.flags.EnvFile)
	app.loadTemplates()
	app.loadServices()

	app.add404Routes()
	app.addIndexRoutes()
	app.addAuthRoutes()
	app.addDashboardRoutes()

	return &app
}

func (a *App) Run() {
	a.router.Run(os.Getenv("HOST") + ":" + os.Getenv("PORT"))
}

func (a *App) loadServices() {
	a.services.jwt = services.NewJwtService()
	a.services.password = services.NewPasswordService()
	a.services.rand = services.NewRandomNumberService()
}

func (a *App) loadTemplates() {
	a.router.LoadHTMLGlob("views/*.html")
}

func (a *App) add404Routes() {
	a.router.NoRoute(func(g *gin.Context) { g.HTML(http.StatusOK, "404.html", gin.H{}) })
}

func (a *App) addIndexRoutes() {
	a.router.GET("/", func(g *gin.Context) { controllers.NewIndexController().Index(g) })
}

func (a *App) addAuthRoutes() {
	a.router.GET("/login", func(g *gin.Context) { controllers.NewAuthController().Login(g) })
	a.router.POST("/login", func(g *gin.Context) { controllers.NewAuthController().CheckLogin(g) })

	a.router.GET("/register", func(g *gin.Context) { controllers.NewAuthController().Register(g) })
}

func (a *App) addDashboardRoutes() {
	a.router.GET("/dashboard", func(g *gin.Context) { controllers.NewDashboardController().Dashboard(g) })
}
