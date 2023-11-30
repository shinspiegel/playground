package app

import (
	"net/http"
	"os"
	"urban-explorer/config"
	"urban-explorer/controllers"
	"urban-explorer/repositories"
	"urban-explorer/services"

	"github.com/gin-gonic/gin"
)

type App struct {
	router   *gin.Engine
	flags    config.Flags
	services AppServices
	repos    AppRepos
}

type AppServices struct {
	jwt      services.IJwtService
	password services.IPasswordService
	rand     services.IRandomNumberService
	auth     services.IAuthService
}

type AppRepos struct {
	user repositories.IUserRepository
}

func NewApp() *App {
	app := App{
		router: gin.Default(),
		flags:  *config.NewFlags(),
	}

	config.ReadEnv(&app.flags.EnvFile)
	// Order is important
	app.loadTemplates()
	app.loadRepositories()
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
func (a *App) loadRepositories() {
	// TODO: change for test/dev env
	a.repos.user = repositories.NewUserRepository()
}

func (a *App) loadServices() {
	// TODO: Change for test/dev env
	a.services.jwt = services.NewJwtService()
	a.services.password = services.NewPasswordService()
	a.services.rand = services.NewRandomNumberService()
	a.services.auth = services.NewAuthService(
		a.services.password,
		a.services.jwt,
		a.repos.user,
	)
}

func (a *App) loadTemplates() {
	a.router.LoadHTMLGlob("views/*.html")
}

func (a *App) add404Routes() {
	a.router.NoRoute(func(g *gin.Context) { g.HTML(http.StatusOK, "404.html", gin.H{}) })
}

func (a *App) addIndexRoutes() {
	a.router.GET("/", func(ctx *gin.Context) { controllers.NewIndexController(ctx).Index() })
}

func (a *App) addAuthRoutes() {
	a.router.GET("/login", func(context *gin.Context) {
		controllers.NewAuthController(
			context,
			a.services.auth,
			a.services.jwt,
			a.flags,
		).Login()
	})
	a.router.POST("/login", func(context *gin.Context) {
		controllers.NewAuthController(
			context,
			a.services.auth,
			a.services.jwt,
			a.flags,
		).CheckLogin()
	})
	a.router.GET("/register", func(context *gin.Context) {
		controllers.NewAuthController(
			context,
			a.services.auth,
			a.services.jwt,
			a.flags,
		).Register()
	})
}

func (a *App) addDashboardRoutes() {
	a.router.GET("/dashboard", func(ctx *gin.Context) { controllers.NewDashboardController(ctx).Dashboard() })
}
