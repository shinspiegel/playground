extends PlayerState


func enter() -> void:
	player.change_animation(IDLE)


func update(delta: float) -> void:
	if player.can_dash() and player.input.dash:
		state_machine.change_state(DASH)
		return

	if player.can_roll() and player.input.roll:
		state_machine.change_state(ROLL)
		return

	if player.can_create_block() and player.input.block:
		state_machine.change_state(BLOCK)
		return

	if player.can_shoot() and player.input.ranged:
		state_machine.change_state(RANGED)
		return

	if player.is_on_floor() and player.input.attack:
		state_machine.change_state(JAB)
		return

	if player.should_fall():
		state_machine.change_state(FALLING)
		return

	if player.input.just_jump and player.can_jump():
		state_machine.change_state(JUMP)
		return

	if not player.input.direction == 0.0:
		state_machine.change_state(MOVE)
		return

	if player.should_fall():
		player.apply_gravity(delta)

	player.apply_direction(0, player.data.friction_land, 0.5)
	player.move_and_slide()
	player.check_flip(player.input.last_direction)
