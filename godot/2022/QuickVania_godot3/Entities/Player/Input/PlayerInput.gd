class_name PlayerInput extends Node

export var direction: float = 0.0
export var jump_press: bool = false
export var jump_release: bool = false
export var attack: bool = false


func _process(_delta: float) -> void:
	reset_all()

	if Input.is_action_just_pressed(KeysMap.JUMP):
		jump_press = true

	if Input.is_action_just_released(KeysMap.JUMP):
		jump_release = true

	if Input.is_action_pressed(KeysMap.ATTACK):
		attack = true

	if not Input.get_axis(KeysMap.LEFT, KeysMap.RIGHT) == 0.0:
		direction = Input.get_axis(KeysMap.LEFT, KeysMap.RIGHT)


func reset_all() -> void:
	direction = 0.0
	jump_press = false
	jump_release = false
	attack = false
