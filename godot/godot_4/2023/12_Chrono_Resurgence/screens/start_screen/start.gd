extends Control

@onready var start: BaseButton = %Start
@onready var options: BaseButton = %Options
@onready var quit: BaseButton = %Quit


func _ready() -> void:
	start.grab_focus()
	start.pressed.connect(on_start)
	options.pressed.connect(on_options)
	quit.pressed.connect(on_quit)
	PlayerData.reset_health()


func on_start() -> void:
	SceneManager.change_scene("power_selection")


func on_options() -> void:
	SceneManager.change_scene("options")


func on_quit() -> void:
	get_tree().quit()
