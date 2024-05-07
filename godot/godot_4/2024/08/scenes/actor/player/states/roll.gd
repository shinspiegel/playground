extends PlayerState

@export var anim_player: AnimationPlayer
@export var damage_receiver: DamageReceiver
@export var roll_audio: AudioStream

var __start_dir: float = 0.0
var __direction_ratio: float = 1.0


func enter() -> void:
	player.change_animation(ROLL)
	damage_receiver.active = false
	anim_player.animation_finished.connect(on_anim_finished)

	__start_dir = player.input.last_direction
	__direction_ratio = 1.0

	if player.velocity.y < 0:
		player.velocity.y = 0

	player.stats.consume_mana()
	player.dash_used = true

	AudioManager.create_sfx(roll_audio, randf_range(0.8, 1.2))


func exit() -> void:
	damage_receiver.active = true
	anim_player.animation_finished.disconnect(on_anim_finished)


func update(delta: float) -> void:
	__direction_ratio = lerpf(__direction_ratio, 0, delta * 1.5)

	player.apply_gravity(delta)
	player.apply_direction(__start_dir, player.data.friction_land, 0.9, __direction_ratio)
	player.move_and_slide()
	player.check_flip(__start_dir)


func on_anim_finished(_anim: String) -> void:
	if player.input.direction == 0.0:
		state_machine.change_by_name(IDLE)
	else:
		state_machine.change_by_name(MOVE)

