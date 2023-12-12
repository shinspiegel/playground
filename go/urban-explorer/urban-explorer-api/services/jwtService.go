package services

import (
	"errors"
	"fmt"
	"os"
	"time"

	"github.com/dgrijalva/jwt-go"
)

type IJwtService interface {
	Generate(userId int64) (string, error)
	Validate(token string) (*AppClaim, error)
}

type JwtService struct {
	secret string
}

type AppClaim struct {
	UserID int64 `json:"user_id"`
	jwt.StandardClaims
}

func NewJwtService() *JwtService {
	jwtSecret := os.Getenv("JWT_SECRET")

	return &JwtService{
		secret: jwtSecret,
	}
}

func (s *JwtService) Generate(userID int64) (string, error) {
	claims := AppClaim{
		UserID: userID,
		StandardClaims: jwt.StandardClaims{
			ExpiresAt: time.Now().Add(24 * time.Hour).Unix(), // Token expires in 24 hours
			Issuer:    "urban-explorer",                      // Issuer of the token
		},
	}

	token := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)
	tokenString, err := token.SignedString([]byte(s.secret))

	if err != nil {
		return "", err
	}

	return tokenString, nil
}

func (s *JwtService) Validate(tokenString string) (*AppClaim, error) {
	token, err := jwt.ParseWithClaims(tokenString, &AppClaim{}, func(token *jwt.Token) (interface{}, error) {
		if _, ok := token.Method.(*jwt.SigningMethodHMAC); !ok {
			return nil, fmt.Errorf("unexpected signing method: %v", token.Header["alg"])
		}

		return []byte(s.secret), nil
	})

	if err != nil {
		return nil, err
	}

	if claims, ok := token.Claims.(*AppClaim); ok && token.Valid {
		if claims.ExpiresAt < time.Now().Unix() {
			return nil, errors.New("token has expired")
		}

		return claims, nil
	}

	return nil, errors.New("invalid token")
}
