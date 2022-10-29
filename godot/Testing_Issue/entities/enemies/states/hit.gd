extends BaseState


func enter() -> void:
	if target is Enemy:
		target.change_animation(name)
		target.velocity = Vector2.ZERO
		target.flip.is_active = false
		target.animation_player.animation_finished.connect(finish_hit)


func exit() -> void:
	if target is Enemy:
		target.flip.is_active = true
		target.animation_player.animation_finished.disconnect(finish_hit)


func process(delta: float) -> void:
	if target is Enemy:
		target.apply_gravity(delta)


func receive_message(id: String, message) -> void:
	if target is Enemy:
		match id:
			"hit":
				if message is HitBox:
					apply_hit(message)


func apply_hit(hit: HitBox) -> void:
	if target is Enemy:
		var diff = hit.global_position.x - target.global_position.x
		var direction = clampi(diff, -1, 1) * -1

		target.apply_horizontal(direction, hit.damage.power.x)
		target.apply_vertical(hit.damage.power.y)


func finish_hit(_anim) -> void:
	if target is Enemy:
		target.change_state("Idle")
