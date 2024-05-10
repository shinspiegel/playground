extends PlayerState

@export_range(0.1, 1.0, 0.1) var duration: float = 0.4
@export var damage_inflictor: DamageInflictor
@export var jab_audio: AudioStream

var __timer: SceneTreeTimer


func enter() -> void:
	player.change_animation(AIR_JAB)
	damage_inflictor.active = true
	__timer = get_tree().create_timer(duration)
	__timer.timeout.connect(on_timeout)
	AudioManager.create_sfx(jab_audio, randf_range(0.8, 1.4))


func exit() -> void:
	damage_inflictor.active = false
	__timer.timeout.disconnect(on_timeout)


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


func on_timeout() -> void:
	state_machine.change_by_name(IDLE)

