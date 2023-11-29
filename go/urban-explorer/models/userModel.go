package models

import (
	"database/sql"
	"errors"
	"urban-explorer/database"
)

type UserModel struct {
	ID           int64
	Email        string `json:"email"`
	PasswordHash string
	RecoverCode  string
}

func FindUserByEmail(email string) (*UserModel, error) {
	db := database.New()
	defer db.Close()

	rows, err := db.Query(`
		SELECT
			id, email, password_hash, recover_code
		FROM
			users
		WHERE
			email = :email
	`,
		sql.Named("email", email),
	)
	if err != nil {
		return nil, err
	}

	user := UserModel{}

	hasUser := rows.Next()
	if !hasUser {
		return nil, errors.New("email not found")
	}
	rows.Scan(
		&user.ID,
		&user.Email,
		&user.PasswordHash,
		&user.PasswordHash,
	)

	return &user, nil
}
