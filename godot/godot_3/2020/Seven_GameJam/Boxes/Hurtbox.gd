extends Area2D
class_name HurtBox

signal hit(damage)

func set_active(value:bool):
	set_monitorable(value)
