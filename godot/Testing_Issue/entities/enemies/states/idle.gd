extends BaseState


func enter() -> void:
	if target is Enemy:
		target.change_animation(name)
		target.velocity = Vector2.ZERO


func process(delta: float) -> void:
	if target is Enemy:
		target.apply_horizontal()
		target.apply_gravity(delta)
