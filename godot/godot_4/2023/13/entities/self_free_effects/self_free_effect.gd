class_name SelfFreeEffect extends Node2D

func set_direction(dir: float) -> void:
	if dir < 0:
		scale.x *= -1
