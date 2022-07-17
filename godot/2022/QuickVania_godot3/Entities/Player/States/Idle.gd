extends BaseState


func enter() -> void:
	if target is Player:
		target.change_animation(name)
		target.velocity = Vector2.ZERO


func process(_delta: float) -> void:
	check_change_state()


func check_change_state() -> void:
	if target is Player:
		if not target.input.direction == 0:
			target.change_state("Move")
			return

		if target.is_on_floor():
			if target.input.jump_press:
				target.change_state("Jump")
				return

			if target.input.attack:
				target.change_state("Attack")
				return

		else:
			target.change_state("Falling")
			return
