extends BaseState


func enter() -> void:
	if target is Player:
		target.is_flip_active = false
		target.change_animation(name)
		target.animation_player.connect("animation_finished", self, "on_animation_finished")


func exit() -> void:
	if target is Player:
		target.is_flip_active = true
		target.animation_player.disconnect("animation_finished", self, "on_animation_finished")


func process(delta: float) -> void:
	if target is Player:
		target.velocity.x = move_toward(target.velocity.x, 0, 10)
		target.apply_gravity(delta)


func receive_message(id: String, message) -> void:
	if target is Player:
		match id:
			"damage_hit_box":
				if message is HitBox:
					var direction = message.global_position.x - target.global_position.x
					var ratio_amount = (message.damage.power_x / 10) + 1.0
					var jump_amount = message.damage.power_y

					if direction < 0:
						direction = 1
					elif direction > 0:
						direction = -1
					else:
						direction = 0

					target.apply_horizontal(ratio_amount, direction)
					target.apply_vertical(jump_amount)
					target.hurt(message.damage.amount)


## SIGNAL METHODS


func on_animation_finished(animation_name) -> void:
	if target is Player:
		if animation_name == "Hit":
			target.change_state("Idle")
			
