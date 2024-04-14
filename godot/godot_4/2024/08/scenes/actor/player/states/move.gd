extends PlayerState


func enter() -> void:
	actor.change_animation(MOVE)


func update(delta: float) -> void:
	if actor.is_on_floor() and actor.input.roll:
		state_machine.change_state(ROLL)
		return

	if actor.is_on_floor() and actor.input.attack:
		state_machine.change_state(JAB)
		return

	if not actor.is_on_floor():
		state_machine.change_state(FALLING)
		return

	if actor.input.just_jump:
		state_machine.change_state(JUMP)
		return

	if actor.input.direction == 0.0:
		state_machine.change_state(IDLE)
		return

	actor.apply_gravity(delta)
	actor.apple_direction(actor.input.direction, actor.data.friction_land, 0.1)
	actor.move_and_slide()
	actor.check_flip(actor.input.last_direction)