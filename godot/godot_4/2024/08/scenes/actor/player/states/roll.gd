extends PlayerState

@export var anim_player: AnimationPlayer
@export var damage_receiver: DamageReceiver
@export var roll_audio: AudioStream

var __direction: float = 0.0


func enter() -> void:
	player.change_animation(ROLL)
	damage_receiver.active = false
	__direction = player.input.last_direction
	player.stats.consume_mana()
	anim_player.animation_finished.connect(on_anim_finished)
	AudioManager.create_sfx(roll_audio, randf_range(0.8, 1.2))


func exit() -> void:
	damage_receiver.active = true
	anim_player.animation_finished.disconnect(on_anim_finished)


func update(delta: float) -> void:
	__direction = lerpf(__direction, 0, delta * 1.5)

	player.apply_gravity(delta)
	player.apply_direction(__direction, player.data.friction_land, 0.9)
	player.move_and_slide()
	player.check_flip(__direction)


func on_anim_finished(_anim: String) -> void:
	if player.input.direction == 0.0:
		state_machine.change_by_name(IDLE)
	else:
		state_machine.change_by_name(MOVE)

