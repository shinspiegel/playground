extends Control

@onready var start: TextureButton = %Start
@onready var options: TextureButton = %Options
@onready var quit: TextureButton = %Quit


func _ready() -> void:
	start.pressed.connect(func(): SignalBus.start_game.emit())
	options.pressed.connect(func(): SignalBus.show_menu.emit("Options"))
	quit.pressed.connect(func(): get_tree().quit())
	draw.connect(func(): start.grab_focus())
