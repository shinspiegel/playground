class_name LevelManager extends Node2D

var current_area = null

var maps = {
	Areas.TestLevel0: "res://Level/AreaOne/TestLevel0.tscn",
	Areas.TestLevel1: "res://Level/AreaOne/TestLevel1.tscn",
	Areas.TestLevel2: "res://Level/AreaOne/TestLevel2.tscn",
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
