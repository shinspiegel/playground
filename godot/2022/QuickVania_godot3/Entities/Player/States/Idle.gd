extends BaseState


func enter() -> void:
	if target is Player:
		target.change_animation(name)
		target.velocity = Vector2.ZERO
		target.power_ups.is_doulbe_jump_used = false


func process(_delta: float) -> void:
	check_change_state()


func check_change_state() -> void:
	if target is Player:
		if not target.input.direction == 0:
			target.change_state("Move")

		var should_charge_attack = target.input.charge_attack and target.power_ups.is_charge_attack_active
		var should_dash = target.input.dash and target.power_ups.is_dash_active and target.can_dash

		if target.is_on_floor():
			if should_charge_attack:
				target.change_state("ChargingAttack")
				return

			if should_dash:
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
