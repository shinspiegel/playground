package repository

import (
	"database/sql"
	"log"
	"urban-explorer/database"
)

type IUserRepo interface {
	IsEmailUsed(email *string) bool
}

type UserRepo struct{}

func NewUserRepo() *UserRepo {
	return &UserRepo{}
}

func (r *UserRepo) IsEmailUsed(email *string) bool {
	db := database.New()
	defer db.Close()

	result := db.Exec(`
		SELECT 
			email
		FROM 
			users
		WHERE
			email = :email
	`,
		sql.Named("email", email),
	)

	count, err := result.RowsAffected()
	if err != nil {
		log.Fatal(err)
	}

	if count > 0 {
		return true
	}

	return false
}
