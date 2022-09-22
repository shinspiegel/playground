class_name BaseLevel extends Node2D

@export var player_scene: PackedScene

var spawn_points: Array[Marker2D] = []


func _ready() -> void:
	for point in $SpawnPoints.get_children():
		if point is Marker2D:
			spawn_points.append(point)


func spawn_player_at(spawn_position: int = 0):
	if spawn_position >= spawn_points.size():
		spawn_position = 0
	
	var player: Player = player_scene.instantiate()
	add_child(player)
	player.global_position = spawn_points[spawn_position].global_position


