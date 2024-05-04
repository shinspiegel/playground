extends PlayerState

@export var jump_audio: AudioStream

func enter() -> void:
	player.change_animation(JUMP)
	player.apply_jump()
	# INFO: Neeeds to have the movement applied on the enter
	player.move_and_slide()
	AudioManager.create_sfx(jump_audio, randf_range(0.8, 1.6))


func update(delta: float) -> void:
	if player.input.just_release_jump:
		player.set_y_velocity(0.0)
		return

	if player.input.attack:
		state_machine.change_by_name(AIR_JAB)
		return

	if player.can_shoot() and player.input.ranged:
		state_machine.change_by_name(AIR_RANGED)
		return

	if player.can_dash() and player.input.dash:
		state_machine.change_by_name(DASH)
		return

	if player.velocity.y > 0:
		state_machine.change_by_name(FALLING)
		return

	if player.is_on_floor():
		if player.input.direction == 0.0:
			state_machine.change_by_name(IDLE)
			return
		else:
			state_machine.change_by_name(MOVE)
			return

	player.apply_gravity(delta)
	player.apply_direction(player.input.direction, player.data.friction_land, 0.05)
	player.move_and_slide()
	player.check_flip(player.input.last_direction)
