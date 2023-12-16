package app

import (
	"net/http"

	"github.com/gin-gonic/gin"
)

func (a *App) Add404Routes() {
	a.services.log.Debug("add 404 route")
	a.router.NoRoute(func(g *gin.Context) {
		g.JSON(http.StatusNotFound, gin.H{"error": "route not found"})
	})
}
