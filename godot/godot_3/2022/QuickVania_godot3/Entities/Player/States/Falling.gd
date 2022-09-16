extends BaseState


func enter() -> void:
	if target is Player:
		target.change_animation(name)

		if not target.state_manager.get_last_state() == "Jump":
			target.coyote_timer.start()


func exit() -> void:
	if target is Player:
		target.coyote_timer.start(0)


func process(delta: float) -> void:
	check_change_state()

	if target is Player:
		target.apply_horizontal()

		if target.coyote_timer.time_left <= 0:
			target.apply_gravity(delta)


func check_change_state() -> void:
	if target is Player:
		if target.attempt_to_double_jump():
			return

		if target.attempt_to_dash():
			return

		if target.attempt_to_jump():
			return

		if target.attempt_to_idle():
			return

		if target.attempt_to_move():
			return
