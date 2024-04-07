extends PlayerState


func enter() -> void:
	actor.apply_jump()


func update(delta: float) -> void:
	if actor.velocity.y > 0:
		state_machine.change_state("Falling")
		return

	if actor.is_on_floor():
		if actor.input.direction == 0.0:
			state_machine.change_state("Idle")
			return
		else:
			state_machine.change_state("Move")
			return

	actor.apply_gravity(delta)
	actor.apple_direction(actor.input.direction, actor.data.land_friction)
	actor.move_and_slide()
	actor.check_flip(actor.input.last_direction)
