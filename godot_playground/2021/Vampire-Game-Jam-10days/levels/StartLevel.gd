extends Control

onready var startButton: TextureButton = $CenterContainer/VBoxContainer/StartButton
onready var quitButton: TextureButton = $CenterContainer/VBoxContainer/Quit

func _ready() -> void:
	startButton.grab_focus()


func _on_StartButton_pressed() -> void:
	get_tree().change_scene("res://levels/Level_1.tscn")


func _on_Quit_pressed() -> void:
	get_tree().quit()
