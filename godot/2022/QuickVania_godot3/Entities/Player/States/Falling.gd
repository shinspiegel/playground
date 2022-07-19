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
		if target.should_double_jump():
			return

		if target.should_dash():
			return

		if target.should_jump():
			return

		if target.should_idle():
			return

		if target.should_move():
			return
