class_name GameManager extends Node2D


func _ready() -> void:
	Manager.screen.switch_to_start()
	# Helper.get_screen_manager().switch_to_start()
	# Helper.get_level_manager().switch_to("TestLevel", 0)


func start_game():
	Manager.level.switch_to("TestLevel", 0)
	# Helper.get_level_manager().switch_to("TestLevel", 0)


func exit_game():
	get_tree().quit()
