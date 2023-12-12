package services

import "github.com/gin-gonic/gin"

type ICookiesService interface {
	GetJwtCookie(ctx *gin.Context) (string, error)
	SetJwtCookie(ctx *gin.Context, token *string)
	CleanCookies(ctx *gin.Context)
}

type CookiesService struct{}

func NewCookiesService() *CookiesService {
	return &CookiesService{}
}

func (s *CookiesService) SetJwtCookie(ctx *gin.Context, token *string) {
	ctx.SetCookie("token", *token, 3600, "/", "localhost", false, false)
}

func (s *CookiesService) GetJwtCookie(ctx *gin.Context) (string, error) {
	return ctx.Cookie("token")
}

func (s *CookiesService) CleanCookies(ctx *gin.Context) {
	ctx.SetCookie("token", "", -1, "/", "localhost", false, false)
}
