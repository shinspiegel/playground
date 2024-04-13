class_name BaseActor extends CharacterBody2D

@export var data: ActorData
@export var animation_player: AnimationPlayer
@export var state_machine: StateMachine
@onready var flip_enabled_node: Node2D = %FlipEnabled

var facing_direction: int = 1


func apply_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta


func apply_jump() -> void:
	velocity.y = -data.jump_velocity


func set_y_velocity(y_value: float = 0.0) -> void:
	velocity.y = y_value


func apple_direction(direction: float, friction: float, acceleration: float) -> void:
	velocity.x = lerpf(velocity.x, direction * data.speed * friction, acceleration)
	velocity.x = clamp(velocity.x, -data.speed, data.speed)


func check_flip(direction: float) -> void:
	if direction != 0:
		if direction > 0 and facing_direction == -1:
			flip_enabled_node.scale.x *= -1
			facing_direction = 1
		if direction < 0 and facing_direction == 1:
			flip_enabled_node.scale.x *= -1
			facing_direction = -1


func change_animation(anim: String) -> void:
	if not animation_player.current_animation == anim:
		animation_player.play(anim)
