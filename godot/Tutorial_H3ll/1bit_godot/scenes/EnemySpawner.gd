extends Node2D

const Enemy = preload("res://scenes/Enemy.tscn")

onready var spawnPointes = $SpawnPoint

func get_spawn_position() -> Vector2:
	var points = spawnPointes.get_children()
	points.shuffle()
	return points[0].global_position


func spawn_enemy():
	var enemy = Enemy.instance()
	var root = get_tree().current_scene
	root.add_child(enemy)
	enemy.global_position = get_spawn_position()


func _on_Timer_timeout() -> void:
	spawn_enemy()
