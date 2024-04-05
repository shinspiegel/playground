class_name BaseActor extends CharacterBody2D

@export var data: ActorData


func apply_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta


func apply_jump() -> void:
	velocity.y = -data.jump_velocity


func apple_direction(direction: float, friction: float = 1.0, ratio: float = 1.0) -> void:
	velocity.x = lerpf(velocity.x, direction * data.speed * friction * ratio, data.acceleration)
	velocity.x = clamp(velocity.x, -data.speed, data.speed)
