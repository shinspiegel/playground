package app

import (
	"fmt"
	"net/http"
	"strconv"

	"github.com/gin-gonic/gin"
)

func (a *App) PrivateRoute(ctx *gin.Context) {
	var token string

	bearerToken := ctx.GetHeader("authorization")

	cookieToken, err := a.services.cookie.GetJwtCookie(ctx)
	if err != nil {
		// TODO: Create an app logger class to use in this case
		fmt.Println("WARN::" + err.Error())
	}

	if cookieToken == "" && bearerToken == "" {
		ctx.JSON(http.StatusUnauthorized, gin.H{"error": "invalid or empty auth token"})
		return
	}

	if cookieToken != "" {
		token = cookieToken
	}
	if bearerToken != "" {
		token = bearerToken
	}

	claim, err := a.services.jwt.Validate(token)
	if err != nil {
		ctx.JSON(http.StatusUnauthorized, gin.H{"error": err.Error()})
		return
	}

	ctx.Request.Header.Add("user_id", strconv.FormatInt(claim.UserID, 10))
	ctx.Next()
}
