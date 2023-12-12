package models

type UserModel struct {
	ID           int64
	Email        string `json:"email"`
	PasswordHash string
	RecoverCode  string
}
