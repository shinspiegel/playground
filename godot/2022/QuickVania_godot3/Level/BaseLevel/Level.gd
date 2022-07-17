class_name Level extends Node2D

export(PackedScene) var player_scene

onready var entry_point_list = $EntryPoint
onready var map_limit = {"top_left": $MapLimit/TopLeft, "bottom_right": $MapLimit/BottomRight}


func get_level_size() -> Vector2:
	return get_tree().root.get_texture().get_size()


func add_player_to_position(index: int) -> void:
	var list = entry_point_list.get_children()

	if index >= list.size():
		print_debug("INFO:: Teleport out of bounds, set default to '0'. [%s]" % [name])
		index = 0

	var player = player_scene.instance()
	player.global_position = list[index].global_position

	var top = map_limit.top_left.global_position.y
	var left = map_limit.top_left.global_position.x
	var bottom = map_limit.bottom_right.global_position.y
	var right = map_limit.bottom_right.global_position.x

	player.add_camera(top, bottom, left, right)

	add_child(player)
