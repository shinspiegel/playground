extends PlayerState

@export_range(0.1, 2.0, 0.1) var duration: float = 0.4
@export var dash_audio: AudioStream

var __direction: float = 0.0
var __speed_weight: float = 1.5
var __timer: SceneTreeTimer


func enter() -> void:
	__direction = player.input.last_direction
	__timer = get_tree().create_timer(duration)
	__timer.timeout.connect(on_timeout)

	player.change_animation(ROLL)
	player.velocity = Vector2.ZERO
	player.stats.consume_mana()
	player.dash_used = true


	AudioManager.create_sfx(dash_audio, randf_range(0.9, 1.2))


func exit() -> void:
	__timer.timeout.disconnect(on_timeout)


func update(delta: float) -> void:
	__direction = lerpf(__direction, 0, delta * __speed_weight)

	player.apply_direction(__direction, 1.0, 1.0, 3.0)
	player.move_and_slide()
	player.check_flip(__direction)


func on_timeout() -> void:
	if player.can_roll() and player.input.roll:
		state_machine.change_by_name(ROLL)
		return

	if player.input.just_jump and player.can_jump():
		state_machine.change_by_name(JUMP)
		return

	if player.should_fall():
		state_machine.change_by_name(FALLING)
		return

	if player.input.direction == 0.0:
		state_machine.change_by_name(IDLE)
		return

	state_machine.change_by_name(MOVE)

