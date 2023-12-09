package controllers

import (
	"net/http"

	"github.com/gin-gonic/gin"
)

func BadRequest(ctx *gin.Context, err error) {
	ctx.JSON(http.StatusBadRequest, gin.H{
		"error":   http.StatusBadRequest,
		"message": err.Error(),
	})
}

func Unauthorized(ctx *gin.Context, err error) {
	ctx.JSON(http.StatusUnauthorized, gin.H{
		"error":   http.StatusUnauthorized,
		"message": err.Error(),
	})
}

func InternalServerError(ctx *gin.Context, err error) {
	ctx.JSON(http.StatusInternalServerError, gin.H{
		"error":   http.StatusInternalServerError,
		"message": err.Error(),
	})
}
