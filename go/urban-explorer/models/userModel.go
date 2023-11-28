package models

import (
	"database/sql"
	"errors"
	"urban-explorer/database"
)

type User struct {
	ID           int
	Email        string `json:"email"`
	PasswordHash string
	RecoverCode  string
}

func FindUserByEmail(email string) (*User, error) {
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

	user := User{}

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
