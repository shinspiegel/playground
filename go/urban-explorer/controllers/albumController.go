package controllers

import (
	"net/http"
	"strconv"
	"urban-explorer/models"

	"github.com/gin-gonic/gin"
)

type AlbumRepository interface {
	GetAll() []models.Album
	GetById(int64) []models.Album
	Insert(album *models.Album) *models.Album
	Update(album *models.Album) *models.Album
	DeleteById(int64) *models.Album
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
	ctx.IndentedJSON(http.StatusOK, c.repository.GetAll())
}

func (c *AlbumController) GetAlbumById(ctx *gin.Context) {
	id, err := strconv.ParseInt(ctx.Param("id"), 10, 64)
	if err != nil {
		ctx.String(http.StatusBadRequest, "Invalid id. ID should be a number.")
		return
	}

	ctx.IndentedJSON(http.StatusOK, c.repository.GetById(id))
}

func (c *AlbumController) PostAlbum(ctx *gin.Context) {
	album := models.Album{}
	err := ctx.BindJSON(&album)

	if err != nil {
		ctx.String(http.StatusBadRequest, "Invalid JSON body.")
		return
	}

	ctx.IndentedJSON(http.StatusCreated, c.repository.Insert(&album))
}

func (c *AlbumController) UpdateAlbum(ctx *gin.Context) {
	album := models.Album{}
	err := ctx.BindJSON(&album)

	if err != nil {
		ctx.String(http.StatusBadRequest, "Invalid JSON body.")
		return
	}

	ctx.IndentedJSON(http.StatusOK, c.repository.Update(&album))
}

func (c *AlbumController) DeleteAlbumById(ctx *gin.Context) {
	id, err := strconv.ParseInt(ctx.Param("id"), 10, 64)
	if err != nil {
		ctx.String(http.StatusBadRequest, "Invalid id. Id should be a number.")
		return
	}

	ctx.IndentedJSON(http.StatusOK, c.repository.DeleteById(id))
}
