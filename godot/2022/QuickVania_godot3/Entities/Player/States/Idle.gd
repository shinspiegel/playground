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

		if target.is_on_floor() and target.input.jump_press:
			target.change_state("Jump")

		if not target.is_on_floor():
			target.change_state("Falling")
