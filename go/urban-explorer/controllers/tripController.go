package controllers

import (
	"errors"
	"net/http"
	"strconv"
	"urban-explorer/services"

	"github.com/gin-gonic/gin"
)

type TripController struct {
	context      *gin.Context
	tripService  services.ITripService
	photoService services.IPhotoService
}

func NewTripController(ctx *gin.Context, ts services.ITripService, ps services.IPhotoService) *TripController {
	return &TripController{
		context:      ctx,
		tripService:  ts,
		photoService: ps,
	}
}

type NewTripBody struct {
	Name string `json:"name"`
}

func (c *TripController) NewTrip() {
	userId, err := GetUserId(c.context)
	if err != nil {
		BadRequest(c.context, errors.New("invalid user_id"))
		return
	}

	body := NewTripBody{}
	err = c.context.BindJSON(&body)
	if err != nil {
		BadRequest(c.context, errors.New("invalid body. 'name' is required"))
		return
	}

	trip, err := c.tripService.CreateTrip(body.Name, userId)
	if err != nil {
		InternalServerError(c.context, err)
		return
	}

	c.context.JSON(http.StatusCreated, trip)
}

func (c *TripController) AddPhoto() {
	userId, err := GetUserId(c.context)
	if err != nil {
		InternalServerError(c.context, err)
		return
	}
	tripId, err := strconv.ParseInt(c.context.Param("trip_id"), 10, 64)
	if err != nil {
		BadRequest(c.context, errors.New("invalid trip id"))
	}

	formFile, err := c.context.FormFile("image")
	if err != nil {
		BadRequest(c.context, errors.New("invalid photo file"))
		return
	}

	photo, err := c.photoService.AddPhoto(userId, tripId, formFile)
	if err != nil {
		BadRequest(c.context, err)
		return
	}

	c.context.JSON(http.StatusCreated, photo)
}
