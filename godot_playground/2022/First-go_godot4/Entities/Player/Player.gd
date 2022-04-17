class_name Player extends CharacterBody2D

@onready var movement = $Movement


func _physics_process(delta: float) -> void:
	velocity = movement.apply_gravity(velocity, delta, is_on_floor())
	velocity = movement.apply_jump(velocity, is_on_floor())
	velocity = movement.apply_horizontal(velocity)
	
	move_and_slide()
