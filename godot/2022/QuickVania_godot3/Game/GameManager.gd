class_name GameManager extends CanvasLayer


func start_game():
	Helper.get_level_manager().switch_to("TestLevel")


func exit_game():
	get_tree().quit()
