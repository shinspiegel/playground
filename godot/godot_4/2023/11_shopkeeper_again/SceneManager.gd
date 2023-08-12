extends Node

enum LEVELS {
	world_map,
	alchemy_lab,
}

const __preloaded_scenes = {
	LEVELS.world_map: preload("res://Levels/WorldMap/WorldMap.tscn"),
	LEVELS.alchemy_lab: preload("res://Levels/AlchemyLab/AlchemyLab.tscn"),
}


func change_to(area: LEVELS) -> void:
	if __preloaded_scenes.has(area):
		get_tree().change_scene_to_packed(__preloaded_scenes[area])
