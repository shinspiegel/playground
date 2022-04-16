extends Node

onready var Character := get_owner()

var move_direction := -1
var Target : KinematicBody2D


func set_direction(direction : int) -> void:
	if direction > 0:
		move_direction = 1
	elif direction < 0:
		move_direction = -1
	else:
		return

func change_direction() -> void:
	if move_direction == 1:
		move_direction = -1
	else:
		move_direction = 1


func _on_DetectionArea_body_entered(body) -> void:
	if body.name == "Player":
		Target = body
		Character.state_manager("Chase")


func _on_DetectionArea_body_exited(body):
	if body.name == "Player":
		Target = null
		Character.state_manager("Watch")
