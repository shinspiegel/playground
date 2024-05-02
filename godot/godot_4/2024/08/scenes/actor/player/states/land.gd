extends PlayerState

@export var anim_player: AnimationPlayer


func enter() -> void:
	player.change_animation(LAND)
	anim_player.animation_finished.connect(on_anim_finished)


func exit() -> void:
	anim_player.animation_finished.disconnect(on_anim_finished)


func update(delta: float) -> void:
	player.apply_gravity(delta)
	player.apply_direction(0.0, player.data.friction_land, 0.1)
	player.move_and_slide()
	player.check_flip(player.input.last_direction)


func on_anim_finished(_anim: String) -> void:
	state_machine.change_by_name(IDLE)

