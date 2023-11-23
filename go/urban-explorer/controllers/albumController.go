package controllers

import (
	"net/http"
	"urban-explorer/models"

	"github.com/gin-gonic/gin"
)

var albums = []models.Album{}

type AlbumRepository interface {
	GetAlbums() []models.Album
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
	c.IndentedJSON(http.StatusOK, ct.repository.GetAlbums())
}

func (ct *AlbumController) PostAlbum(c *gin.Context) {
	c.IndentedJSON(http.StatusOK, ct.repository.GetAlbums())
}
