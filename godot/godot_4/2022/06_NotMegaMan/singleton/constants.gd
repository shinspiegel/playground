extends Node

const INPUT_KEYS = {
	"up": "up",
	"down": "down",
	"left": "left",
	"right": "right",
	"attack": "attack",
	"jump": "jump",
}

const BLOCK_SIZE = 32

var SCREENS = {
	"start": load("res://screens/start_screen.tscn"),
	"options": load("res://screens/options.tscn"),
	"select": load("res://screens/level_select.tscn"),
}

var LEVELS = {
	"base": load("res://levels/base_level.tscn"),
	"mining": load("res://levels/mining_level.tscn"),
	"laboratory": load("res://levels/base_level.tscn"),
}