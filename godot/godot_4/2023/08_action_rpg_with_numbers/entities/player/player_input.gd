class_name PlayerInput extends Node

@export var player: Player

var attack_left: bool
var attack_right: bool


func _process(_delta: float) -> void:
	attack_left = Input.is_action_pressed(Constants.key_map.ATTACK_LEFT)
	attack_right = Input.is_action_pressed(Constants.key_map.ATTACK_RIGHT)


## Returns the controller input
func get_input() -> Vector2:
	return Input.get_vector(
		Constants.key_map.LEFT, 
		Constants.key_map.RIGHT, 
		Constants.key_map.UP, 
		Constants.key_map.DOWN
	)


## Returns the direction for the 3d plane normalized
func get_direction() -> Vector3:
	var direction := (player.transform.basis * Vector3(get_input().x, 0, get_input().y)).normalized()
	return direction
