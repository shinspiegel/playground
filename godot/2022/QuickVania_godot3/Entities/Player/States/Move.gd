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
		if target.attempt_to_fall():
			return

		if target.attempt_to_charge_attack():
			return

		if target.attempt_to_jump():
			return

		if target.attempt_to_charge_attack():
			return

		if target.attempt_to_dash():
			return

		if target.attempt_to_idle():
			return
