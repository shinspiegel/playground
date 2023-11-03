extends Node

signal player_died()
@export var delay_after_death: float = 2

var __last_checkpoint: CheckPoint

func _ready() -> void:
	player_died.connect(on_player_die)


func reload_level() -> void:
	get_tree().reload_current_scene()


func set_checkpoint(check: CheckPoint) -> void:
	if not __last_checkpoint == check:
		if __last_checkpoint:
			__last_checkpoint.disable()
		
		__last_checkpoint = check


func spawn_effect(effect_scene: PackedScene, position: Vector2 = Vector2.ZERO, direction: float = 1.0) -> void:
	var effect = effect_scene.instantiate()
	effect.global_position = position
	
	if effect is SelfFreeEffect:
		effect.set_direction(direction)
	
	get_tree().root.add_child(effect)


func on_player_die() -> void:
	await get_tree().create_timer(delay_after_death).timeout
	SceneManager.reload()
