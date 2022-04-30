extends Node2D

onready var Character := get_owner()

var move_direction := -1
var Target : KinematicBody2D

func change_direction() -> void:
	if move_direction == 1:
		move_direction = -1
	else:
		move_direction = 1


func _on_PlayerDetection_body_entered(body):
	if body.name == "Player":
		Target = body
		Character.state_manager("Guard")

func _on_PlayerDetection_body_exited(body):
	if body.name == "Player" && Character.current_state != Character.STATE_MAP["Guard"]:
		Target = null
		Character.state_manager("Watch")
