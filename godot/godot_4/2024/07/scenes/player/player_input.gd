class_name PlayerInput extends Node

@export var direction: float = 0.0
@export var jump_just_pressed: bool = false
@export var jump_pressed: bool = false


func _physics_process(_delta: float) -> void:
	direction = Input.get_axis("ui_left", "ui_right")
	jump_just_pressed = Input.is_action_just_pressed("ui_accept")
	jump_pressed = Input.is_action_pressed("ui_accept")
