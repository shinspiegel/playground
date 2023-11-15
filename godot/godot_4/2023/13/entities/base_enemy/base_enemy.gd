class_name BaseEnemy extends CharacterBody2D

const MULTIPLIER = 100.0
const SPEED = 10.0 * MULTIPLIER
const JUMP_VELOCITY = 20.0 * MULTIPLIER
const GRAVITY = 60 * MULTIPLIER
const ACCELERATION = 0.2

@export var inputs: EnemyInput
@export var facing_right: bool = true


func _ready() -> void:
	inputs.changed_direction.connect(on_direction_change)
	
	if not facing_right:
		scale.x *= -1


func apply_gravity(delta: float, ratio: float = 1.0) -> void:
	velocity.y += GRAVITY * delta * ratio


func apply_horizontal_force(friction: float = 1.0, ratio: float = 1.0) -> void:
	velocity.x = lerp(velocity.x, inputs.direction * SPEED * friction * ratio, ACCELERATION)
	velocity.x = clamp(velocity.x, -SPEED, SPEED)


func on_direction_change() -> void:
	__flip()


## Private Methods


func __flip() -> void:
	if inputs.last_direction != 0:
		if inputs.last_direction > 0 and not facing_right:
			scale.x *= -1
			facing_right = true
		if inputs.last_direction < 0 and facing_right:
			scale.x *= -1
			facing_right = false
