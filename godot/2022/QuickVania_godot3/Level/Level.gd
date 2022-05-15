class_name Level extends Node2D

export(PackedScene) var player_scene

onready var entry_point_list = $EntryPoint


func add_player_to_position(index: int) -> void:
	var list = entry_point_list.get_children()

	if index >= list.size():
		print_debug("INFO:: Teleport position out of bounds")
		index = 0

	var player = player_scene.instance()
	player.global_position = list[index].global_position
	add_child(player)
