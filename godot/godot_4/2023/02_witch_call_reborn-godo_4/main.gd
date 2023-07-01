extends Node2D

@export var game_data: GeneralGameData

@onready var menus: Menus = $Menus
@onready var game: Game = $Game


func _ready() -> void:
	SignalBus.show_menu.emit("MainMenu")
	SignalBus.play_menu_music.emit()
