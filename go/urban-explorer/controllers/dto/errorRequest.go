package dto

type ErrorResponse struct {
	Code    int    `json:"code"`
	Message string `json:"message"`
}

func NewErrorResponse(code int, message string) ErrorResponse {
	return ErrorResponse{
		Code:    code,
		Message: message,
	}
}
