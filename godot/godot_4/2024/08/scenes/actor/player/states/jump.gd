extends PlayerState


func enter() -> void:
	player.change_animation(JUMP)
	player.apply_jump()
	# INFO: Neeeds to have the movement applied on the enter
	player.move_and_slide()


func update(delta: float) -> void:
	if player.can_dash() and player.input.dash:
		state_machine.change_state(DASH)
		return

	if player.input.just_release_jump:
		player.set_y_velocity(0.0)
		return

	if player.velocity.y > 0:
		state_machine.change_state(FALLING)
		return

	if player.is_on_floor():
		if player.input.direction == 0.0:
			state_machine.change_state(IDLE)
			return
		else:
			state_machine.change_state(MOVE)
			return

	player.apply_gravity(delta)
	player.apple_direction(player.input.direction, player.data.friction_land, 0.05)
	player.move_and_slide()
	player.check_flip(player.input.last_direction)
