extends BaseState


func enter() -> void:
	if target is Player:
		target.change_animation(name)
		target.power_ups.is_doulbe_jump_used = false


func process(_delta: float) -> void:
	check_change_state()

	if target is Player:
		target.apply_horizontal()


func check_change_state() -> void:
	if target is Player:
		if target.should_fall():
			return

		if target.should_charge_attack():
			return

		if target.should_jump():
			return

		if target.should_charge_attack():
			return

		if target.should_dash():
			return

		if target.should_idle():
			return
