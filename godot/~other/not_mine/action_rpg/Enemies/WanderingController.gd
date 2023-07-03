extends Node2D

export (int) var wander_range = 32

onready var initial_position = global_position
onready var target_position = global_position
onready var timer = $Timer

func update_target_position():
	var random_position = Vector2(rand_range(-wander_range, wander_range), rand_range(-wander_range, wander_range))
	target_position = initial_position + random_position


func set_wander_timer(value:float):
	timer.start(value)


func time_left():
	return timer.time_left


func _on_Timer_timeout():
	update_target_position()
