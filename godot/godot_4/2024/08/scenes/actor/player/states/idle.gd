extends PlayerState


func enter() -> void:
	actor.change_animation(IDLE)


func update(delta: float) -> void:
	if not actor.is_on_floor():
		state_machine.change_state(FALLING)
		return

	if actor.input.just_jump:
		state_machine.change_state(JUMP)
		return

	if not actor.input.direction == 0.0:
		state_machine.change_state(MOVE)
		return

	actor.apply_gravity(delta)
	actor.apple_direction(0.0, actor.data.land_friction)
	actor.move_and_slide()
	actor.check_flip(actor.input.last_direction)
