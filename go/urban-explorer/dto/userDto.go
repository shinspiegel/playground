package dto

type UserLoginBody struct {
	Email    string `json:"email"`
	Password string `json:"password"`
}

type UserRegisterBody struct {
	Email    string `json:"email"`
	Password string `json:"password"`
}

type UserRecoverBody struct {
	Email string `json:"email"`
}

type UserRecoverPassReset struct {
	Email    string `json:"email"`
	Password string `json:"password"`
}

type UserTokenResponse struct {
	Token string `json:"token"`
}
