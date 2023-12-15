package controllers

import (
	"errors"
	"net/http"
	"strconv"
	"strings"
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

	switch contentType := c.context.ContentType(); contentType {
	case "application/json":
		c.context.BindJSON(&body)

	case "multipart/form-data":
		body.Name = c.context.Request.FormValue("name")

	default:
		BadRequest(c.context, errors.New("invalid content type"))
		return
	}

	body.Name = strings.Trim(body.Name, " ")

	if body.Name == "" {
		BadRequest(c.context, errors.New("name property can't be empty"))
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
		return
	}

	if c.context.ContentType() != "multipart/form-data" {
		BadRequest(c.context, errors.New("invalid Content-Type. Must be a 'multipart/form-data'"))
		return
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

func (c *TripController) GetById() {
	userId, err := GetUserId(c.context)
	if err != nil {
		BadRequest(c.context, errors.New("invalid user_id"))
		return
	}

	tripId, err := strconv.ParseInt(c.context.Param("trip_id"), 10, 64)
	if err != nil {
		BadRequest(c.context, errors.New("invalid trip_id"))
		return
	}

	trip, err := c.tripService.GetById(tripId, userId)
	if err != nil {
		InternalServerError(c.context, err)
		return
	}

	if c.context.Query("include-photos") == "true" {
		err = c.photoService.AddPhotosToTrip(trip)
		if err != nil {
			InternalServerError(c.context, err)
		}
	}

	c.context.JSON(http.StatusCreated, trip)
}

func (c *TripController) GetTrips() {
	userId, err := GetUserId(c.context)
	if err != nil {
		BadRequest(c.context, errors.New("invalid user_id"))
		return
	}

	trips, err := c.tripService.GetByUserId(userId)
	if err != nil {
		InternalServerError(c.context, err)
		return
	}

	c.context.JSON(http.StatusCreated, *trips)
}

func (c *TripController) DeleteById() {
	userId, err := GetUserId(c.context)
	if err != nil {
		BadRequest(c.context, errors.New("invalid user_id"))
		return
	}

	tripId, err := strconv.ParseInt(c.context.Param("trip_id"), 10, 64)
	if err != nil {
		BadRequest(c.context, errors.New("invalid trip_id"))
		return
	}

	c.tripService.DeleteTripAndPhotos(userId, tripId)
}
