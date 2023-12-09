package controllers

import (
	"errors"
	"net/http"
	"strconv"
	"urban-explorer/services"

	"github.com/gin-gonic/gin"
)

type TripController struct {
	context *gin.Context
	service services.ITripService
}

func NewTripController(ctx *gin.Context, ts services.ITripService) *TripController {
	return &TripController{
		context: ctx,
		service: ts,
	}
}

type NewTripBody struct {
	Name string `json:"name"`
}

func (c *TripController) NewTrip() {
	userId, err := strconv.ParseInt(c.context.GetHeader("user_id"), 10, 64)
	if err != nil {
		BadRequest(c.context, errors.New("invalid user_id"))
	}

	body := NewTripBody{}
	err = c.context.BindJSON(&body)
	if err != nil {
		BadRequest(c.context, err)
	}

	trip, err := c.service.CreateTrip(body.Name, userId)
	if err != nil {
		InternalServerError(c.context, err)
	}

	c.context.JSON(http.StatusCreated, trip)

}
func (c *TripController) AddPhoto() {
	c.context.String(http.StatusNotImplemented, "not implemented")
}
