class_name LevelManager extends Node2D

var maps = {
	"TestLevel": "res://Level/TestLevel.tscn",
	"TestLevel1": "res://Level/TestLevel1.tscn",
	"TestLevel2": "res://Level/TestLevel2.tscn",
}


func switch_to(area: String) -> void:
	var next_area_path: String = maps[area]
	var loaded_area: PackedScene = load(next_area_path)

	for level in get_children():
		level.queue_free()

	var next_area: Level = loaded_area.instance()

	next_area.stop_interactions()
	next_area.add_player_to_position()

	add_child(next_area)

	next_area.start_interactions()
