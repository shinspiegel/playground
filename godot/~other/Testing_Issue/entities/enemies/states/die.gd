extends BaseState


func enter() -> void:
	if target is Enemy:
		target.change_animation(name)
		target.velocity = Vector2.ZERO
		target.flip.is_active = false
#		target.hurt_box.disable()
		target.hurt_box.call_deferred("disable")
		target.animation_player.animation_finished.connect(finish_hit)


func process(delta: float) -> void:
	if target is Enemy:
		target.apply_horizontal(0)
		target.apply_gravity(delta)


func finish_hit(_anim: String) -> void:
	target.queue_free()
