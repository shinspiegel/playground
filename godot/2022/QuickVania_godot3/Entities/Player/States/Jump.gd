extends BaseState


func enter() -> void:
	if target is Player:
		target.change_animation(name)
		target.velocity.y = target.jump_velocity


func process(delta: float) -> void:
	check_change_state()

	if target is Player:
		target.apply_horizontal()
		target.apply_gravity(delta)

		if target.input.jump_release and target.velocity.y < target.min_jump_height:
			target.velocity.y = target.min_jump_height


func check_change_state() -> void:
	if target is Player:
		if target.velocity.y >= 0:
			target.change_state("Falling")
			return

		if target.attempt_to_dash():
			return
