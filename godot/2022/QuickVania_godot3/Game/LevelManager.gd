class_name LevelManager extends Node2D

var current_area = null


func stop_interaction() -> void:
	get_tree().paused = true


func start_interation() -> void:
	get_tree().paused = false


func switch_to(destination: String, position: int = 0) -> void:
	if destination in Areas.maps:
		swith_to_level_at(destination, position)

	if destination in Areas.scenes:
		switch_to_scene_at(destination)


func swith_to_level_at(area: String, position: int) -> void:
	current_area = null

	var next_area_path: String = Areas.maps[area]
	var loaded_area: PackedScene = load(next_area_path)

	for level in get_children():
		level.queue_free()

	current_area = loaded_area.instance()
	add_child(current_area)
	current_area.add_player_to_position(position)


func switch_to_scene_at(area: String) -> void:
	current_area = null

	var next_scene_path: String = Areas.scenes[area]
	var loaded_area: PackedScene = load(next_scene_path)

	for level in get_children():
		level.queue_free()

	current_area = loaded_area.instance()
	add_child(current_area)
