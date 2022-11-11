extends BaseState


func enter() -> void:
	if target is Player:
		target.animation_player.play(name)
		target.velocity.y = 0


func process(delta: float) -> void:
	if target is Player:
		target.apply_horizontal(target.input.direction, target.speed, 0.7)
		target.apply_gravity(delta)

