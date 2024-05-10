extends PlayerState

@export_range(0.1, 1.0, 0.1) var duration: float = 0.4
@export var sprite: Sprite2D
@export var damage_receiver: DamageReceiver
@export var roll_audio: AudioStream

var __start_dir: float = 0.0
var __direction_ratio: float = 1.0
var __timer: SceneTreeTimer


func enter() -> void:
	player.change_animation(ROLL)
	damage_receiver.active = false

	sprite.material.set_shader_parameter("line_thickness", 0.0)
	__timer = get_tree().create_timer(duration)
	__timer.timeout.connect(on_timeout)

	__start_dir = player.input.last_direction
	__direction_ratio = 1.0

	if player.velocity.y < 0:
		player.velocity.y = 0

	player.stats.consume_mana()
	player.dash_used = true

	AudioManager.create_sfx(roll_audio, randf_range(0.8, 1.2))


func exit() -> void:
	damage_receiver.active = true
	sprite.material.set_shader_parameter("line_thickness", 1.0)
	__timer.timeout.disconnect(on_timeout)


func update(delta: float) -> void:
	__direction_ratio = lerpf(__direction_ratio, 0, delta * 1.5)

	player.apply_gravity(delta)
	player.apply_direction(__start_dir, player.data.friction_land, 0.9, __direction_ratio)
	player.move_and_slide()
	player.check_flip(__start_dir)


func on_timeout() -> void:
	if player.input.direction == 0.0:
		state_machine.change_by_name(IDLE)
	else:
		state_machine.change_by_name(MOVE)

