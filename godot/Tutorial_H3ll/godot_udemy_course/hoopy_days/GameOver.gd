extends Control

func reset_game():
	get_tree().change_scene("res://Levels/Level1.tscn")

func _process(delta):
	if Input.is_action_pressed("ui_accept"):
		reset_game()

func _on_TextureButton_button_up():
	reset_game()