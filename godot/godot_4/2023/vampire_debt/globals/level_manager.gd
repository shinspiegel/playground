class_name LevelManager extends Node

const levels = {
	"main": preload("res://main.tscn"),
	"game_over": preload("res://game_over.tscn"),
	"0": preload("res://levels/level_0.tscn"),
	"1": preload("res://levels/level_1.tscn"),
	"2": preload("res://levels/level_2.tscn"),
}

func reload_current_scene() -> void:
	GameManager.reset_score_to_start_level()
	get_tree().reload_current_scene()


func load_level(level: String) -> void:
	if levels.has(level): 
		GameManager.save_score()
		get_tree().change_scene_to_packed(levels[level])
	else:
		print_debug("Failed to load level with key:: [%s]" % [level])
