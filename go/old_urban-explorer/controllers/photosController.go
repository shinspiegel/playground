package controllers

import (
	"fmt"
	"net/http"
	"urban-explorer/dto"
	"urban-explorer/services"

	"github.com/gin-gonic/gin"
	"github.com/rwcarlsen/goexif/exif"
)

type PhotosController struct {
	service services.IPhotoService
}

func NewPhotosController(s services.IPhotoService) *PhotosController {
	return &PhotosController{
		service: s,
	}
}

func (c *PhotosController) Photos(ctx *gin.Context) {
	formFile, err := ctx.FormFile("image")
	if err != nil {
		ctx.IndentedJSON(
			http.StatusBadRequest,
			dto.NewErrorResponse(http.StatusBadRequest, err.Error()),
		)
		return
	}
	file, err := formFile.Open()
	if err != nil {
		ctx.IndentedJSON(
			http.StatusBadRequest,
			dto.NewErrorResponse(http.StatusBadRequest, err.Error()),
		)
		return
	}
	defer file.Close()

	exifData, err := exif.Decode(file)
	if err != nil {
		ctx.IndentedJSON(
			http.StatusBadRequest,
			dto.NewErrorResponse(http.StatusBadRequest, err.Error()),
		)
		return
	}

	fmt.Println(exifData.String())
	fmt.Println(exifData.LatLong())
	fmt.Println(exifData.DateTime())
}
