package controllers

import (
	"net/http"
	"urban-explorer/services"

	"github.com/gin-gonic/gin"
)

type TripController struct {
	context     *gin.Context
	tripService services.ITripService
}

func NewTripController(ctx *gin.Context, ts services.ITripService) *TripController {
	return &TripController{
		context:     ctx,
		tripService: ts,
	}
}

func (c *TripController) NewTrip() {
	c.context.String(http.StatusNotImplemented, "not implemented")

}
func (c *TripController) AddPhoto() {
	c.context.String(http.StatusNotImplemented, "not implemented")
}
