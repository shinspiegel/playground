extends PlayerState


func apply(delta: float) -> void:
	player.apply_gravity(delta)
	player.apply_direction()
	player.apply_model_facing_diretion()


func exit() -> void:
	player.anim_play(player.ANIM.RESET)