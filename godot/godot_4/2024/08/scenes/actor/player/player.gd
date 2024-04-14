class_name Player extends BaseActor

@export var input: PlayerInput
@export var power_ups: PowerUps
@export var jump_buffer_cast: RayCast2D


func _physics_process(delta: float) -> void:
	state_machine.update(delta)


func can_jump() -> bool:
	if jump_buffer_cast.is_colliding() or is_on_floor():
		return true

	return false
