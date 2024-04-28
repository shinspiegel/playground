extends PlayerState


func enter() -> void:
	player.change_animation(IDLE)


func update(delta: float) -> void:
	if player.can_dash() and player.input.dash:
		state_machine.change_by_name(DASH)
		return

	if player.can_roll() and player.input.roll:
		state_machine.change_by_name(ROLL)
		return

	if player.can_create_block() and player.input.block:
		state_machine.change_by_name(BLOCK)
		return

	if player.can_shoot() and player.input.ranged:
		state_machine.change_by_name(RANGED)
		return

	if player.is_on_floor() and player.input.attack:
		state_machine.change_by_name(JAB)
		return

	if player.should_fall():
		state_machine.change_by_name(FALLING)
		return

	if player.input.just_jump and player.can_jump():
		state_machine.change_by_name(JUMP)
		return

	if not player.input.direction == 0.0:
		state_machine.change_by_name(MOVE)
		return

	if player.should_fall():
		player.apply_gravity(delta)

	player.apply_direction(0, player.data.friction_land, 0.5)
	player.move_and_slide()
	player.check_flip(player.input.last_direction)
