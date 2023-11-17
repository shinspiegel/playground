package controllers

import (
	"net/http"

	"github.com/gin-gonic/gin"

	"rest_test/todos"
)

type TodoController struct {
	todoList todos.TodosList
}

func NewTodoController() *TodoController {
	return &TodoController{
		todoList: *todos.New(),
	}
}

func (ct TodoController) GetAll(c *gin.Context) {
	c.IndentedJSON(http.StatusOK, ct.todoList.GetList())
}

func (ct TodoController) GetById(c *gin.Context) {
	t, err := ct.todoList.FindById(c.Param("id"))
	if err != nil {
		c.String(http.StatusNotFound, err.Error())
		return
	}

	c.IndentedJSON(http.StatusOK, t)
}

func (ct TodoController) Add(c *gin.Context) {
	var newTodo todos.Todo

	if err := c.BindJSON(&newTodo); err != nil {
		return
	}

	ct.todoList.Add(newTodo)
	c.IndentedJSON(http.StatusCreated, ct.todoList.GetList())
}
