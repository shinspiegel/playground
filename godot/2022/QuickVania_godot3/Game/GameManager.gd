class_name GameManager extends Node2D


func _ready() -> void:
	Helper.get_screen_manager().switch_to_start()
	# Helper.get_level_manager().switch_to("TestLevel", 0)


func start_game():
	Helper.get_level_manager().switch_to("TestLevel", 0)


func exit_game():
	get_tree().quit()
