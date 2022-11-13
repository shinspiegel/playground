extends BaseState


func enter() -> void:
	if target is Player:
		target.change_animation(name)
		target.spawn_shot()


func process(delta: float) -> void:
	if target is Player:
		target.apply_horizontal()
		target.apply_gravity(delta)
