extends Control

@export var run_data: RunData

@onready var player_again: TextureButton = %PlayAgain
@onready var quit: TextureButton = %Quit
@onready var score: Label = %Score


func _ready() -> void:
	player_again.pressed.connect(func(): SignalBus.start_game.emit())
	player_again.grab_focus()
	quit.pressed.connect(func(): get_tree().quit())
	draw.connect(on_draw)


func on_draw() -> void:
	player_again.grab_focus()
	score.text = str(run_data.score)
