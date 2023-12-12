package controllers

import (
	"net/http"
	"strconv"

	"github.com/gin-gonic/gin"
)

func SetUserId(ctx *gin.Context, userId int64) {
	ctx.Request.Header.Add("user_id", strconv.FormatInt(userId, 10))
}

func GetUserId(ctx *gin.Context) (int64, error) {
	return strconv.ParseInt(ctx.GetHeader("user_id"), 10, 64)
}

func BadRequest(ctx *gin.Context, err error) {
	ctx.AbortWithStatusJSON(http.StatusBadRequest, gin.H{
		"error":   http.StatusBadRequest,
		"message": err.Error(),
	})
}

func Unauthorized(ctx *gin.Context, err error) {
	ctx.AbortWithStatusJSON(
		http.StatusUnauthorized, gin.H{
			"error":   http.StatusUnauthorized,
			"message": err.Error(),
		})
}

func InternalServerError(ctx *gin.Context, err error) {
	ctx.AbortWithStatusJSON(http.StatusInternalServerError, gin.H{
		"error":   http.StatusInternalServerError,
		"message": err.Error(),
	})
}
