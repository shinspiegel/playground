package main

import (
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"strconv"

	"github.com/gorilla/mux"
)

type APIServer struct {
	port  string
	store Storage
}

func NewAPIServer(address string, storage Storage) *APIServer {
	return &APIServer{
		port:  address,
		store: storage,
	}
}

func (s *APIServer) Run() {
	router := mux.NewRouter()
	router.HandleFunc("/account", makeHttpHandleFunc(s.accountHandler))
	router.HandleFunc("/account/{id}", makeHttpHandleFunc(s.accountByIdHandler))
	router.HandleFunc("/account/{id}/transfer", makeHttpHandleFunc(s.transferHandler))

	log.Println("JSON Api server running on port: ", s.port)

	http.ListenAndServe(s.port, router)
}

func (s *APIServer) accountHandler(w http.ResponseWriter, r *http.Request) error {
	if r.Method == "GET" {
		return s.getAllAccounts(w, r)
	}

	if r.Method == "POST" {
		return s.createAccount(w, r)
	}

	return fmt.Errorf("method not allowed [%s]", r.Method)
}

func (s *APIServer) accountByIdHandler(w http.ResponseWriter, r *http.Request) error {
	if r.Method == "GET" {
		return s.getById(w, r)
	}

	if r.Method == "DELETE" {
		return s.deleteById(w, r)
	}

	return fmt.Errorf("method not allowed [%s]", r.Method)
}

func (s *APIServer) transferHandler(w http.ResponseWriter, r *http.Request) error {
	if r.Method == "POST" {
		return s.transfer(w, r)
	}

	return fmt.Errorf("method not allowed [%s]", r.Method)
}

func (s *APIServer) getAllAccounts(w http.ResponseWriter, r *http.Request) error {
	list, err := s.store.GetAll()

	if err != nil {
		return err
	}

	return WriteJSON(w, http.StatusOK, list)
}

func (s *APIServer) getById(w http.ResponseWriter, r *http.Request) error {
	id, err := GetId(r)

	if err != nil {
		return err
	}

	acc, err := s.store.GetById(id)

	if err != nil {
		return err
	}

	return WriteJSON(w, http.StatusOK, acc)
}

func (s *APIServer) createAccount(w http.ResponseWriter, r *http.Request) error {
	createReq := CreateAccountDTO{}

	if err := json.NewDecoder(r.Body).Decode(&createReq); err != nil {
		return err
	}
	defer r.Body.Close()

	acc, err := s.store.Create(NewAccount(createReq.FirstName, createReq.LastName))

	if err != nil {
		return err
	}

	return WriteJSON(w, http.StatusOK, acc)
}

func (s *APIServer) deleteById(w http.ResponseWriter, r *http.Request) error {
	id, err := GetId(r)

	if err != nil {
		return err
	}

	err = s.store.DeleteById(id)

	if err != nil {
		return err
	}

	return WriteJSON(w, http.StatusOK, nil)
}

func (s *APIServer) transfer(w http.ResponseWriter, r *http.Request) error {
	t := TransferDTO{}
	err := json.NewDecoder(r.Body).Decode(&t)

	if err != nil {
		return err
	}
	defer r.Body.Close()

	return WriteJSON(w, http.StatusOK, t)
}

func GetId(r *http.Request) (int, error) {
	id, err := strconv.Atoi(mux.Vars(r)["id"])

	if err != nil {
		return 0, fmt.Errorf("the value %s is not a supported [id] value", mux.Vars(r)["id"])
	}

	return id, nil
}

type apiFunc func(http.ResponseWriter, *http.Request) error

type ApiError struct {
	Error string `json:"error"`
}

func WriteJSON(w http.ResponseWriter, status int, v any) error {
	w.Header().Add("Content-Type", "application/json")
	w.WriteHeader(status)

	if v != nil {
		return json.NewEncoder(w).Encode(v)
	}

	return nil
}

func makeHttpHandleFunc(f apiFunc) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		if err := f(w, r); err != nil {
			WriteJSON(w, http.StatusBadRequest, ApiError{Error: err.Error()})
		}
	}
}
