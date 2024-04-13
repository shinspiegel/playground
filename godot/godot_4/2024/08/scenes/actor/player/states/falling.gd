extends PlayerState


func enter() -> void:
	actor.change_animation(FALLING)


func update(delta: float) -> void:
	if actor.is_on_floor():
		if actor.input.direction == 0.0:
			state_machine.change_state(IDLE)
			return
		else:
			state_machine.change_state(MOVE)
			return

	actor.apply_gravity(delta)
	actor.apple_direction(actor.input.direction, actor.data.friction_air, actor.data.acceleration_falling)
	actor.move_and_slide()
	actor.check_flip(actor.input.last_direction)
