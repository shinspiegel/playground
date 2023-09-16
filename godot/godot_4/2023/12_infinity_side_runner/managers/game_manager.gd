extends Node

signal created_node(scene: PackedScene, position: Vector2)

const SPEED = 6.0
const JUMP_VELOCITY = -12.0
const GRAVITY = 20.0
const MULTIPLIER = 100

const levels = {
	"title": preload("res://main.tscn"),
	"test": preload("res://levels/test_level.tscn"),
}


func change_scene(target: String) -> void:
	if levels.has(target):
		get_tree().change_scene_to_packed(levels[target])


func create_node(scene: PackedScene, position: Vector2 = Vector2.ZERO) -> void:
	created_node.emit(scene, position)
