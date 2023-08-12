extends Node

enum LEVELS {
	world_map
}

const levels = {
	LEVELS.world_map: preload("res://Levels/WorldMap/WorldMap.tscn"),
}


func change_to(area: LEVELS) -> void:
	if levels.has(area):
		get_tree().change_scene_to_packed(levels[area])
