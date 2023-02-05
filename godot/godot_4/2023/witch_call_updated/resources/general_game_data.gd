class_name GeneralGameData extends Resource

@export_range(0.0, 1, 0.1) var sound_volume: float = 1.0
@export_range(0.0, 1, 0.1) var music_volume: float = 0.4


func get_sound_db() -> float:
	return convert_float_to_db(sound_volume)


func get_music_db() -> float:
	return convert_float_to_db(music_volume)


func convert_float_to_db(value: float) -> float:
	if value >= 0:
		return log(value) * 20
	else:
		return -80.0
