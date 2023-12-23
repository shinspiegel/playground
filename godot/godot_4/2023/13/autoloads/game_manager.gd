extends Node

signal player_died()
signal player_health_changed(current: int, max_health: int)
signal spawn_damage_number(pos: Vector2, damage: Damage)
signal spawn_shoot(shoot_scene: Node2D)
signal last_area_changed(pos: Vector2)

@export var delay_after_death: float = 1
@export var game_data: GameData


var __last_checkpoint: CheckPoint

func _ready() -> void:
	player_died.connect(on_player_die)


func reload_level() -> void:
	get_tree().reload_current_scene()


func set_checkpoint(check: CheckPoint) -> void:
	if not __last_checkpoint == check:
		if not __last_checkpoint == null:
			__last_checkpoint.disable()

		__last_checkpoint = check
		game_data.last_checkpoint_pos = check.global_position
		last_area_changed.emit(game_data.last_checkpoint_pos)


func get_last_checkpoint_pos() -> Vector2:
	return game_data.last_checkpoint_pos


func spawn_effect(effect_scene: PackedScene, position: Vector2 = Vector2.ZERO, direction: float = 1.0) -> void:
	var effect = effect_scene.instantiate()
	effect.global_position = position

	if effect is SelfFreeEffect:
		effect.set_direction(direction)

	get_tree().root.add_child(effect)


func on_player_die() -> void:
	await get_tree().create_timer(delay_after_death).timeout
	SceneManager.reload()
