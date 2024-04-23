class_name OneWayBlock extends Node2D

@export var player_input: PlayerInput
@export var shape: CollisionShape2D


func _physics_process(_delta: float) -> void:
	if player_input.down >= 0.2 and not shape.disabled:
		shape.disabled = true

	if player_input.down < 0.2 and shape.disabled:
		shape.disabled = false

