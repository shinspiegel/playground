extends PlayerState


func update(delta: float) -> void:
	if not actor.is_on_floor():
		state_machine.change_state("Falling")
		return

	if actor.input.just_jump:
		state_machine.change_state("Jump")
		return

	if actor.input.direction == 0.0:
		state_machine.change_state("Idle")
		return

	actor.apply_gravity(delta)
	actor.apple_direction(actor.input.direction, actor.data.land_friction)
	actor.move_and_slide()
	actor.check_flip(actor.input.last_direction)
