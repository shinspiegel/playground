class_name BaseLevel extends Node2D

@export var player_scene: PackedScene

var spawn_points: Array[Marker2D] = []


func _ready() -> void:
	setup_spawn_positions()


func spawn_player_at(position: int = 0):
	if position >= spawn_points.size():
		position = 0
	
	var player: Player = player_scene.instantiate()
	add_child(player)
	player.global_position = spawn_points[position].global_position


func setup_spawn_positions():
	for point in $SpawnPoints.get_children():
		if point is Marker2D:
			spawn_points.append(point)
