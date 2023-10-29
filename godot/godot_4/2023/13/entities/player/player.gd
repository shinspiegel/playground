class_name Player extends CharacterBody2D

const MULTIPLIER = 100.0
const SPEED = 16.0 * MULTIPLIER
const JUMP_VELOCITY = 16.0 * MULTIPLIER
const GRAVITY = 60 * MULTIPLIER
const ACCELERATION = 0.2

@export var state_machine: StateMachine
@export var inputs: PlayerInputs

var __facing: int = 1


func _process(_delta: float) -> void:
	__flip()


func apply_gravity(delta: float, ratio: float = 1.0) -> void:
	if not is_on_floor():
		velocity.y += GRAVITY * delta * ratio


func is_horizontal_zero() -> bool:
	return velocity.x == 0.0


func apply_horizontal_force(direction: float, friction: float = 1.0) -> void:
	velocity.x = lerp(velocity.x, direction * SPEED * friction, ACCELERATION)
	velocity.x = clamp(velocity.x, -SPEED, SPEED)


## Private Methods


func __flip() -> void:
	if inputs.last_direction != 0:
		if inputs.last_direction > 0 and __facing == -1:
			scale.x *= -1
			__facing = 1
		if inputs.last_direction < 0 and __facing == 1:
			scale.x *= -1
			__facing = -1
