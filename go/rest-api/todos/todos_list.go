package todos

import (
	"errors"
)

type TodosList struct {
	list []Todo
}

func New() *TodosList {
	return &TodosList{
		list: []Todo{
			{ID: "1", Item: "Learn go1", Completed: false},
			{ID: "2", Item: "Learn go2", Completed: false},
			{ID: "3", Item: "Learn go3", Completed: false},
		},
	}
}

func (tl *TodosList) GetList() *[]Todo {
	return &tl.list
}

func (tl *TodosList) Add(todo Todo) {
	tl.list = append(tl.list, todo)
}

func (tl *TodosList) FindById(id string) (*Todo, error) {
	for i, todo := range tl.list {
		if todo.ID == id {
			return &tl.list[i], nil
		}
	}

	return nil, errors.New("failed to find")
}
