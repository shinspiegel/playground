extends CanvasLayer

@export var intro_button: Button
@export var quit_button: Button


func _ready() -> void:
	quit_button.pressed.connect(func(): get_tree().quit())
	intro_button.pressed.connect(on_start)
	intro_button.grab_focus()


func on_start() -> void:
	GameManager.start_game()
	hide()


