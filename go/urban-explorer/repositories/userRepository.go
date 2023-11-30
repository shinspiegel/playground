package repositories

import (
	"database/sql"
	"errors"
	"urban-explorer/database"
	"urban-explorer/models"
)

type IUserRepository interface {
	FindByEmail(email string) (*models.UserModel, error)
	Insert(email, passwordHash string) (*models.UserModel, error)
	IsEmailInUse(email string) (bool, error)
}

type UserRepository struct{}

func NewUserRepository() *UserRepository {
	return &UserRepository{}
}

func (r *UserRepository) FindByEmail(email string) (*models.UserModel, error) {
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

	hasUser := rows.Next()
	if !hasUser {
		return nil, errors.New("email not found")
	}
	user := models.UserModel{}
	rows.Scan(
		&user.ID,
		&user.Email,
		&user.PasswordHash,
		&user.PasswordHash,
	)

	return &user, nil
}

func (r *UserRepository) IsEmailInUse(email string) (bool, error) {
	db := database.New()
	defer db.Close()

	rows, err := db.Query(`
		SELECT
			id, email
		FROM
			users
		WHERE
			email = :email
	`,
		sql.Named("email", email),
	)
	if err != nil {
		return false, err
	}

	return rows.Next(), nil
}

func (m *UserRepository) Insert(email, passwordHash string) (*models.UserModel, error) {
	db := database.New()
	defer db.Close()

	rows, err := db.Query(`
		INSERT INTO users
			(email, password_hash, recover_code)
		VALUES
			(:email, :password_hash, :recover_code)
		RETURNING
			id, email, password_hash, recover_code
	`,
		sql.Named("email", email),
		sql.Named("password_hash", passwordHash),
		sql.Named("password_hash", nil),
	)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	isSaved := rows.Next()
	if !isSaved {
		return nil, errors.New("failed to insert")
	}

	user := models.UserModel{}
	rows.Scan(
		&user.ID,
		&user.Email,
		&user.PasswordHash,
		&user.RecoverCode,
	)

	return &user, nil
}
