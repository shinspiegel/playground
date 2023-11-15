class_name BaseEnemy extends CharacterBody2D

@export_range(0.0, 3.0, 0.05) var speed_ratio: float = 1.0
@export var inputs: EnemyInput
@export var facing_right: bool = true


func _ready() -> void:
	inputs.changed_direction.connect(on_direction_change)
	
	if not facing_right:
		scale.x *= -1


func apply_gravity(delta: float, ratio: float = 1.0) -> void:
	velocity.y += Constants.GRAVITY * delta * ratio


func apply_horizontal_force(friction: float = 1.0, ratio: float = 1.0) -> void:
	velocity.x = lerp(velocity.x, inputs.direction * Constants.SPEED * speed_ratio * friction * ratio, Constants.ACCELERATION)
	velocity.x = clamp(velocity.x, -Constants.SPEED, Constants.SPEED)


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
