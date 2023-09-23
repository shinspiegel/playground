class_name BackgroundMusic extends Node

@export_enum("menu", "game") var music: String = "menu"

const MUSIC = {
	"menu": preload("res://entities/background_music/musics_resources/main_music.tres"),
	"game": preload("res://entities/background_music/musics_resources/game_music.tres"),
}

func _ready() -> void:
	AudioManager.play_music(MUSIC[music])
