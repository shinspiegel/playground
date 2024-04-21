extends PlayerState

const player_shoot_scene: Resource = preload("res://scenes/actor/player/player_shot/player_shot.tscn")

@export var anim_player: AnimationPlayer


func _ready() -> void:
	anim_player.animation_finished.connect(on_anim_finished)


func enter() -> void:
	actor.change_animation(RANGED)
	actor.stats.consume_mana()
	actor.velocity = Vector2.ZERO
	spawn_shoot()


func update(_delta: float) -> void:
	actor.apple_direction(0, actor.data.friction_land, 1)
	actor.move_and_slide()
	actor.check_flip(actor.input.last_direction)


func on_anim_finished(anim: String) -> void:
	if anim == RANGED:
		if actor.input.direction > 0:
			state_machine.change_state(MOVE)
		else:
			state_machine.change_state(IDLE)


func spawn_shoot() -> void:
	var shot: PlayerShoot = player_shoot_scene.instantiate()
	shot.global_position = actor.shoot_pos.global_position
	shot.dir = clampi(int(actor.input.last_direction), -1, 1)
	GameManager.spawn(shot, 2)
