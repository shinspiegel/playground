class_name BackgroundMusic extends Node

@export_enum(
	"elara_prelude",
	"ancient_dynasties",
	"neon_nexus",
	"whispers_of_the_woodlands",
	"game_over"
) var music: String = "elara_prelude"

const MUSIC = {
	"ancient_dynasties": preload("res://entities/background_music/musics_resources/ancient_dynasties.tres"), 
	"elara_prelude": preload("res://entities/background_music/musics_resources/elara_prelude.tres"), 
	"neon_nexus": preload("res://entities/background_music/musics_resources/neon_nexus.tres"), 
	"whispers_of_the_woodlands": preload("res://entities/background_music/musics_resources/whispers_of_the_woodlands.tres"),
	"game_over": preload("res://entities/background_music/musics_resources/game_over.tres"),
}

func _ready() -> void:
	if music and MUSIC.has(music):
		AudioManager.play_music(MUSIC[music])
