extends Node

signal created_node(scene: PackedScene, pos: Vector2)
signal spawned_damage(damage: Damage, pos: Vector2, scene: PackedScene)

const SPEED = 6.0
const JUMP_VELOCITY = 12.0
const GRAVITY = 20.0
const MULTIPLIER = 100

const SCENES = {
	"damage": preload("res://entities/damages/damage_number.tscn")
}

const LEVELS = {
	"base_level": preload("res://levels/base_level.tscn")
}

const SCREENS = {
	"main": preload("res://main.tscn"),
	"title": preload("res://screens/start_screen/start.tscn"),
	"options": preload("res://screens/options_screen/options_screen.tscn"),
	"power_selection": preload("res://screens/player_selection/player_selection.tscn"),
}


func change_scene(target) -> void:
	if target is String:
		if LEVELS.has(target):
			get_tree().change_scene_to_packed(LEVELS[target])
		elif SCREENS.has(target):
			get_tree().change_scene_to_packed(SCREENS[target])
	elif target is PackedScene:
		get_tree().change_scene_to_packed(target)
	else:
		print_debug("WARN::Could not locate scene to change for [%s]" % [target])


func create_node(scene: PackedScene, position: Vector2 = Vector2.ZERO) -> void:
	created_node.emit(scene, position)


func get_speed(delta: float = 1.0) -> float:
	return SPEED * MULTIPLIER * delta


func spawn_damage_at(damage: Damage, position: Vector2 = Vector2.ZERO, scene: PackedScene = SCENES.damage) -> void:
	spawned_damage.emit(damage, position, scene)
