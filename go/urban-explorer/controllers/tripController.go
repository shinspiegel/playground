package controllers

import (
	"net/http"

	"github.com/gin-gonic/gin"
)

type TripController struct {
	context *gin.Context
}

func NewTripController(ctx *gin.Context) *TripController {
	return &TripController{
		context: ctx,
	}
}

func (c *TripController) CreateTrip() {
	c.context.HTML(http.StatusOK, "create-trip.html", gin.H{})
}
