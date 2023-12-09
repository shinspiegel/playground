package app

import (
	"errors"
	"fmt"
	"strconv"
	"urban-explorer/controllers"

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
		controllers.Unauthorized(ctx, errors.New("invalid or empty auth token"))
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
		controllers.Unauthorized(ctx, err)
		return
	}

	ctx.Request.Header.Add("user_id", strconv.FormatInt(claim.UserID, 10))

	ctx.Next()
}
