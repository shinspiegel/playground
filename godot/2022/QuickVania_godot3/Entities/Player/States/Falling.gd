extends BaseState


func enter() -> void:
	if target is Player:
		if not target.state_manager.get_last_state() == "Jump":
			target.coyote_timer.start()


func exit() -> void:
	if target is Player:
		target.coyote_timer.stop()


func process(delta: float) -> void:
	check_change_state()

	if target is Player:
		target.apply_horizontal()

		if target.coyote_timer.time_left <= 0:
			target.apply_gravity(delta)


func check_change_state() -> void:
	if target is Player:
		if (target.is_on_floor() or target.coyote_timer.time_left > 0) and target.input.jump_press:
			target.change_state("Jump")

		if target.is_on_floor():
			if target.input.direction == 0:
				target.change_state("Idle")

			if not target.input.direction == 0:
				target.change_state("Move")
