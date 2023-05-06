package main

import (
	"database/sql"
	"fmt"

	_ "github.com/lib/pq"
)

type Storage interface {
	Create(*Account) (*Account, error)
	DeleteById(int) error
	UpdateByAcc(*Account) error
	GetAll() ([]*Account, error)
	GetById(int) (*Account, error)
}

type PgStore struct {
	db *sql.DB
}

func NewPgStore() (*PgStore, error) {
	connStr := "user=USER dbname=DATA password=PASS sslmode=disable"
	db, err := sql.Open("postgres", connStr)

	if err != nil {
		return nil, err
	}

	if err := db.Ping(); err != nil {
		return nil, err
	}

	return &PgStore{db: db}, nil
}

func (s *PgStore) Create(account *Account) (*Account, error) {
	query := `
		INSERT INTO accounts(first_name, last_name, number, balance)
		VALUES($1, $2, $3, 0)
		RETURNING id`

	res, err := s.db.Query(
		query,
		account.FirstName,
		account.LastName,
		account.Number,
	)

	if err != nil {
		return nil, err
	}

	res.Next()
	res.Scan(&account.ID)

	return account, nil
}

func (s *PgStore) DeleteById(id int) error {
	query := `
		DELETE FROM accounts 
		WHERE id = $1`

	_, err := s.db.Query(query, id)

	if err != nil {
		return err
	}

	return nil
}

func (s *PgStore) UpdateByAcc(a *Account) error {
	query := `
		UPDATE accounts
		SET first_name = $2, last_name = $3
		WHERE id = $1
		RETURNING id, first_name, last_name, number, balance, created_at`

	_, err := s.db.Query(
		query,
		&a.ID,
		&a.FirstName,
		&a.LastName,
	)

	if err != nil {
		return err
	}

	return nil
}

func (s *PgStore) GetById(id int) (*Account, error) {
	query := `
		SELECT id, first_name, last_name, number, balance, created_at
		FROM accounts
		WHERE id = $1`

	rows, err := s.db.Query(query, id)

	if err != nil {
		return nil, err
	}

	if !rows.Next() {
		return nil, fmt.Errorf("no data found for [id] %v", id)
	}

	return rowScanToAccount(rows)
}

func (s *PgStore) GetAll() ([]*Account, error) {
	rows, err := s.db.Query(`
		SELECT id, first_name, last_name, number, balance, created_at
	 	FROM accounts`)

	if err != nil {
		return nil, err
	}

	list := []*Account{}

	for rows.Next() {
		a, err := rowScanToAccount(rows)

		if err != nil {
			return nil, err
		}

		list = append(list, a)
	}

	return list, nil
}

func rowScanToAccount(rows *sql.Rows) (*Account, error) {
	a := Account{}
	err := rows.Scan(&a.ID, &a.FirstName, &a.LastName, &a.Number, &a.Balance, &a.CreatedAt)
	return &a, err
}

func (s *PgStore) Init() error {
	return s.createAccountTable()
}

func (s *PgStore) createAccountTable() error {
	query := `
		CREATE TABLE IF NOT EXISTS accounts (
			id SERIAL PRIMARY KEY,
			first_name VARCHAR(255) NOT NULL,
			last_name VARCHAR(255) NOT NULL, 
			number DOUBLE PRECISION,
			balance DOUBLE PRECISION,
			created_at TIMESTAMP DEFAULT now()
		);`

	_, err := s.db.Exec(query)

	return err
}
