package main

import (
	"rest_test/controllers"

	"github.com/gin-gonic/gin"
)

func main() {
	router := gin.Default()

	controller := controllers.NewTodoController()

	router.GET("/todos", controller.GetAll)
	router.GET("/todos/:id", controller.GetById)
	router.POST("/todos", controller.Add)

	router.Run("localhost:8080")
}
