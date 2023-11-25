package dto

type LoginBody struct {
	Email    string `json:"email"`
	Password string `json:"password"`
}

type RegisterBody struct {
	Email    string `json:"email"`
	Password string `json:"password"`
}

type TokenResponse struct {
	Token string `json:"token"`
}
