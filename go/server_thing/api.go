package main

import (
	"net/http"

	"github.com/gorilla/mux"
)

type APIServer struct {
	listenAddress string
}

func NewAPIServer(listenAddress string) *APIServer {
	return &APIServer{
		listenAddress: listenAddress,
	}
}

func (s *APIServer) Run() {
	router := mux.NewRouter()
	router.HandleFunc("/account", s.handleAccount)
}

func (s *APIServer) handleAccount(w http.ResponseWriter, r *http.Request) error { return nil }

func (s *APIServer) handleGetAccount(w http.ResponseWriter, r *http.Request) error { return nil }

func (s *APIServer) handleCreateAccount(w http.ResponseWriter, r *http.Request) error { return nil }

func (s *APIServer) handleDeleteAccount(w http.ResponseWriter, r *http.Request) error { return nil }

func (s *APIServer) handleTransfer(w http.ResponseWriter, r *http.Request) error { return nil }
