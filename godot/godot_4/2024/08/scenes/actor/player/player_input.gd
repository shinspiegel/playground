class_name PlayerInput extends Node

@export var direction: float = 0.0
@export var last_direction: float = 0.0
@export var just_jump: bool = false


func _physics_process(_delta: float) -> void:
	direction = Input.get_axis("ui_left", "ui_right")
	just_jump = Input.is_action_just_pressed("ui_accept")

	if direction != 0.0:
		last_direction = direction

