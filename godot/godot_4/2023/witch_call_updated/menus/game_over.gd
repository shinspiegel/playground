extends Control

@export var run_data: RunData

@onready var player_again: Button = %PlayAgain
@onready var quit: Button = %Quit
@onready var score: Label = %Score

func _ready() -> void:
	player_again.pressed.connect(func(): SignalBus.start_game.emit())
	player_again.grab_focus()
	quit.pressed.connect(func(): get_tree().quit())
	SignalBus.player_died.connect(func(): score.text = str(run_data.score))
	draw.connect(func(): player_again.grab_focus())
