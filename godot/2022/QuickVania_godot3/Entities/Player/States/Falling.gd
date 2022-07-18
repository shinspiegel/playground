extends BaseState


func enter() -> void:
	if target is Player:
		target.change_animation(name)

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
		var is_grounded = target.is_on_floor() or target.coyote_timer.time_left > 0
		var is_jump_buffed = not target.is_on_floor() and target.is_jump_buffer()

		if target.power_ups.is_double_jump_active:
			if target.input.jump_press and not target.power_ups.is_doulbe_jump_used:
				target.change_state("DoubleJump")
				return

		if target.input.dash and target.power_ups.is_dash_active and target.can_dash:
			target.change_state("Dash")
			return

		if (is_grounded or is_jump_buffed) and target.input.jump_press:
			target.change_state("Jump")
			return

		if target.is_on_floor():
			if target.input.direction == 0:
				target.change_state("Idle")
				return

			if not target.input.direction == 0:
				target.change_state("Move")
				return
