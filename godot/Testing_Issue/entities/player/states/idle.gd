extends BaseState


func enter() -> void:
	if target is Player:
		target.change_animation(name)
		target.velocity = Vector2.ZERO

func process(delta: float) -> void:
	if target is Player:
		target.apply_horizontal(target.input.direction)
		target.apply_gravity(delta)