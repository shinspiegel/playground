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
		if target.is_on_floor():
			if target.input.charge_attack and target.power_ups.is_charge_attack_active:
				target.change_state("ChargingAttack")
				return

			if target.input.dash and target.power_ups.is_dash_active and target.can_dash:
				target.change_state("Dash")
				return

			if target.input.jump_press:
				target.change_state("Jump")
				return

			if target.input.attack:
				target.change_state("Attack")
				return

		else:
			target.change_state("Falling")
			return

		if target.input.direction == 0.0:
			target.change_state("Idle")
			return
