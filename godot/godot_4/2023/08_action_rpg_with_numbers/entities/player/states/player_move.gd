extends PlayerState


func enter() -> void:
	player.anim_player.play("Move")


func apply(delta: float) -> void:
	player.apply_gravity(delta)
	player.apply_direction()
	player.apply_model_facing_diretion()
