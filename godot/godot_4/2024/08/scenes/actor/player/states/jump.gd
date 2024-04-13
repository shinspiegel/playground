extends PlayerState


func enter() -> void:
	actor.change_animation(JUMP)
	actor.apply_jump()
	# INFO: Neeeds to have the movement applied on the enter
	actor.move_and_slide()


func update(delta: float) -> void:
	if actor.input.just_release_jump:
		actor.set_y_velocity(0.0)
		return

	if actor.velocity.y > 0:
		state_machine.change_state(FALLING)
		return

	if actor.is_on_floor():
		if actor.input.direction == 0.0:
			state_machine.change_state(IDLE)
			return
		else:
			state_machine.change_state(MOVE)
			return

	actor.apply_gravity(delta)
	actor.apple_direction(actor.input.direction, actor.data.friction_land, 0.05)
	actor.move_and_slide()
	actor.check_flip(actor.input.last_direction)
