class_name GameData extends Resource

@export_range(0.0, 1, 0.1) var sound_volume: float = 1.0
@export_range(0.0, 1, 0.1) var music_volume: float = 1.0


func get_sound_db() -> float:
	if sound_volume >= 0:
		return log(sound_volume) * 20
	else:
		return -90.0


func get_music_db() -> float:
	if music_volume >= 0:
		return log(music_volume) * 20
	else:
		return -90.0
