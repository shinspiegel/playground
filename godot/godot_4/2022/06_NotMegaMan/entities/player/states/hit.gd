extends BaseState


func enter() -> void:
	if target is Player:
		target.change_animation(name)
		target.velocity = Vector2.ZERO
		target.flip.is_active = false
		target.animation_player.animation_finished.connect(finish_hit)


func exit() -> void:
	if target is Player:
		target.flip.is_active = true
		target.animation_player.animation_finished.disconnect(finish_hit)


func process(delta: float) -> void:
	if target is Player:
		target.apply_gravity(delta)


func receive_message(id: String, message = null) -> void:
	if target is Player:
		match id:
			"hit":
				if message is HitBox:
					apply_hit(message)


func apply_hit(hit: HitBox) -> void:
	if target is Player:
		var diff: float = hit.global_position.x - target.global_position.x
		var direction: int = clampi(int(diff), -1, 1) * -1

		target.apply_horizontal(direction, hit.damage.power.x)
		target.apply_vertical(hit.damage.power.y)


func finish_hit(_anim) -> void:
	if target is Player:
		target.change_state("Idle")
