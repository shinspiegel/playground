class_name GameManager extends Node2D


func _ready() -> void:
	Manager.screen.switch_to_start()


func start_game():
	# Manager.level.swith_to_level_at(Areas.TestLevel0, 0)
	Manager.level.switch_to_scene_at(Areas.Scene0)
	pass


func exit_game():
	get_tree().quit()
