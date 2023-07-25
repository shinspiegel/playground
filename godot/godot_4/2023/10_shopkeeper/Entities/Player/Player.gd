class_name Player extends CharacterBody2D

const Speed: float = 500.0

var direction: Vector2 = Vector2.ZERO
var velocity: Vector2 = Vector2.ZERO


func _physics_process(float delta):
	apply_direction()
	apply_movement()


func apply_direction()
	velocity = (Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").normalize()) * Speed


func apply_movement()
	move_and_slide()