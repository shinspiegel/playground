package controllers

import (
	"errors"
	"net/http"
	"strconv"
	"urban-explorer/services"

	"github.com/gin-gonic/gin"
)

type PhotoController struct {
	context *gin.Context
	service services.IPhotoService
}

func NewPhotoController(ctx *gin.Context, s services.IPhotoService) *PhotoController {
	return &PhotoController{
		context: ctx,
		service: s,
	}
}

func (c *PhotoController) GetById() {
	userId, err := GetUserId(c.context)
	if err != nil {
		InternalServerError(c.context, err)
		return
	}

	photoId, err := strconv.ParseInt(c.context.Param("photo_id"), 10, 64)
	if err != nil {
		BadRequest(c.context, errors.New("invalid photo id"))
		return
	}

	photo, err := c.service.GetById(photoId, userId)
	if err != nil {
		BadRequest(c.context, err)
		return
	}

	c.context.Writer.Header().Set("Content-Type", "image/jpeg")
	c.context.Writer.Write(photo.JpegBytes)
}

func (c *PhotoController) DeleteById() {
	userId, err := GetUserId(c.context)
	if err != nil {
		InternalServerError(c.context, err)
		return
	}

	photoId, err := strconv.ParseInt(c.context.Param("photo_id"), 10, 64)
	if err != nil {
		BadRequest(c.context, errors.New("invalid photo id"))
		return
	}

	err = c.service.DeleteById(userId, photoId)
	if err != nil {
		BadRequest(c.context, err)
		return
	}

	c.context.Status(http.StatusOK)
}
