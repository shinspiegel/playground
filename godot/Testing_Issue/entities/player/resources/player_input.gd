class_name PlayerInput extends Resource

@export var is_enabled: bool = true
@export var direction: float = 0.0
@export var jump: bool =  false
@export var jump_released: bool = false
@export var attack: bool = false


func reset() -> void:
	if is_enabled:
		direction = 0.0
		jump =  false
		jump_released = false
		attack = false


func enable() -> void:
	is_enabled = true


func disable() -> void:
	is_enabled = false
