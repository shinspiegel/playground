extends Node


func float_to_volume_db(volume: float = 0.0) -> float:
	if volume > 0:
		return log(volume) * 20
	else:
		return -90.0
