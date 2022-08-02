class_name GameManager extends Node2D


func _ready() -> void:
	Manager.screen.switch_to_start()


func start_game():
	Manager.level.switch_to(Areas.TestLevel0)
	pass


func exit_game():
	get_tree().quit()
