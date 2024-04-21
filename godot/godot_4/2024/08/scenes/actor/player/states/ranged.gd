extends PlayerState


func enter() -> void:
	actor.change_animation(RANGED)


func update(delta: float) -> void:
	if actor.should_fall():
		actor.apply_gravity(delta)

	actor.apple_direction(0, actor.data.friction_land, 0.5)
	actor.move_and_slide()
	actor.check_flip(actor.input.last_direction)
