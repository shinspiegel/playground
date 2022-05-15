class_name LevelManager extends Node2D

var current_area: Level

var maps = {
	"TestLevel": "res://Level/TestLevel.tscn",
	"TestLevel1": "res://Level/TestLevel1.tscn",
	"TestLevel2": "res://Level/TestLevel2.tscn",
}


func stop_interaction() -> void:
	get_tree().paused = true


func start_interation() -> void:
	get_tree().paused = false


func switch_to(area: String, position: int) -> void:
	current_area = null

	var next_area_path: String = maps[area]
	var loaded_area: PackedScene = load(next_area_path)

	for level in get_children():
		level.queue_free()

	current_area = loaded_area.instance()
	add_child(current_area)
	current_area.add_player_to_position(position)
