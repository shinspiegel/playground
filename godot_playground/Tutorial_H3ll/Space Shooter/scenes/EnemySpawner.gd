extends Node2D

class_name EnemySpawner

const singleMonster = preload("res://scenes/monster_spawn_types/SingleMonster.tscn")
const duoMonster = preload("res://scenes/monster_spawn_types/DuoMonster.tscn")
const trioMonster = preload("res://scenes/monster_spawn_types/TrioMonster.tscn")
const trioVMonster = preload("res://scenes/monster_spawn_types/TrioVMonster.tscn")
const fourMonster = preload("res://scenes/monster_spawn_types/FourMonster.tscn")
const fourMonsterLine = preload("res://scenes/monster_spawn_types/FourMonterLine.tscn")

onready var spawnPointes = $SpawnPoint
onready var timer = $Timer

export (int) var level = 1

func get_spawn_position() -> Vector2:
	var points = spawnPointes.get_children()
	points.shuffle()
	return points[0].global_position

func get_monster_package() -> PackedScene:
	var list = [
		singleMonster,
		duoMonster,
		trioMonster,
		trioVMonster,
		fourMonster,
		fourMonsterLine
	]
	
	list.shuffle()
	return list[0]


func spawn_enemy(Scene: PackedScene):
	var enemy = Scene.instance()
	enemy.level = level
	var root = get_tree().current_scene
	root.add_child(enemy)
	enemy.global_position = get_spawn_position()


func _on_Timer_timeout() -> void:
	timer.wait_time = 1.0 - (level / 10)
	var enermy = get_monster_package()
	spawn_enemy(enermy)
