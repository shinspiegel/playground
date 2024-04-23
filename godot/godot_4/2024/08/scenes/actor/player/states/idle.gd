extends PlayerState


func enter() -> void:
	actor.change_animation(IDLE)


func update(delta: float) -> void:
	if actor.can_dash() and actor.input.dash:
		state_machine.change_state(DASH)
		return

	if actor.can_roll() and actor.input.roll:
		state_machine.change_state(ROLL)
		return

	if actor.can_create_block() and actor.input.block:
		state_machine.change_state(BLOCK)
		return

	if actor.can_shoot() and actor.input.ranged:
		state_machine.change_state(RANGED)
		return

	if actor.is_on_floor() and actor.input.attack:
		state_machine.change_state(JAB)
		return

	if actor.should_fall():
		state_machine.change_state(FALLING)
		return

	if actor.input.just_jump and actor.can_jump():
		state_machine.change_state(JUMP)
		return

	if not actor.input.direction == 0.0:
		state_machine.change_state(MOVE)
		return

	if actor.should_fall():
		actor.apply_gravity(delta)

	actor.apple_direction(0, actor.data.friction_land, 0.5)
	actor.move_and_slide()
	actor.check_flip(actor.input.last_direction)
