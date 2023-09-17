extends Control

@onready var start: TextureButton = %Start
@onready var options: TextureButton = %Options
@onready var quit: TextureButton = %Quit


func _ready() -> void:
	start.grab_focus()
	start.pressed.connect(on_start)
	options.pressed.connect(on_options)
	quit.pressed.connect(on_quit)
	PlayerData.reset()

func on_start() -> void:
	GameManager.change_scene("base_level")


func on_options() -> void:
	print_debug("WARN::Not implemented")


func on_quit() -> void:
	get_tree().quit()
