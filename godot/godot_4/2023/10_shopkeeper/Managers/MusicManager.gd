class_name MusicManager extends Node


var volume: float = 1.0

@onready var background_music: AudioStreamPlayer = $BackgroundMusic


func set_volume(ratio: float) -> void:
	volume = ratio


func get_volume() -> float:
	return volume
