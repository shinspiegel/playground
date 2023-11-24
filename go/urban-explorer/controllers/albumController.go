package controllers

import (
	"net/http"
	"strconv"
	"urban-explorer/models"

	"github.com/gin-gonic/gin"
)

type AlbumRepository interface {
	GetAlbums() []models.Album
	GetAlbumByID(int64) []models.Album
	InsertAlbum(album *models.Album) *models.Album
}

type AlbumController struct {
	repository AlbumRepository
}

func NewAlbumController(repository AlbumRepository) *AlbumController {
	return &AlbumController{
		repository: repository,
	}
}

func (c *AlbumController) GetAlbums(ctx *gin.Context) {
	ctx.IndentedJSON(http.StatusOK, c.repository.GetAlbums())
}

func (c *AlbumController) GetAlbumById(ctx *gin.Context) {
	idParam := ctx.Param("id")
	id, err := strconv.ParseInt(idParam, 10, 64)

	if err != nil {
		ctx.String(http.StatusBadRequest, "Invalid id. ID should be a number.")
		return
	}

	ctx.IndentedJSON(http.StatusOK, c.repository.GetAlbumByID(id))
}

func (c *AlbumController) PostAlbum(ctx *gin.Context) {
	album := models.Album{}
	err := ctx.BindJSON(&album)

	if err != nil {
		ctx.String(http.StatusBadRequest, "Invalid JSON body.")
		return
	}

	ctx.IndentedJSON(http.StatusOK, c.repository.InsertAlbum(&album))
}

func (c *AlbumController) UpdateAlbum(ctx *gin.Context) {
	ctx.String(http.StatusNotImplemented, "Not implemented")
}

func (c *AlbumController) DeleteAlbumById(ctx *gin.Context) {
	ctx.String(http.StatusNotImplemented, "Not implemented")
}
