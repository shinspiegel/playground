extends Node


const SCREEN_SIZE = {
	"height": 160,
	"width": 320,
}

const KEYS = {
	"left": "ui_left", 
	"right": "ui_right", 
	"jump": "ui_accept",
}


var SCREENS = {
	"start_screen": load("res://screens/start_screen.tscn"),
}


var LEVELS = {
	"level_1": load("res://levels/level.tscn"),
}