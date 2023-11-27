package repository

import (
	"database/sql"
	"errors"
	"log"
	"urban-explorer/constants"
	"urban-explorer/database"
	"urban-explorer/models"
)

type IUserRepo interface {
	IsEmailUsed(email *string) bool
	InsertUser(email *string, hashPassword *string) *models.User
	GetUserByEmail(email *string) (*models.User, error)
	GetUserById(userId *int64) (*models.User, error)
	AddRecoverCodeTo(userId *int64, recoverCode string) error
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

func (r *UserRepo) GetUserById(userId *int64) (*models.User, error) {
	db := database.New()
	defer db.Close()

	rows := db.Query(`
		SELECT
			id, email, password_hash
		FROM
			users
		WHERE
			id = :id
	`,
		sql.Named("id", userId),
	)

	if !rows.Next() {
		return nil, errors.New(constants.UserNotFound)
	}

	user := models.User{}
	if err := rows.Scan(
		&user.ID,
		&user.Email,
		&user.Password,
	); err != nil {
		log.Fatal(err)
	}

	return &user, nil
}

func (r *UserRepo) AddRecoverCodeTo(userId *int64, recoverCode string) error {
	db := database.New()
	defer db.Close()

	res := db.Exec(`
		INSERT INTO users
			(recover_code)
		VALUES
			(:recover_code)
		WHERE
			id = :id
	`,
		sql.Named("id", userId),
		sql.Named("recover_code", recoverCode),
	)

	count, err := res.RowsAffected()

	if err != nil {
		return err
	}

	if count <= 0 {
		return errors.New(constants.FailedToInsertRecover)
	}

	return nil
}
