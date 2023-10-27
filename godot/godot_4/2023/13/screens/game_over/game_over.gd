extends Control

@onready var start: Button = %StartAgain
@onready var quit: Button = %Quit

func _ready() -> void:
	start.pressed.connect(on_start)
	quit.pressed.connect(on_quit)
	start.grab_focus()


func on_start() -> void:
	pass


func on_quit() -> void:
	get_tree().quit()
