class_name PlayerInput extends Node

const UP = "forward"
const DOWN = "backward"
const LEFT = "left"
const RIGHT = "right"
const JUMP = "jump"

@export var jump: bool


func _process(_delta: float) -> void:
	jump = Input.is_action_just_pressed(JUMP)


func has_jump() -> bool:
	return jump


## Returns the controller input
func get_input() -> Vector2:
	return Input.get_vector(LEFT, RIGHT, UP, DOWN)


## Returns the direction for the 3d plane normalized
func get_direction(player_basis: Basis) -> Vector3:
	var direction := (player_basis * Vector3(get_input().x, 0, get_input().y)).normalized()
	return direction
