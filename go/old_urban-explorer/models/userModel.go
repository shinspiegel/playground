package models

type User struct {
	ID          int64
	Email       string `json:"email"`
	Password    string
	RecoverCode string
}
