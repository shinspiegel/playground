extends BaseState


func enter() -> void:
	if target is Player:
		target.velocity.x = (target.input.direction * -1) * target.speed
		target.velocity.y = (target.jump_velocity * 0.1)
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


## SIGNAL METHODS


func on_animation_finished(animation_name) -> void:
	if target is Player:
		if animation_name == "Hit":
			var last_state = target.state_manager.get_last_state()
			target.change_state(last_state)
