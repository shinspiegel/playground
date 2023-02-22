class_name Player extends CharacterBody2D

const SPEED: float = 120.0

var direction: Vector2 = Vector2.ZERO

func _physics_process(_delta: float) -> void:
	get_direction()
	apply_move()


func apply_move() -> void:
	velocity = direction * SPEED
	move_and_slide()


func get_direction() -> void:
	direction = Vector2.ZERO
	direction = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	
	if direction.length() > 1.0:
		direction = direction.normalized()
