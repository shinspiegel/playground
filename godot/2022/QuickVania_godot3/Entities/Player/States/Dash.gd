extends BaseState


func enter() -> void:
	if target is Player:
		target.change_animation(name)
		target.velocity.y = 0.0
		target.dash_coldown.start()
		target.can_dash = false

		var con = target.animation_player.connect("animation_finished", self, "on_animation_finished")
		if not con == OK:
			print_debug("INFO:: Failed to connect [%s]" % [name])


func exit() -> void:
	if target is Player:
		target.animation_player.disconnect("animation_finished", self, "on_animation_finished")


func process(_delta: float) -> void:
	check_change_state()

	if target is Player:
		target.apply_horizontal(1.5, target.flip_direction)


func check_change_state() -> void:
	if target is Player:
		pass


## SIGNAL METHODS


func on_animation_finished(animation_name) -> void:
	if target is Player:
		if animation_name == name:
			target.change_state("Idle")

## SETUP METHODS
