extends PlayerState

const player_shoot_scene: Resource = preload("res://scenes/projectiles/player_shoot.tscn")

@export var anim_player: AnimationPlayer


func _ready() -> void:
	anim_player.animation_finished.connect(on_anim_finished)


func enter() -> void:
	player.change_animation(RANGED)
	player.stats.consume_mana()
	player.velocity = Vector2.ZERO
	spawn_shoot()


func update(delta: float) -> void:
	player.apply_gravity(delta)
	player.apply_direction(0, player.data.friction_land, 1)
	player.move_and_slide()
	player.check_flip(player.input.last_direction)


func on_anim_finished(anim: String) -> void:
	if anim == RANGED:
		if player.input.direction > 0:
			state_machine.change_by_name(MOVE)
		else:
			state_machine.change_by_name(IDLE)


func spawn_shoot() -> void:
	var shot: Projectile = player_shoot_scene.instantiate()
	shot.global_position = player.shoot_pos.global_position
	shot.dir = clampi(int(player.input.last_direction), -1, 1)
	GameManager.add_child_to_foreground(shot)
