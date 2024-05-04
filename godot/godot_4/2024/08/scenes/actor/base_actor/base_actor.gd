class_name BaseActor extends CharacterBody2D

@export var data: ActorData = ActorData.new()

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var state_machine: StateMachine = $StateMachine
@onready var damage_position: Node2D = $FlipEnabled/DamagePos
@onready var flip_enabled_node: Node2D = $FlipEnabled

var facing_direction: int = 1


func apply_gravity(delta: float, ratio: float = 1.0) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta * ratio


func apply_jump() -> void:
	velocity.y = -data.jump_velocity


func set_y_velocity(y_value: float = 0.0) -> void:
	velocity.y = y_value


func apply_direction(direction: float, friction: float, acceleration: float, ratio: float = 1.0) -> void:
	velocity.x = lerpf(velocity.x, direction * data.speed * friction, acceleration)
	velocity.x = clamp(velocity.x, -data.speed, data.speed)
	velocity.x *= ratio


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
