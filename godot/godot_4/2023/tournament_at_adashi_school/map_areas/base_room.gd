class_name BaseRoom extends Node2D

@export var player_scene: PackedScene
@export var camera: Camera2D

var spawn_points: Array[Marker2D]
var player_spawn_index: int = 0


func _ready() -> void:
	get_spawn_points()
	add_player_at(player_spawn_index)


func get_spawn_points() -> void:
	for node in $PlayerSpawnPoint.get_children():
		if node is Marker2D:
			spawn_points.append(node)


func add_player_at(index: int) -> void:
	var player_instance: Player = player_scene.instantiate()
	player_instance.camera_node = camera
	add_child(player_instance)
	
	if index > spawn_points.size():
		index = 0
	
	player_instance.global_position = spawn_points[index].global_position
