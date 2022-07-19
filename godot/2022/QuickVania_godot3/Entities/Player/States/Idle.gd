extends BaseState


func enter() -> void:
	if target is Player:
		target.change_animation(name)
		target.velocity = Vector2.ZERO


func process(_delta: float) -> void:
	check_change_state()


func check_change_state() -> void:
	if target is Player:
		if target.should_fall():
			return

		if target.should_move():
			return

		if target.should_jump():
			return

		if target.should_dash():
			return

		if target.should_charge_attack():
			return

		if target.should_charge_attack():
			return
