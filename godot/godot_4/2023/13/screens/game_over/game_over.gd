extends Control

@onready var start: Button = %StartAgain
@onready var quit: Button = %Quit


func _ready() -> void:
	start.pressed.connect(on_start)
	quit.pressed.connect(on_quit)
	start.grab_focus()


func on_start() -> void:
	SceneManager.change_to_file("res://screens/game_over/game_over.tscn", 0.1)


func on_quit() -> void:
	get_tree().quit()
