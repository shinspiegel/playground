package app

import (
	"errors"
	"urban-explorer/controllers"

	"github.com/gin-gonic/gin"
)

func (a *App) PrivateRoute(ctx *gin.Context) {
	a.services.log.Trace("private route attempt")
	var token string

	authToken := ctx.GetHeader("authorization")
	a.services.log.Trace("header token", authToken)

	cookieToken, err := a.services.cookie.GetJwtCookie(ctx)
	a.services.log.Trace("cookie token", cookieToken)
	if err != nil {
		a.services.log.Trace("failed to recover from cookie", err.Error())
	}

	if cookieToken == "" && authToken == "" {
		a.services.log.Info("empty or invalid auth token")
		a.services.cookie.CleanCookies(ctx)
		controllers.Unauthorized(ctx, errors.New("invalid or empty auth token"))
		ctx.Done()
		return
	}

	if cookieToken != "" {
		token = cookieToken
		a.services.log.Debug("using cookie token", token)
	}
	if authToken != "" {
		token = authToken
		a.services.log.Debug("using auth token", token)
	}

	claim, err := a.services.jwt.Validate(token)
	if err != nil {
		a.services.log.Info("failed to validate token", err.Error())
		a.services.cookie.CleanCookies(ctx)
		controllers.Unauthorized(ctx, err)
		ctx.Done()
		return
	}
	a.services.log.Debug("user claim", claim)

	controllers.SetUserId(ctx, claim.UserID)

	ctx.Next()
}
