extends BaseState


func enter() -> void:
	if target is Player:
		target.change_animation(name)
		target.apply_vertical(target.jump_power)

func process(delta: float) -> void:
	if target is Player:
		target.apply_horizontal(target.input.direction, target.SPEED, 0.7)
		target.apply_gravity(delta)
