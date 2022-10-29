extends Node

const VOICES_NAME = {
	"hero": "hero_voice",
	"vampire": "vampire_voice",
	"default": "default_voice",
}

const LEVEL_SIZE = {
	"height": 160,
	"width": 320,
}

const VOICES = {
	"PITCH_MULTIPLIER_RANGE": 0.3,
	"INFLECTION_SHIFT": 0.4,
}

const KEYS = {
	"left": "left", 
	"right": "right", 
	"jump": "jump",
	"attack": "attack"
}

const MUSICS = {
	"test_music": preload("res://assets/music/song18.ogg"),
	"start": preload("res://assets/music/b423b42.wav"),
}

var SCREENS = {
	"start": load("res://screens/screens/start.tscn"),
	"options": load("res://screens/screens/options.tscn"),
	"game_over": load("res://screens/screens/game_over.tscn"),
}

var LEVELS = {
	"level_1": load("res://levels/level.tscn"),
}
