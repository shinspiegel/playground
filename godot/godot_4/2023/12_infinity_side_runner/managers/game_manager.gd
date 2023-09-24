extends Node

signal created_node(scene: PackedScene, pos: Vector2)
signal spawned_damage(damage: Damage, pos: Vector2, scene: PackedScene)
signal shake_created(amount: float)

const SPEED = 6.0
const JUMP_VELOCITY = 12.0
const GRAVITY = 20.0
const MULTIPLIER = 100

const SCENES = {
	"damage": preload("res://entities/damages/damage_number.tscn")
}

const LEVELS = {
	"base_level": preload("res://levels/base_level.tscn"),
	"city_level": preload("res://levels/city_level.tscn"),
}

const SCREENS = {
	"main": preload("res://main.tscn"),
	"start": preload("res://screens/start_screen/start.tscn"),
	"options": preload("res://screens/options_screen/options_screen.tscn"),
	"power_selection": preload("res://screens/player_selection/player_selection.tscn"),
	"game_over": preload("res://screens/game_over_screen/game_over.tscn"),
}


func change_scene(target: String) -> void:
	if LEVELS.has(target):
		get_tree().change_scene_to_packed(LEVELS[target])
	elif SCREENS.has(target):
		get_tree().change_scene_to_packed(SCREENS[target])
	else:
		print_debug("WARN::Could not locate scene to change for [%s]" % [target])


func create_node(scene: PackedScene, position: Vector2 = Vector2.ZERO) -> void:
	created_node.emit(scene, position)


func get_speed(delta: float = 1.0) -> float:
	return SPEED * MULTIPLIER * delta


func spawn_damage_at(damage: Damage, position: Vector2 = Vector2.ZERO, scene: PackedScene = SCENES.damage) -> void:
	spawned_damage.emit(damage, position, scene)


func invoque_shake(force: float) -> void:
	shake_created.emit(force)