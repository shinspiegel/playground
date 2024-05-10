class_name GameOverScreen extends Control

@onready var start: Button = %Start
@onready var credits: Button = %Credits
@onready var quit: Button = %Quit


func _ready() -> void:
	AudioManager.play_music_intro()
	start.pressed.connect(on_start)
	credits.pressed.connect(on_credits)
	quit.pressed.connect(on_quit)
	await get_tree().create_timer(1).timeout
	start.grab_focus()


func on_start() -> void:
	SceneManager.change_to_level_selection()


func on_credits() -> void:
	SceneManager.change_to_credits()


func on_quit() -> void:
	SceneManager.quit()
