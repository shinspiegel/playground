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

func (ct *AlbumController) GetAlbums(c *gin.Context) {
	c.IndentedJSON(http.StatusOK, ct.repository.GetAlbums())
}

func (ct *AlbumController) GetAlbumById(c *gin.Context) {
	idParam := c.Param("id")
	id, err := strconv.ParseInt(idParam, 10, 64)

	if err != nil {
		c.String(http.StatusBadRequest, "Invalid id. ID should be a number.")
		return
	}

	c.IndentedJSON(http.StatusOK, ct.repository.GetAlbumByID(id))
}

func (ct *AlbumController) PostAlbum(c *gin.Context) {
	album := models.Album{}
	err := c.BindJSON(&album)

	if err != nil {
		c.String(http.StatusBadRequest, "Invalid JSON body.")
		return
	}

	c.IndentedJSON(http.StatusOK, ct.repository.InsertAlbum(&album))
}
