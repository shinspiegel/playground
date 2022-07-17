extends BaseState


func enter() -> void:
	if target is Player:
		target.change_animation(name)
		target.animation_player.connect("animation_finished", self, "on_animation_finished")


func exit() -> void:
	if target is Player:
		target.animation_player.disconnect("animation_finished", self, "on_animation_finished")


func process(_delta: float) -> void:
	check_change_state()

	if target is Player:
		target.velocity.x = move_toward(target.velocity.x, 0, 10)


func check_change_state() -> void:
	if target is Player:
		pass


## SIGNAL METHODS


func on_animation_finished(animation_name) -> void:
	if target is Player:
		if animation_name == "Attack":
			var last_state = target.state_manager.get_last_state()
			target.change_state(last_state)

## SETUP METHODS
