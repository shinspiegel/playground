extends Node

signal created_node(scene: PackedScene, pos: Vector2)
signal spawned_damage(damage: Damage, pos: Vector2, scene: PackedScene)
signal shake_created(amount: float)

const GRAVITY = 20.0
const MULTIPLIER = 100

const SCENES = {
	"damage": preload("res://entities/damages/damage_number.tscn")
}


func create_node(scene: PackedScene, position: Vector2 = Vector2.ZERO) -> void:
	created_node.emit(scene, position)


func spawn_damage_at(damage: Damage, position: Vector2 = Vector2.ZERO, scene: PackedScene = SCENES.damage) -> void:
	spawned_damage.emit(damage, position, scene)


func invoque_shake(force: float) -> void:
	shake_created.emit(force)