package models

type UserModel struct {
	ID           int64  `json:"-"`
	Email        string `json:"email"`
	PasswordHash string `json:"-"`
	RecoverCode  string `json:"-"`
}
