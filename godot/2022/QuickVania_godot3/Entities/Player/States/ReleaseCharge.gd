extends BaseState


func enter() -> void:
	if target is Player:
		target.change_animation(name)
		target.animation_player.connect("animation_finished", self, "on_animation_finished")


func exit() -> void:
	if target is Player:
		target.animation_player.disconnect("animation_finished", self, "on_animation_finished")


func process(_delta: float) -> void:
	pass


## SIGNAL METHODS


func on_animation_finished(animation_name) -> void:
	if target is Player:
		if animation_name == name:
			target.change_state("Idle")

## SETUP METHODS
