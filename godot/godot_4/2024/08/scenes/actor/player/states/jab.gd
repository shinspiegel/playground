extends PlayerState

@export_range(0.1, 1.0, 0.1) var duration: float = 0.4
@export var damage_inflictor: DamageInflictor
@export var jab_audio: AudioStream

var __timer: SceneTreeTimer

func enter() -> void:
	player.change_animation(JAB)
	damage_inflictor.active = true
	damage_inflictor.target_hit.connect(on_target_hit)
	__timer = get_tree().create_timer(duration)
	__timer.timeout.connect(on_timeout)
	AudioManager.create_sfx(jab_audio, randf_range(0.8, 1.4))


func exit() -> void:
	damage_inflictor.active = false
	damage_inflictor.target_hit.disconnect(on_target_hit)
	__timer.timeout.disconnect(on_timeout)


func update(delta: float) -> void:
	player.apply_gravity(delta)
	player.apply_direction(0, player.data.friction_land, 0.9)
	player.move_and_slide()
	player.check_flip(player.input.last_direction)

	if damage_inflictor.active:
		damage_inflictor.active = false


func on_timeout() -> void:
	state_machine.change_by_name(IDLE)


func on_target_hit(_target: DamageReceiver) -> void:
	damage_inflictor.active = false
