class_name SoundManager extends Node


var volume: float = 1.0


func set_volume(ratio: float) -> void:
	volume = ratio


func get_volume() -> float:
	return volume
