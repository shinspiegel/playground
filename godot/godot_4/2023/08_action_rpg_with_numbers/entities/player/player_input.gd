class_name PlayerInput extends Node

@export var player: Player

var attack: bool

func _process(_delta: float) -> void:
	attack = Input.is_action_just_pressed(Constants.key_map.ATTACK)


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
