package models

type User struct {
	ID    int
	Name  string
	Email string
}

func NewUser() *User {
	return &User{}
}
