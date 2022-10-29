extends BaseState


func enter() -> void:
	if target is Player:
		target.change_animation(name)
		target.velocity = Vector2.ZERO
		target.flip.is_active = false
		target.animation_player.animation_finished.connect(finish_hit)
		target.input.is_enabled = false
		target.hurt_box.disable()


func process(delta: float) -> void:
	if target is Player:
		target.apply_horizontal(0)
		target.apply_gravity(delta)


func finish_hit(_anim) -> void:
	SignalBus.player_died.emit()
