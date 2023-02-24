class_name Main extends Node2D

@onready var world_game: Node2D = $WordGame
@onready var card_game: CanvasLayer = $CardGame 


func _ready() -> void:
	start_world_game()
	SignalBus.battle_start_against.connect(start_card_game)
	SignalBus.battle_finished.connect(start_world_game)


func start_world_game() -> void:
	get_tree().paused = false
	card_game.hide()


func start_card_game(_target) -> void:
	get_tree().paused = true
	card_game.show()
