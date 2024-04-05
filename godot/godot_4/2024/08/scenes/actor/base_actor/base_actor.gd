class_name BaseActor extends CharacterBody2D

@export var data: ActorData
@onready var flip_enabled_node: Node2D = %FlipEnabled

var facing_direction: int = 1


func apply_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta


func apply_jump() -> void:
	velocity.y = -data.jump_velocity


func apple_direction(direction: float, friction: float = 1.0, ratio: float = 1.0) -> void:
	velocity.x = lerpf(velocity.x, direction * data.speed * friction * ratio, data.acceleration)
	velocity.x = clamp(velocity.x, -data.speed, data.speed)


func check_flip(direction: float) -> void:
	if direction != 0:
		if direction > 0 and facing_direction == -1:
			flip_enabled_node.scale.x *= -1
			facing_direction = 1
		if direction < 0 and facing_direction == 1:
			flip_enabled_node.scale.x *= -1
			facing_direction = -1
