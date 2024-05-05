@tool
class_name StartScreen extends Control

@onready var title: Label = $VBoxContainer/Title
@onready var version: Label = $Version
@onready var start: Button = %Start
@onready var options: Button = %Options
@onready var credits: Button = %Credits
@onready var quit: Button = %Quit


func _ready() -> void:
	AudioManager.play_music(0)

	title.text = ProjectSettings.get("application/config/name")
	version.text = "Version.%s" % ProjectSettings.get("application/config/version")
	start.grab_focus()
	start.pressed.connect(on_start)
	options.pressed.connect(on_options)
	credits.pressed.connect(on_credits)
	quit.pressed.connect(on_quit)


func on_start() -> void:
	SceneManager.change_to_level_selection()


func on_options() -> void:
	SceneManager.change_to_options()


func on_credits() -> void:
	SceneManager.change_to_credits()


func on_quit() -> void:
	SceneManager.quit()
