package main

import (
	"urban-explorer/app"
	"urban-explorer/env"
)

func main() {
	env.ReadEnv()
	app.NewApp().Run()
}
