extends Control

@onready var start = %Start
@onready var options = %Options
@onready var quit = %Quit


func _ready() -> void:
	start.pressed.connect(func(): SignalBus.start_game.emit())
	options.pressed.connect(func(): SignalBus.show_menu.emit("Options"))
	quit.pressed.connect(func(): get_tree().quit())
	draw.connect(func(): start.grab_focus())
