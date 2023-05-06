package main

import (
	"net/http"

	"github.com/gin-gonic/gin"
)

type Todo struct {
	ID        string `json:"id"`
	Item      string `json:"item"`
	Completed bool   `json:"completed"`
}

var todos = []Todo{
	{ID: "1", Item: "Clean1", Completed: false},
	{ID: "2", Item: "Clean2", Completed: false},
	{ID: "3", Item: "Clean3", Completed: false},
	{ID: "4", Item: "Clean4", Completed: false},
}

func getTodos(context *gin.Context) {
	context.IndentedJSON(http.StatusOK, todos)
}

func addTodo(context *gin.Context) {
	todo := Todo{}

	if err := context.BindJSON(&todo); err != nil {
		return
	}

	todos = append(todos, todo)

	context.IndentedJSON(http.StatusCreated, todo)
}

func main() {
	server := gin.Default()
	server.GET("/todos", getTodos)
	server.POST("/todos", addTodo)
	server.Run("localhost:5050")
}
