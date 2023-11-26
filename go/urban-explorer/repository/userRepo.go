package repository

import (
	"database/sql"
	"errors"
	"urban-explorer/constants"
	"urban-explorer/database"
	"urban-explorer/models"
)

type IUserRepo interface {
	IsEmailUsed(email *string) bool
	InsertUser(email *string, hashPassword *string) *models.User
	GetUserByEmail(email *string) (*models.User, error)
}

type UserRepo struct{}

func NewUserRepo() *UserRepo {
	return &UserRepo{}
}

func (r *UserRepo) IsEmailUsed(email *string) bool {
	db := database.New()
	defer db.Close()

	rows := db.Query(`
		SELECT
			email
		FROM
			users
		WHERE
			email = :email
	`,
		sql.Named("email", email),
	)
	defer rows.Close()

	return rows.Next()
}

func (r *UserRepo) GetUserByEmail(email *string) (*models.User, error) {
	db := database.New()
	defer db.Close()

	rows := db.Query(`
		SELECT
			id, email, password_hash
		FROM
			users
		WHERE
			email = :email
		`,
		sql.Named("email", email),
	)
	defer rows.Close()

	if rows.Next() {
		user := models.User{}
		rows.Scan(
			&user.ID,
			&user.Email,
			&user.Password,
		)
		return &user, nil
	}
	return nil, errors.New(constants.EmailNotFound)
}

func (r *UserRepo) InsertUser(email *string, hashPassword *string) *models.User {
	db := database.New()
	defer db.Close()

	rows := db.Query(`
		INSERT INTO users
			(email, password_hash)
		VALUES
			(:email, :password_hash)
		RETURNING
			id, email, password_hash
	`,
		sql.Named("email", email),
		sql.Named("password_hash", hashPassword),
	)
	defer rows.Close()
	user := models.User{}
	rows.Next()
	rows.Scan(
		&user.ID,
		&user.Email,
		&user.Password,
	)

	return &user
}
