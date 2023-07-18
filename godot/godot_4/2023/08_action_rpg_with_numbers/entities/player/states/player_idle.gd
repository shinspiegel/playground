extends PlayerState


func enter() -> void:
	player.anim_play(player.ANIM.IDLE)


func apply(delta: float) -> void:
	player.apply_gravity(delta)
	player.apply_direction()
	player.apply_model_facing_diretion()
