class_name MusicManager extends Node

const music_loads = {
	"menu": preload("res://Assets/Audio/hope.ogg"),
	"dungeon": preload("res://Assets/Audio/frozen_winter.ogg"),
}

@onready var background_music: AudioStreamPlayer = $BackgroundMusic


var volume: float = 1.0


func set_volume(ratio: float) -> void:
	background_music.volume_db = convert_float_to_db(ratio)
	volume = ratio


func get_volume() -> float:
	return volume


func play_menu_music() -> void:
	change_music(music_loads.menu)


func play_dungeon_music() -> void:
	change_music(music_loads.dungeon)


func change_music(stream: AudioStream) -> void:
	if not background_music.stream == stream:
		background_music.stop()
		background_music.stream = stream
		background_music.play()


func convert_float_to_db(value: float) -> float:
	if value >= 0:
		return log(value) * 20
	else:
		return -80.0
