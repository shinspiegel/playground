package main

import (
	"urban-explorer/config"
	"urban-explorer/controllers"

	"github.com/gin-gonic/gin"
)

func main() {
	flags := config.NewFlags()
	config.ReadEnv(&flags.EnvFile)

	router := gin.Default()
	router.LoadHTMLGlob("views/*.html")

	router.GET("/user", controllers.GetUser)

	router.Run(":8080")
}
