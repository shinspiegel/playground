extends EnemyState

@export var anim_player: AnimationPlayer
@export var next_state: EnemyState
@export var shoot_scene: PackedScene
@export var shoot_pos: Node2D


func _ready() -> void:
	anim_player.animation_finished.connect(on_anim_finished)


func enter() -> void:
	play_anim()
	connect_damage_hit()
	shoot()


func exit() -> void:
	disconnect_damage_hit()


func update(delta: float) -> void:
	enemy.apply_gravity(delta)
	enemy.move_and_slide()


func on_anim_finished(anim: String) -> void:
	if anim == name:
		if not next_state == null:
			state_machine.change_by_state(next_state)
		else:
			state_machine.change_initial()


func shoot() -> void:
	var shot: Projectile = shoot_scene.instantiate()
	shot.global_position = shoot_pos.global_position
	shot.dir = clampi(int(enemy.direction), -1, 1)
	GameManager.add_child_to_foreground(shot)

