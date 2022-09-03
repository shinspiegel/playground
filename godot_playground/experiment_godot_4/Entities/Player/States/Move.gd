extends BaseState


func enter() -> void:
	if target is Player:
		target.change_animation(name)

func process(delta: float) -> void:
	if target is Player:
		target.apply_horizontal(target.input.direction)
		target.apply_gravity(delta)
