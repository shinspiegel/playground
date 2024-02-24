class_name Player extends CharacterBody2D

const SPEED = 900.0
const JUMP_VELOCITY = -1400.0

@export var input: PlayerInput

var flip_direction: int = 1


func _physics_process(delta: float) -> void:
	apply_gravity(delta)
	apply_vertical_force(input.jump_just_pressed, input.jump_pressed)
	apply_horizontal_force(input.direction)
	apply_flip_scale(input.direction)

	move_and_slide()


func apply_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta


func apply_vertical_force(just_jump: bool, jump: bool) -> void:
	if just_jump and is_on_floor():
		velocity.y = JUMP_VELOCITY

	if not jump and not is_on_floor() and velocity.y < 0:
		velocity.y = lerpf(velocity.y, 0, 0.2)


func apply_horizontal_force(dir: float) -> void:
	if dir:
		velocity.x = dir * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)


func apply_flip_scale(dir: float) -> void:
	if dir != 0:
		if dir > 0 and flip_direction == -1:
			scale.x *= -1
			flip_direction = 1

		if dir < 0 and flip_direction == 1:
			scale.x *= -1
			flip_direction = -1

