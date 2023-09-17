extends Node

signal created_node(scene: PackedScene, pos: Vector2)
signal spawned_damage(damage: Damage, pos: Vector2)

const SPEED = 6.0
const JUMP_VELOCITY = 12.0
const GRAVITY = 20.0
const MULTIPLIER = 100

const scenes = {
	"damage": preload("res://entities/damages/damage_number.tscn")
}

const levels = {
	"title": preload("res://main.tscn"),
	"base_level": preload("res://levels/base_level.tscn")
}


func change_scene(target: String) -> void:
	if levels.has(target):
		get_tree().change_scene_to_packed(levels[target])


func create_node(scene: PackedScene, position: Vector2 = Vector2.ZERO) -> void:
	created_node.emit(scene, position)


func get_speed(delta: float = 1.0) -> float:
	return SPEED * MULTIPLIER * delta


func spawn_damage_at(damage: Damage, position: Vector2 = Vector2.ZERO) -> void:
	spawned_damage.emit(damage, position)
