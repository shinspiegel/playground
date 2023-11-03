extends Control

@onready var start: Button = %Start
@onready var quit: Button = %Quit


func _ready() -> void:
	start.pressed.connect(on_start)
	quit.pressed.connect(on_quit)
	start.grab_focus()


func on_start() -> void:
	SceneManager.change_to_file("res://screens/level_selection/level_selection.tscn", 0.1)


func on_quit() -> void:
	SceneManager.quit()
