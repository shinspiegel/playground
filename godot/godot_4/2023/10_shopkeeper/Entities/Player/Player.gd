class_name Player extends CharacterBody2D

const Speed: float = 500.0

var direction: Vector2 = Vector2.ZERO


func _physics_process(delta: float) -> void:
	apply_direction()
	apply_movement()


func apply_direction() -> void:
	velocity = (Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").normalized()) * Speed


func apply_movement() -> void:
	move_and_slide()
