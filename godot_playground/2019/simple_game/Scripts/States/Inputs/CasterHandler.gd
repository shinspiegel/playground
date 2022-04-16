extends Node2D

onready var Character := get_owner()
onready var AttackRay := get_node("AttackRay")
onready var RunAway := get_node("RunAway")

var move_direction := -1
var Target : KinematicBody2D


func _process(delta):
	if RunAway.is_colliding():
		Character.state_manager("MoveAway")
	elif AttackRay.is_colliding() && !RunAway.is_colliding():
		Character.state_manager("Cast")

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

func _on_PlayerFinder_body_entered(body):
	if body.name == "Player":
		Target = body

func _on_PlayerFinder_body_exited(body):
	if body.name == "Player":
		Target = null
		