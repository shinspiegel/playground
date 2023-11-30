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
	Flags    config.Flags
	services AppServices
	repos    AppRepos
}

type AppServices struct {
	jwt      services.IJwtService
	password services.IPasswordService
	random   services.IRandomNumberService
	auth     services.IAuthService
	cookie   services.ICookiesService
}

type AppRepos struct {
	user repositories.IUserRepository
}

func NewApp() *App {
	app := App{
		router: gin.Default(),
		Flags:  *config.NewFlags(),
	}

	config.ReadEnv(&app.Flags.EnvFile)
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
	a.services.random = services.NewRandomNumberService()
	a.services.cookie = services.NewCookiesService()
	a.services.auth = services.NewAuthService(a.services.password, a.services.jwt, a.repos.user)
}

func (a *App) loadTemplates() {
	a.router.LoadHTMLGlob("templates/*.html")
}

func (a *App) add404Routes() {
	a.router.NoRoute(func(g *gin.Context) { g.HTML(http.StatusOK, "404.html", gin.H{}) })
}

func (a *App) addIndexRoutes() {
	a.router.GET("/", func(ctx *gin.Context) { a.getIndexController(ctx).Index() })
}

func (a *App) getIndexController(context *gin.Context) *controllers.IndexController {
	return controllers.NewIndexController(context)
}

func (a *App) addAuthRoutes() {
	a.router.GET("/login", func(ctx *gin.Context) { a.getAuthController(ctx).GetLogin() })
	a.router.POST("/login", func(ctx *gin.Context) { a.getAuthController(ctx).CheckLogin() })
	a.router.GET("/register", func(ctx *gin.Context) { a.getAuthController(ctx).GetRegister() })
	a.router.POST("/register", func(ctx *gin.Context) { a.getAuthController(ctx).CreateNewUser() })
}

func (a *App) getAuthController(context *gin.Context) *controllers.AuthController {
	return controllers.NewAuthController(
		context,
		a.services.auth,
		a.services.jwt,
		a.services.cookie,
		a.Flags,
	)
}

func (a *App) addDashboardRoutes() {
	a.router.GET("/dashboard", func(ctx *gin.Context) { a.getDashboardController(ctx).Dashboard() })
}

func (a *App) getDashboardController(context *gin.Context) *controllers.DashboardController {
	return controllers.NewDashboardController(
		context,
		a.services.cookie,
		a.services.jwt,
	)
}
