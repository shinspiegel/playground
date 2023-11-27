package repository

import (
	"database/sql"
	"errors"
	"urban-explorer/constants"
	"urban-explorer/database"
	"urban-explorer/models"
)

type IUserRepo interface {
	IsEmailUsed(email *string) (bool, error)
	InsertUser(email *string, hashPassword *string) (*models.User, error)
	GetUserByEmail(email *string) (*models.User, error)
	AddRecoverCodeBy(userId *int64, recoverCode *string) (bool, error)
	UpdatePassword(userId *int64, hashPassword *string) (bool, error)
}

type UserRepo struct{}

func NewUserRepo() *UserRepo {
	return &UserRepo{}
}

func (r *UserRepo) IsEmailUsed(email *string) (bool, error) {
	db := database.New()
	defer db.Close()

	rows, err := db.Query(`
		SELECT
			email
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
	defer rows.Close()

	return rows.Next(), nil
}

func (r *UserRepo) GetUserByEmail(email *string) (*models.User, error) {
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
	defer rows.Close()

	if rows.Next() {
		user := models.User{}
		rows.Scan(
			&user.ID,
			&user.Email,
			&user.Password,
			&user.RecoverCode,
		)
		return &user, nil
	}
	return nil, errors.New(constants.EmailNotFound)
}

func (r *UserRepo) InsertUser(email *string, hashPassword *string) (*models.User, error) {
	db := database.New()
	defer db.Close()

	rows, err := db.Query(`
		INSERT INTO users
			(email, password_hash, recover_code)
		VALUES
			(:email, :password_hash, :recover_code)
		RETURNING
			id, email, password_hash
	`,
		sql.Named("email", email),
		sql.Named("password_hash", hashPassword),
		sql.Named("recover_code", nil),
	)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	user := models.User{}
	rows.Next()
	rows.Scan(
		&user.ID,
		&user.Email,
		&user.Password,
	)

	return &user, nil
}

func (r *UserRepo) AddRecoverCodeBy(userId *int64, recoverCode *string) (bool, error) {
	db := database.New()
	defer db.Close()

	res, err := db.Exec(`
		UPDATE 
			users
		SET 
			recover_code = :recover_code
		WHERE
			id = :id
	`,
		sql.Named("id", userId),
		sql.Named("recover_code", recoverCode),
	)
	if err != nil {
		return false, err
	}

	count, err := res.RowsAffected()

	if err != nil {
		return false, err
	}

	if count <= 0 {
		return false, errors.New(constants.FailedToInsertRecover)
	}

	return true, nil
}

func (r *UserRepo) UpdatePassword(userId *int64, hashPassword *string) (bool, error) {
	db := database.New()
	defer db.Close()

	res, err := db.Exec(`
		UPDATE
			users
		SET
			password_hash = :password_hash
		WHERE
			id = :id
	`,
		sql.Named("id", userId),
		sql.Named("password_hash", hashPassword),
	)
	if err != nil {
		return false, err
	}

	count, err := res.RowsAffected()
	if err != nil {
		return false, err
	}

	if count <= 0 {
		return false, errors.New(constants.FailedToUpdatePassword)
	}

	return true, nil
}
