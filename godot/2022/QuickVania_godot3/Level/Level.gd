class_name Level extends Node2D

onready var entry_point_list = $EntryPoint

var player_scene = preload("res://Entities/Player/Player.tscn")


func start_interactions() -> void:
	print_debug("TODO: Initiate interaction on the level")


func stop_interactions() -> void:
	print_debug("TODO: Stop player interactions on the level")


func add_player_to_position(index: int) -> void:
	var list = entry_point_list.get_children()

	if index >= list.size():
		print_debug("INFO:: Teleport position out of bounds")
		index = 0

	var player = player_scene.instance()
	player.global_position = list[index].global_position
	add_child(player)
