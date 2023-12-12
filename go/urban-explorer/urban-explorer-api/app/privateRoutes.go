package app

import (
	"errors"
	"fmt"
	"urban-explorer/controllers"

	"github.com/gin-gonic/gin"
)

func (a *App) PrivateRoute(ctx *gin.Context) {
	var token string

	authToken := ctx.GetHeader("authorization")

	cookieToken, err := a.services.cookie.GetJwtCookie(ctx)
	if err != nil {
		// TODO: Create an app logger class to use in this case
		fmt.Println("WARN::" + err.Error())
	}

	if cookieToken == "" && authToken == "" {
		a.services.cookie.CleanCookies(ctx)
		controllers.Unauthorized(ctx, errors.New("invalid or empty auth token"))
		ctx.Done()
		return
	}

	if cookieToken != "" {
		token = cookieToken
	}
	if authToken != "" {
		token = authToken
	}

	claim, err := a.services.jwt.Validate(token)
	if err != nil {
		a.services.cookie.CleanCookies(ctx)
		controllers.Unauthorized(ctx, err)
		ctx.Done()
		return
	}

	controllers.SetUserId(ctx, claim.UserID)

	ctx.Next()
}
