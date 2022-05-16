class_name GameManager extends Node2D


func _ready() -> void:
	Manager.screen.switch_to_start()


func start_game():
	Manager.level.switch_to("TestLevel", 0)


func exit_game():
	get_tree().quit()
