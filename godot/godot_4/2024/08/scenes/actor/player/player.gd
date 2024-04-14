class_name Player extends BaseActor

@export var input: PlayerInput
@export var power_ups: PowerUps
@export var jump_buffer_cast: RayCast2D
@export var coyote_timer: Timer

var __is_coyoting: bool = false


func _physics_process(delta: float) -> void:
	if not is_on_floor() and not __is_coyoting:
		coyote_timer.start()
		__is_coyoting = true

	if is_on_floor():
		coyote_timer.stop()
		__is_coyoting = false

	state_machine.update(delta)


func can_jump() -> bool:
	if jump_buffer_cast.is_colliding() or is_on_floor() or __is_coyoting:
		return true
	return false


func should_fall() -> bool:
	if coyote_timer.time_left <= 0 and not is_on_floor():
		return true
	return false
