extends BaseState


func enter() -> void:
	if target is Player:
		target.change_animation(name)
		target.enable_attack_hit_box()
		target.animation_player.animation_finished.connect(on_animation_finished)


func exit() -> void:
	if target is Player:
		target.disable_attack_hit_box()
		target.animation_player.animation_finished.disconnect(on_animation_finished)


func process(delta: float) -> void:
	if target is Player:
		target.apply_horizontal()
		target.apply_gravity(delta)


func on_animation_finished(_anim_name: StringName) -> void:
	if target is Player:
		target.change_state("Idle")
