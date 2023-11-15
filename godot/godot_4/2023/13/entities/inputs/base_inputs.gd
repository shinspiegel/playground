class_name BaseInputs extends Node

@export var direction: float = 0.0
@export var last_direction: float = 0.0
@export var is_jump_just_pressed: bool = false
@export var is_jump_just_released: bool = false
@export var is_hide_just_pressed: bool = false
@export var is_attack_just_pressed: bool = false
@export var is_interact_just_pressed: bool = false


func is_horizontal_zero() -> bool:
	return direction == 0.0


func reset() -> void:
	is_jump_just_pressed = false
	is_jump_just_released = false
	is_hide_just_pressed = false
	is_attack_just_pressed = false
	direction = 0.0
