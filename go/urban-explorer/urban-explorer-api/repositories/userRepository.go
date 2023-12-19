package repositories

import (
	"errors"
	"urban-explorer/database"
	"urban-explorer/models"
)

type IUserRepository interface {
	FindByEmail(email string) (*models.UserModel, error)
	FindById(id int64) (*models.UserModel, error)
	Insert(email, passwordHash string) (*models.UserModel, error)
	IsEmailInUse(email string) (bool, error)
	AddUserOnPhoto(photo *models.PhotoModel) (*models.PhotoModel, error)
	UpdateRecoverByEmail(email string, code string) (*models.UserModel, error)
	UpdateUserPassword(userId int64, passwordHash string) (*models.UserModel, error)
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
			email=$1 
	`,
		email,
	)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	hasUser := rows.Next()
	if !hasUser {
		return nil, errors.New("email not found")
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

func (r *UserRepository) IsEmailInUse(email string) (bool, error) {
	db := database.New()
	defer db.Close()

	rows, err := db.Query(`
		SELECT
			id, email
		FROM
			users
		WHERE
			email=$1
	`,
		email,
	)
	if err != nil {
		return false, err
	}
	defer rows.Close()

	return rows.Next(), nil
}

func (m *UserRepository) Insert(email, passwordHash string) (*models.UserModel, error) {
	db := database.New()
	defer db.Close()

	rows, err := db.Query(`
		INSERT INTO users
			(email, password_hash, recover_code)
		VALUES
			($1, $2, $3)
		RETURNING
			id, email, password_hash, recover_code
	`,
		email, passwordHash, nil,
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

func (r *UserRepository) FindById(id int64) (*models.UserModel, error) {
	db := database.New()
	defer db.Close()

	rows, err := db.Query(`
		SELECT
			id, email, password_hash, recover_code
		FROM
			users
		WHERE
			id=$1
	`,
		id,
	)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	hasUser := rows.Next()
	if !hasUser {
		return nil, errors.New("user id not found")
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

func (r *UserRepository) AddUserOnPhoto(photo *models.PhotoModel) (*models.PhotoModel, error) {
	user, err := r.FindById(photo.Id)
	if err != nil {
		return nil, err
	}

	photo.User = user

	return photo, nil
}

func (r *UserRepository) UpdateRecoverByEmail(email string, code string) (*models.UserModel, error) {
	db := database.New()
	defer db.Close()

	rows, err := db.Query(`
		UPDATE users
		SET 
			recover_code=$1
		WHERE
			email=$2
		RETURNING
			id, email, password_hash, recover_code
	`,
		code, email,
	)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	isSaved := rows.Next()
	if !isSaved {
		return nil, errors.New("failed to add recover code")
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

func (r *UserRepository) UpdateUserPassword(userId int64, passwordHash string) (*models.UserModel, error) {
	db := database.New()
	defer db.Close()

	rows, err := db.Query(`
		UPDATE users
		SET 
			password_hash=$1, recover_code=$2
		WHERE
			id=$3
		RETURNING
			id, email, password_hash, recover_code
	`,
		passwordHash, nil, userId,
	)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	isSaved := rows.Next()
	if !isSaved {
		return nil, errors.New("failed to update user password")
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
