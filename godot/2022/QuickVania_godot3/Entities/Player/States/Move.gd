extends BaseState


func process(_delta: float) -> void:
	check_change_state()

	if target is Player:
		target.apply_horizontal()


func check_change_state() -> void:
	if target is Player:
		if not target.is_on_floor():
			target.change_state("Falling")

		if target.is_on_floor() and target.input.jump_press:
			target.change_state("Jump")

		if target.velocity.x == 0.0 and target.input.direction == 0.0:
			target.change_state("Idle")
