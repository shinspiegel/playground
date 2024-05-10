extends PlayerState

const player_shoot_scene: Resource = preload("res://scenes/projectiles/player_shoot.tscn")

@export_range(0.1, 1.0, 0.1) var duration: float = 0.4
@export var ranged_sound: AudioStream

var __timer: SceneTreeTimer


func enter() -> void:
	player.change_animation(RANGED)
	player.stats.consume_mana()
	player.velocity = Vector2.ZERO
	__timer = get_tree().create_timer(duration)
	__timer.timeout.connect(on_timeout)
	spawn_shoot()
	AudioManager.create_sfx(ranged_sound, randf_range(0.9, 1.5))


func exit() -> void:
	__timer.timeout.disconnect(on_timeout)


func update(delta: float) -> void:
	player.apply_gravity(delta)
	player.apply_direction(0, player.data.friction_land, 1)
	player.move_and_slide()
	player.check_flip(player.input.last_direction)


func on_timeout() -> void:
	if player.input.direction > 0:
		state_machine.change_by_name(MOVE)
	else:
		state_machine.change_by_name(IDLE)


func spawn_shoot() -> void:
	var shot: Projectile = player_shoot_scene.instantiate()
	shot.global_position = player.shoot_pos.global_position
	shot.dir = clampi(int(player.input.last_direction), -1, 1)
	GameManager.add_child_to_foreground(shot)
