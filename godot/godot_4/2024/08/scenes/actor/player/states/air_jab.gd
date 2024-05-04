extends PlayerState

@export var anim_player: AnimationPlayer
@export var damage_inflictor: DamageInflictor
@export var jab_audio: AudioStream


func enter() -> void:
	player.change_animation(AIR_JAB)
	damage_inflictor.active = true
	anim_player.animation_finished.connect(on_anim_finished)
	AudioManager.create_sfx(jab_audio, randf_range(0.8, 1.4))


func exit() -> void:
	damage_inflictor.active = false
	anim_player.animation_finished.disconnect(on_anim_finished)


func update(delta: float) -> void:
	if damage_inflictor.active:
		damage_inflictor.active = false

	if player.is_on_floor():
		if player.input.direction == 0.0:
			state_machine.change_by_name(IDLE)
			return
		else:
			state_machine.change_by_name(MOVE)
			return

	player.apply_gravity(delta)
	player.apply_direction(player.input.direction, player.data.friction_air, 0.05, 0.8)
	player.move_and_slide()
	player.check_flip(player.input.last_direction)


func on_anim_finished(_anim: String) -> void:
	state_machine.change_by_name(IDLE)

