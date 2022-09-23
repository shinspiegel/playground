extends Node


const LEVEL_SIZE = {
	"height": 160,
	"width": 320,
}

const KEYS = {
	"left": "ui_left", 
	"right": "ui_right", 
	"jump": "ui_accept",
}


var MUSICS = {
	"test_music": load("res://assets/music/song18.ogg"),
	"start": load("res://assets/music/b423b42.wav"),
}

var SCREENS = {
	"start_screen": load("res://screens/start_screen.tscn"),
}


var LEVELS = {
	"level_1": load("res://levels/level.tscn"),
}
